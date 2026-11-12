-- Day 5 Set 1: sample data (10 rows per table)
USE retail_inventory;

INSERT INTO category (category_id, category_name) VALUES
(1, 'Electronics'), (2, 'Grocery'), (3, 'Home Appliances'),
(4, 'Stationery'), (5, 'Furniture'), (6, 'Clothing'),
(7, 'Footwear'), (8, 'Personal Care'), (9, 'Sports'), (10, 'Books');

INSERT INTO supplier (supplier_id, supplier_name, supplier_phone) VALUES
(1, 'Bright Tech Supplies', '9876500001'),
(2, 'Fresh Basket Traders', '9876500002'),
(3, 'HomeEase Distributors', '9876500003'),
(4, 'PaperPoint Suppliers', '9876500004'),
(5, 'Comfort Living Co', '9876500005'),
(6, 'Urban Wear Wholesale', '9876500006'),
(7, 'StepUp Footwear', '9876500007'),
(8, 'CarePlus Distributors', '9876500008'),
(9, 'Active Sports Supply', '9876500009'),
(10, 'Knowledge House', '9876500010');

INSERT INTO warehouse (warehouse_id, warehouse_name, city) VALUES
(1, 'Central Warehouse', 'Coimbatore'),
(2, 'North Storage', 'Chennai'),
(3, 'South Storage', 'Madurai'),
(4, 'East Distribution', 'Trichy'),
(5, 'West Distribution', 'Salem'),
(6, 'Metro Warehouse', 'Bengaluru'),
(7, 'Lakeview Warehouse', 'Mysuru'),
(8, 'Hilltop Storage', 'Ooty'),
(9, 'Industrial Warehouse', 'Erode'),
(10, 'City Warehouse', 'Tiruppur');

INSERT INTO product (sku, product_name, category_id, supplier_id) VALUES
('SKU001', 'Wireless Mouse', 1, 1),
('SKU002', 'Organic Rice 5kg', 2, 2),
('SKU003', 'Electric Kettle', 3, 3),
('SKU004', 'Notebook Pack', 4, 4),
('SKU005', 'Office Chair', 5, 5),
('SKU006', 'Cotton T Shirt', 6, 6),
('SKU007', 'Running Shoes', 7, 7),
('SKU008', 'Hand Wash 500ml', 8, 8),
('SKU009', 'Football', 9, 9),
('SKU010', 'Java Basics Book', 10, 10);

INSERT INTO inventory (sku, warehouse_id, quantity, reorder_level) VALUES
('SKU001', 1, 40, 10),
('SKU002', 2, 75, 20),
('SKU003', 3, 18, 5),
('SKU004', 4, 120, 25),
('SKU005', 5, 12, 4),
('SKU006', 6, 55, 15),
('SKU007', 7, 22, 8),
('SKU008', 8, 90, 20),
('SKU009', 9, 16, 6),
('SKU010', 10, 30, 10);

-- Verify the number of rows in every table.
SELECT 'category' AS table_name, COUNT(*) AS row_count FROM category
UNION ALL SELECT 'supplier', COUNT(*) FROM supplier
UNION ALL SELECT 'warehouse', COUNT(*) FROM warehouse
UNION ALL SELECT 'product', COUNT(*) FROM product
UNION ALL SELECT 'inventory', COUNT(*) FROM inventory;
