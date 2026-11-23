-- Day 10 Set 1: Retail Price Change Audit
-- Prerequisite: Day 9 schema_and_seed.sql
USE retail_inventory;

CREATE TABLE IF NOT EXISTS price_audit (
    audit_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    sku VARCHAR(20) NOT NULL,
    old_price DECIMAL(10,2) NOT NULL,
    new_price DECIMAL(10,2) NOT NULL,
    changed_by VARCHAR(288) NOT NULL,
    changed_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

DROP TRIGGER IF EXISTS trg_product_price_before_update;
DROP TRIGGER IF EXISTS trg_product_price_after_update;

DELIMITER $$

-- Validate the new selling price before MySQL saves the row.
CREATE TRIGGER trg_product_price_before_update
BEFORE UPDATE ON product_price
FOR EACH ROW
BEGIN
    IF NEW.selling_price < NEW.cost_price THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Selling price cannot be lower than cost price';
    END IF;

    IF NEW.selling_price < 0 OR NEW.cost_price < 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Price values cannot be negative';
    END IF;
END$$

-- Record each successful row update after it has passed validation.
CREATE TRIGGER trg_product_price_after_update
AFTER UPDATE ON product_price
FOR EACH ROW
BEGIN
    IF NOT (OLD.selling_price <=> NEW.selling_price) THEN
        INSERT INTO price_audit
            (sku, old_price, new_price, changed_by, changed_at)
        VALUES
            (OLD.sku, OLD.selling_price, NEW.selling_price,
             CURRENT_USER(), CURRENT_TIMESTAMP());
    END IF;
END$$

DELIMITER ;

-- Confirm that the triggers were created.
SELECT TRIGGER_NAME, EVENT_MANIPULATION, ACTION_TIMING, EVENT_OBJECT_TABLE
FROM information_schema.TRIGGERS
WHERE TRIGGER_SCHEMA = DATABASE()
  AND EVENT_OBJECT_TABLE = 'product_price'
ORDER BY ACTION_TIMING, EVENT_MANIPULATION;
