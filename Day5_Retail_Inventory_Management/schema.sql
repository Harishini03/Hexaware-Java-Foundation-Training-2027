-- Day 5 Set 1: Retail Inventory Management
-- MySQL 8.4 LTS

CREATE DATABASE IF NOT EXISTS retail_inventory;
USE retail_inventory;

CREATE TABLE IF NOT EXISTS category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(80) NOT NULL,
    CONSTRAINT uq_category_name UNIQUE (category_name)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS supplier (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(120) NOT NULL,
    supplier_phone VARCHAR(20) NOT NULL,
    CONSTRAINT uq_supplier_name UNIQUE (supplier_name)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS warehouse (
    warehouse_id INT AUTO_INCREMENT PRIMARY KEY,
    warehouse_name VARCHAR(100) NOT NULL,
    city VARCHAR(80) NOT NULL,
    CONSTRAINT uq_warehouse_name UNIQUE (warehouse_name)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS product (
    sku VARCHAR(20) PRIMARY KEY,
    product_name VARCHAR(120) NOT NULL,
    category_id INT NOT NULL,
    supplier_id INT NOT NULL,
    CONSTRAINT fk_product_category
        FOREIGN KEY (category_id) REFERENCES category(category_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_product_supplier
        FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS inventory (
    sku VARCHAR(20) NOT NULL,
    warehouse_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    reorder_level INT NOT NULL DEFAULT 5,
    PRIMARY KEY (sku, warehouse_id),
    CONSTRAINT chk_inventory_quantity CHECK (quantity >= 0),
    CONSTRAINT chk_inventory_reorder_level CHECK (reorder_level >= 0),
    CONSTRAINT fk_inventory_product
        FOREIGN KEY (sku) REFERENCES product(sku)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_inventory_warehouse
        FOREIGN KEY (warehouse_id) REFERENCES warehouse(warehouse_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Table design summary:
-- category: one row per product category.
-- supplier: one row per supplier and its contact number.
-- warehouse: one row per warehouse.
-- product: one row per SKU; references its category and supplier.
-- inventory: quantity/reorder level for a product at a particular warehouse.
