-- Day 9: Cursor and set-based alternative
USE retail_inventory;

-- Add a few old orders so the demonstration has rows to process.
INSERT INTO fulfilment_order (customer_id, warehouse_id, order_date)
SELECT 2001, 1, NOW() - INTERVAL 5 DAY
WHERE NOT EXISTS (
    SELECT 1 FROM fulfilment_order
    WHERE customer_id = 2001 AND order_date < NOW() - INTERVAL 3 DAY
);

INSERT INTO fulfilment_order (customer_id, warehouse_id, order_date)
SELECT 2002, 1, NOW() - INTERVAL 4 DAY
WHERE NOT EXISTS (
    SELECT 1 FROM fulfilment_order
    WHERE customer_id = 2002 AND order_date < NOW() - INTERVAL 3 DAY
);

DROP PROCEDURE IF EXISTS sp_queue_old_orders_cursor;
DELIMITER $$
CREATE PROCEDURE sp_queue_old_orders_cursor()
BEGIN
    DECLARE v_order_no BIGINT;
    DECLARE v_done BOOLEAN DEFAULT FALSE;

    DECLARE order_cursor CURSOR FOR
        SELECT order_no
        FROM fulfilment_order
        WHERE order_status = 'PLACED'
          AND order_date < NOW() - INTERVAL 3 DAY
          AND order_no NOT IN (SELECT order_no FROM order_follow_up);

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = TRUE;

    OPEN order_cursor;

    read_loop: LOOP
        FETCH order_cursor INTO v_order_no;

        IF v_done THEN
            LEAVE read_loop;
        END IF;

        INSERT INTO order_follow_up (order_no, follow_up_reason)
        VALUES (v_order_no, 'Order has been pending for more than three days');
    END LOOP;

    CLOSE order_cursor;
END$$
DELIMITER ;

-- Cursor version: run once.
CALL sp_queue_old_orders_cursor();
SELECT * FROM order_follow_up ORDER BY follow_up_id;

-- Set-based alternative: one statement handles all matching orders.
-- Clear only the demonstration queue rows before comparing:
-- DELETE FROM order_follow_up;
INSERT INTO order_follow_up (order_no, follow_up_reason)
SELECT o.order_no, 'Order has been pending for more than three days'
FROM fulfilment_order AS o
WHERE o.order_status = 'PLACED'
  AND o.order_date < NOW() - INTERVAL 3 DAY
  AND NOT EXISTS (
      SELECT 1 FROM order_follow_up AS f
      WHERE f.order_no = o.order_no
  );

SELECT * FROM order_follow_up ORDER BY follow_up_id;
