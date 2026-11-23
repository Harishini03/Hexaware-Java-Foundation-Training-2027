-- Day 10: Trigger test plan
USE retail_inventory;

-- TEST 1: Single-row valid update.
UPDATE product_price
SET selling_price = 675.00
WHERE sku = 'SKU001';

SELECT * FROM price_audit
WHERE sku = 'SKU001'
ORDER BY audit_id DESC;

-- TEST 2: Multi-row valid update.
-- MySQL fires the AFTER UPDATE trigger once for every changed row.
UPDATE product_price
SET selling_price = selling_price + 10.00
WHERE sku IN ('SKU002', 'SKU003');

SELECT * FROM price_audit
WHERE sku IN ('SKU002', 'SKU003')
ORDER BY audit_id DESC;

-- TEST 3: Invalid below-cost update.
-- Uncomment and execute this statement separately to see SQLSTATE 45000.
-- It must fail, and no audit row should be created for the rejected update.
-- UPDATE product_price
-- SET selling_price = cost_price - 1.00
-- WHERE sku = 'SKU001';

-- TEST 4: Verify that the rejected value was not stored.
SELECT sku, cost_price, selling_price
FROM product_price
WHERE sku = 'SKU001';

-- TEST 5: Verify the audit history and trigger definitions.
SELECT * FROM price_audit ORDER BY audit_id;
SELECT TRIGGER_NAME, ACTION_TIMING, EVENT_MANIPULATION, ACTION_STATEMENT
FROM information_schema.TRIGGERS
WHERE TRIGGER_SCHEMA = DATABASE()
  AND EVENT_OBJECT_TABLE = 'product_price';
