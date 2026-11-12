-- Run each statement separately AFTER schema.sql and seed_data.sql.
-- Each statement is intentionally invalid and should fail.
USE retail_inventory;

-- 1. Duplicate primary key: SKU001 already exists in PRODUCT.
INSERT INTO product (sku, product_name, category_id, supplier_id)
VALUES ('SKU001', 'Duplicate Mouse', 1, 1);

-- 2. Missing parent: category_id 999 does not exist.
INSERT INTO product (sku, product_name, category_id, supplier_id)
VALUES ('SKU011', 'Unknown Category Product', 999, 1);

-- 3. Negative quantity violates CHECK (quantity >= 0).
INSERT INTO inventory (sku, warehouse_id, quantity, reorder_level)
VALUES ('SKU001', 1, -5, 2);

-- 4. NULL in mandatory column product_name violates NOT NULL.
INSERT INTO product (sku, product_name, category_id, supplier_id)
VALUES ('SKU012', NULL, 1, 1);
