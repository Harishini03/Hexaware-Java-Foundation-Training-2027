-- Day 9: Views
USE retail_inventory;

DROP VIEW IF EXISTS vw_order_summary;
CREATE VIEW vw_order_summary AS
SELECT
    o.order_no,
    o.customer_id,
    o.warehouse_id,
    o.order_date,
    o.order_status,
    l.sku,
    p.product_name,
    l.quantity,
    l.unit_price,
    (l.quantity * l.unit_price) AS line_total
FROM fulfilment_order AS o
JOIN fulfilment_order_line AS l ON l.order_no = o.order_no
JOIN product AS p ON p.sku = l.sku;
-- Cost price and supplier_id are deliberately not exposed.

DROP VIEW IF EXISTS vw_low_stock;
CREATE VIEW vw_low_stock AS
SELECT
    i.sku,
    p.product_name,
    i.warehouse_id,
    i.quantity,
    i.reorder_level
FROM inventory AS i
JOIN product AS p ON p.sku = i.sku
WHERE i.quantity <= i.reorder_level;

-- Demonstrate an updatable view. A simple single-table view is updatable.
DROP VIEW IF EXISTS vw_product_price_entry;
CREATE VIEW vw_product_price_entry AS
SELECT sku, selling_price
FROM product_price
WHERE selling_price > 0
WITH CASCADED CHECK OPTION;

-- Valid: row remains visible through the view.
UPDATE vw_product_price_entry
SET selling_price = 660.00
WHERE sku = 'SKU001';

-- Invalid demonstration: this violates WITH CHECK OPTION.
-- Uncomment and run separately to see MySQL reject the update:
-- UPDATE vw_product_price_entry SET selling_price = 0 WHERE sku = 'SKU001';

SELECT * FROM vw_order_summary ORDER BY order_no;
SELECT * FROM vw_low_stock ORDER BY warehouse_id, sku;
SELECT * FROM vw_product_price_entry ORDER BY sku;
