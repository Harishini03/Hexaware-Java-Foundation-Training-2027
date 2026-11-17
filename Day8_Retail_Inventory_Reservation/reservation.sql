-- DAY 8: RETAIL INVENTORY RESERVATION TRANSACTION
-- MySQL 8.4 LTS / InnoDB
-- Prerequisite: Day 5 schema + seed, then Day 6 setup + seed.
USE retail_inventory;

DROP PROCEDURE IF EXISTS reserve_stock_order;
DELIMITER $$

CREATE PROCEDURE reserve_stock_order(
    IN p_order_id INT,
    IN p_order_item_id INT,
    IN p_customer_id INT,
    IN p_store_id INT,
    IN p_employee_id INT,
    IN p_warehouse_id INT,
    IN p_sku VARCHAR(20),
    IN p_quantity INT,
    IN p_unit_price DECIMAL(10,2)
)
BEGIN
    DECLARE v_available INT DEFAULT NULL;

    -- Any SQL error rolls back the complete order operation.
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    IF p_quantity <= 0 OR p_unit_price < 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Quantity must be positive and price cannot be negative';
    END IF;

    START TRANSACTION;

    -- Lock the selected inventory row so concurrent reservations cannot
    -- both consume the same available quantity.
    SELECT quantity
      INTO v_available
      FROM inventory
     WHERE sku = p_sku
       AND warehouse_id = p_warehouse_id
     FOR UPDATE;

    IF v_available IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No inventory row exists for this SKU and warehouse';
    END IF;

    IF v_available < p_quantity THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Insufficient stock; order was rolled back';
    END IF;

    INSERT INTO sales_order
        (order_id,customer_id,store_id,employee_id,order_date,order_status)
    VALUES
        (p_order_id,p_customer_id,p_store_id,p_employee_id,NOW(),'PLACED');

    UPDATE inventory
       SET quantity = quantity - p_quantity
     WHERE sku = p_sku
       AND warehouse_id = p_warehouse_id
       AND quantity >= p_quantity;

    IF ROW_COUNT() <> 1 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Stock update failed; order was rolled back';
    END IF;

    INSERT INTO order_item
        (order_item_id,order_id,sku,quantity,unit_price)
    VALUES
        (p_order_item_id,p_order_id,p_sku,p_quantity,p_unit_price);

    COMMIT;
END$$

DELIMITER ;

-- A. Record the stock before testing.
SELECT sku,warehouse_id,quantity
FROM inventory
WHERE sku='SKU001' AND warehouse_id=1;

-- B. ROLLBACK TEST (intentional failure).
-- The requested quantity is deliberately much greater than available stock.
-- Expected: procedure raises "Insufficient stock; order was rolled back".
-- Because the exception handler executes ROLLBACK, order 9001 and its item
-- are not retained, and SKU001 stock remains unchanged.
CALL reserve_stock_order(9001,90001,1,1,2,1,'SKU001',999999,799.00);

-- Run these verification statements after the expected error.
SELECT sku,warehouse_id,quantity
FROM inventory
WHERE sku='SKU001' AND warehouse_id=1;

SELECT * FROM sales_order WHERE order_id=9001;
SELECT * FROM order_item WHERE order_id=9001;

-- C. SUCCESS TEST (run after confirming the rollback test).
-- Reserves two units, creates the order and order line, then commits.
CALL reserve_stock_order(9002,90002,1,1,2,1,'SKU001',2,799.00);

SELECT sku,warehouse_id,quantity
FROM inventory
WHERE sku='SKU001' AND warehouse_id=1;

SELECT so.order_id,so.order_status,oi.sku,oi.quantity,oi.unit_price
FROM sales_order so
JOIN order_item oi ON oi.order_id=so.order_id
WHERE so.order_id=9002;

-- D. Optional manual rollback demonstration without the procedure.
-- Execute the statements one at a time in the same session:
-- START TRANSACTION;
-- UPDATE inventory SET quantity=quantity-1
-- WHERE sku='SKU001' AND warehouse_id=1 AND quantity>=1;
-- SELECT sku,warehouse_id,quantity FROM inventory
-- WHERE sku='SKU001' AND warehouse_id=1;
-- ROLLBACK;
-- SELECT sku,warehouse_id,quantity FROM inventory
-- WHERE sku='SKU001' AND warehouse_id=1;
