-- Day 5 Set 1: DML, SELECT before/after, and system database exploration
USE retail_inventory;

-- A. Supplier phone correction: inspect before.
SELECT supplier_id, supplier_name, supplier_phone
FROM supplier
WHERE supplier_id = 1;

-- Correct the supplier phone number.
UPDATE supplier
SET supplier_phone = '9000011111'
WHERE supplier_id = 1;

-- Inspect after.
SELECT supplier_id, supplier_name, supplier_phone
FROM supplier
WHERE supplier_id = 1;

-- B. Remove a discontinued SKU: inspect before.
SELECT p.sku, p.product_name, i.warehouse_id, i.quantity
FROM product AS p
LEFT JOIN inventory AS i ON p.sku = i.sku
WHERE p.sku = 'SKU010';

-- Delete child inventory row first because the FK uses ON DELETE RESTRICT.
DELETE FROM inventory
WHERE sku = 'SKU010';

-- Now delete the discontinued product.
DELETE FROM product
WHERE sku = 'SKU010';

-- Inspect after: this should return no rows.
SELECT p.sku, p.product_name, i.warehouse_id, i.quantity
FROM product AS p
LEFT JOIN inventory AS i ON p.sku = i.sku
WHERE p.sku = 'SKU010';

-- C. Retrieve stock that has reached or fallen below its reorder level.
SELECT p.sku, p.product_name, w.warehouse_name,
       i.quantity, i.reorder_level
FROM inventory AS i
JOIN product AS p ON i.sku = p.sku
JOIN warehouse AS w ON i.warehouse_id = w.warehouse_id
WHERE i.quantity <= i.reorder_level;

-- D. Explore the four MySQL system databases.
SHOW DATABASES;
SHOW TABLES FROM information_schema;
SHOW TABLES FROM mysql;
SHOW TABLES FROM performance_schema;
SHOW TABLES FROM sys;

-- E. List this schema's tables, storage engine and estimated row count.
SELECT TABLE_NAME, ENGINE, TABLE_ROWS
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'retail_inventory'
ORDER BY TABLE_NAME;

-- Note: InnoDB TABLE_ROWS is an estimate, not an exact COUNT(*).
