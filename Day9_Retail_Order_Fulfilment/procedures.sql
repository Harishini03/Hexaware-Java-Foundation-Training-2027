-- Day 9: Stored procedure, function, transaction and SIGNAL
USE retail_inventory;

DROP PROCEDURE IF EXISTS sp_place_order;
DELIMITER $$
CREATE PROCEDURE sp_place_order(
    IN p_customer_id INT,
    IN p_sku VARCHAR(20),
    IN p_quantity INT,
    IN p_warehouse_id INT,
    OUT p_order_no BIGINT
)
BEGIN
    DECLARE v_stock INT DEFAULT NULL;
    DECLARE v_price DECIMAL(10,2) DEFAULT NULL;
    DECLARE v_order_no BIGINT DEFAULT NULL;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_order_no = NULL;
        RESIGNAL;
    END;

    SET p_order_no = NULL;

    IF p_quantity IS NULL OR p_quantity <= 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Quantity must be greater than zero';
    END IF;

    START TRANSACTION;

    -- Lock the inventory row so two orders cannot spend the same stock.
    SELECT quantity INTO v_stock
    FROM inventory
    WHERE sku = p_sku AND warehouse_id = p_warehouse_id
    FOR UPDATE;

    IF v_stock IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Product is not stocked in this warehouse';
    END IF;

    IF v_stock < p_quantity THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Insufficient stock for this order';
    END IF;

    SELECT selling_price INTO v_price
    FROM product_price
    WHERE sku = p_sku;

    IF v_price IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Selling price is not configured for this product';
    END IF;

    INSERT INTO fulfilment_order (customer_id, warehouse_id)
    VALUES (p_customer_id, p_warehouse_id);

    SET v_order_no = LAST_INSERT_ID();

    INSERT INTO fulfilment_order_line (order_no, sku, quantity, unit_price)
    VALUES (v_order_no, p_sku, p_quantity, v_price);

    UPDATE inventory
    SET quantity = quantity - p_quantity
    WHERE sku = p_sku AND warehouse_id = p_warehouse_id;

    COMMIT;
    SET p_order_no = v_order_no;
END$$
DELIMITER ;

-- Stored function: returns the order-line total after adding tax.
DROP FUNCTION IF EXISTS fn_order_total_with_tax;
DELIMITER $$
CREATE FUNCTION fn_order_total_with_tax(
    p_quantity INT,
    p_unit_price DECIMAL(10,2),
    p_tax_percent DECIMAL(5,2)
)
RETURNS DECIMAL(12,2)
DETERMINISTIC
NO SQL
BEGIN
    RETURN ROUND(p_quantity * p_unit_price * (1 + p_tax_percent / 100), 2);
END$$
DELIMITER ;

-- Successful example: SKU001 has stock in warehouse 1 from Day 5 sample data.
SET @created_order_no = NULL;
CALL sp_place_order(1001, 'SKU001', 2, 1, @created_order_no);
SELECT @created_order_no AS created_order_number;

SELECT
    order_no,
    sku,
    quantity,
    unit_price,
    fn_order_total_with_tax(quantity, unit_price, 18.00) AS total_with_18_percent_tax
FROM fulfilment_order_line
WHERE order_no = @created_order_no;

-- Business-error demonstration. Run this CALL separately.
-- The request is intentionally larger than available stock and should roll back.
-- SET @failed_order_no = NULL;
-- CALL sp_place_order(1002, 'SKU001', 9999, 1, @failed_order_no);
