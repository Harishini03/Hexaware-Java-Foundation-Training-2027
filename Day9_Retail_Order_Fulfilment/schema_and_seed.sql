-- Day 9 Set 1: Retail Order Fulfilment
-- Prerequisite: run Day 5 schema.sql and seed_data.sql first.
USE retail_inventory;

-- Selling price and cost are separated from the general product details.
CREATE TABLE IF NOT EXISTS product_price (
    sku VARCHAR(20) PRIMARY KEY,
    cost_price DECIMAL(10,2) NOT NULL,
    selling_price DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_cost_nonnegative CHECK (cost_price >= 0),
    CONSTRAINT chk_selling_nonnegative CHECK (selling_price >= 0),
    CONSTRAINT fk_price_product FOREIGN KEY (sku) REFERENCES product(sku)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS fulfilment_order (
    order_no BIGINT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    warehouse_id INT NOT NULL,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    order_status ENUM('PLACED','CANCELLED') NOT NULL DEFAULT 'PLACED',
    CONSTRAINT fk_fulfilment_warehouse FOREIGN KEY (warehouse_id)
        REFERENCES warehouse(warehouse_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS fulfilment_order_line (
    line_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_no BIGINT NOT NULL,
    sku VARCHAR(20) NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_fulfilment_quantity CHECK (quantity > 0),
    CONSTRAINT fk_line_order FOREIGN KEY (order_no)
        REFERENCES fulfilment_order(order_no) ON DELETE CASCADE,
    CONSTRAINT fk_line_product FOREIGN KEY (sku) REFERENCES product(sku)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS order_follow_up (
    follow_up_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_no BIGINT NOT NULL,
    follow_up_reason VARCHAR(200) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_followup_order FOREIGN KEY (order_no)
        REFERENCES fulfilment_order(order_no) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Safe to run repeatedly: refresh the demonstration prices.
INSERT INTO product_price (sku, cost_price, selling_price) VALUES
('SKU001', 400.00, 650.00),
('SKU002', 250.00, 340.00),
('SKU003', 700.00, 999.00),
('SKU004', 60.00, 100.00),
('SKU005', 2500.00, 3499.00),
('SKU006', 180.00, 299.00),
('SKU007', 1200.00, 1799.00),
('SKU008', 45.00, 75.00),
('SKU009', 500.00, 799.00),
('SKU010', 220.00, 350.00)
ON DUPLICATE KEY UPDATE
    cost_price = VALUES(cost_price),
    selling_price = VALUES(selling_price);

SELECT 'Day 9 setup complete' AS status;
SELECT sku, cost_price, selling_price FROM product_price ORDER BY sku;
