-- Days 6-8 shared retail operations schema
-- MySQL 8.4 LTS. Run Day5 schema.sql and seed_data.sql first.
USE retail_inventory;

CREATE TABLE IF NOT EXISTS customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(80) NOT NULL,
    email VARCHAR(150) UNIQUE,
    birth_date DATE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS store (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    city VARCHAR(80) NOT NULL,
    region VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS employee (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    store_id INT NOT NULL,
    manager_id INT NULL,
    CONSTRAINT fk_employee_store FOREIGN KEY (store_id) REFERENCES store(store_id),
    CONSTRAINT fk_employee_manager FOREIGN KEY (manager_id) REFERENCES employee(employee_id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS product_pricing (
    sku VARCHAR(20) PRIMARY KEY,
    unit_price DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_product_price CHECK (unit_price >= 0),
    CONSTRAINT fk_pricing_product FOREIGN KEY (sku) REFERENCES product(sku)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS sales_order (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    store_id INT NOT NULL,
    employee_id INT NOT NULL,
    order_date DATETIME NOT NULL,
    order_status ENUM('PLACED','COMPLETED','CANCELLED') NOT NULL DEFAULT 'PLACED',
    CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    CONSTRAINT fk_order_store FOREIGN KEY (store_id) REFERENCES store(store_id),
    CONSTRAINT fk_order_employee FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
    INDEX idx_order_date (order_date),
    INDEX idx_order_customer (customer_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS order_item (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    sku VARCHAR(20) NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_order_item_quantity CHECK (quantity > 0),
    CONSTRAINT chk_order_item_price CHECK (unit_price >= 0),
    CONSTRAINT fk_item_order FOREIGN KEY (order_id) REFERENCES sales_order(order_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_item_product FOREIGN KEY (sku) REFERENCES product(sku),
    INDEX idx_item_sku (sku)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS payment (
    payment_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_date DATETIME NULL,
    amount DECIMAL(12,2) NOT NULL,
    payment_status ENUM('PAID','PENDING','FAILED') NOT NULL,
    CONSTRAINT chk_payment_amount CHECK (amount >= 0),
    CONSTRAINT fk_payment_order FOREIGN KEY (order_id) REFERENCES sales_order(order_id),
    INDEX idx_payment_order (order_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS sales_return (
    return_id INT PRIMARY KEY,
    order_item_id INT NOT NULL,
    return_date DATE NOT NULL,
    return_quantity INT NOT NULL,
    return_reason VARCHAR(200) NOT NULL,
    return_status ENUM('REQUESTED','APPROVED','REJECTED') NOT NULL,
    CONSTRAINT chk_return_quantity CHECK (return_quantity > 0),
    CONSTRAINT fk_return_item FOREIGN KEY (order_item_id) REFERENCES order_item(order_item_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS refund (
    refund_id INT PRIMARY KEY,
    return_id INT NOT NULL,
    refund_date DATE NULL,
    refund_amount DECIMAL(12,2) NOT NULL,
    refund_status ENUM('PROCESSED','PENDING','REJECTED') NOT NULL,
    CONSTRAINT chk_refund_amount CHECK (refund_amount >= 0),
    CONSTRAINT fk_refund_return FOREIGN KEY (return_id) REFERENCES sales_return(return_id),
    INDEX idx_refund_return (return_id)
) ENGINE=InnoDB;
