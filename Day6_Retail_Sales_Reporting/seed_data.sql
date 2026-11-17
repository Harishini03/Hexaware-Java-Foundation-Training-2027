-- Sample data for Days 6-8. Run after setup.sql.
USE retail_inventory;

INSERT INTO customer (customer_id,customer_name,city,email,birth_date) VALUES
(1,'Aarav Kumar','Coimbatore','aarav@example.com','1995-04-12'),
(2,'Diya Raman','Chennai','diya@example.com','1998-08-21'),
(3,'Kavin Raj','Madurai','kavin@example.com','1992-02-10'),
(4,'Meera S','Coimbatore','meera@example.com','2000-11-05'),
(5,'Rohan Das','Salem','rohan@example.com','1989-06-18'),
(6,'Ananya Iyer','Trichy','ananya@example.com','1996-09-30'),
(7,'Vikram N','Chennai','vikram@example.com','1993-01-15'),
(8,'Nila Devi','Erode','nila@example.com','2001-03-25'),
(9,'Sanjay P','Tiruppur','sanjay@example.com','1990-12-02'),
(10,'Tara M','Ooty','tara@example.com','1999-07-07')
ON DUPLICATE KEY UPDATE customer_name=VALUES(customer_name);

INSERT INTO store (store_id,store_name,city,region) VALUES
(1,'Central Coimbatore','Coimbatore','West'),
(2,'Chennai Central','Chennai','North'),
(3,'Madurai South','Madurai','South'),
(4,'Salem Main','Salem','West'),
(5,'Trichy East','Trichy','Central')
ON DUPLICATE KEY UPDATE store_name=VALUES(store_name);

INSERT INTO employee (employee_id,employee_name,store_id,manager_id) VALUES
(1,'Priya Manager',1,NULL),
(2,'Arun Sales',1,1),
(3,'Bala Sales',1,1),
(4,'Divya Manager',2,NULL),
(5,'Eshan Sales',2,4),
(6,'Farah Manager',3,NULL),
(7,'Gokul Sales',3,6),
(8,'Hari Sales',4,NULL)
ON DUPLICATE KEY UPDATE employee_name=VALUES(employee_name);

INSERT INTO product_pricing (sku,unit_price) VALUES
('SKU001',799.00),('SKU002',499.00),('SKU003',1299.00),
('SKU004',120.00),('SKU005',5499.00),('SKU006',699.00),
('SKU007',2499.00),('SKU008',199.00),('SKU009',899.00)
ON DUPLICATE KEY UPDATE unit_price=VALUES(unit_price);

INSERT INTO sales_order (order_id,customer_id,store_id,employee_id,order_date,order_status) VALUES
(1001,1,1,2,'2026-01-05 10:15:00','COMPLETED'),
(1002,1,1,3,'2026-01-18 11:20:00','COMPLETED'),
(1003,1,2,5,'2026-02-03 12:00:00','COMPLETED'),
(1004,1,1,2,'2026-02-19 15:10:00','COMPLETED'),
(1005,1,3,7,'2026-03-02 16:30:00','COMPLETED'),
(1006,2,2,5,'2026-01-12 09:30:00','COMPLETED'),
(1007,2,2,5,'2026-03-11 13:45:00','COMPLETED'),
(1008,3,3,7,'2026-02-08 14:25:00','COMPLETED'),
(1009,4,1,2,'2026-03-15 17:00:00','COMPLETED'),
(1010,5,4,8,'2026-03-21 10:00:00','COMPLETED'),
(1011,6,5,8,'2026-04-04 12:15:00','COMPLETED'),
(1012,7,2,5,'2026-04-10 18:20:00','PLACED')
ON DUPLICATE KEY UPDATE order_status=VALUES(order_status);

INSERT INTO order_item (order_item_id,order_id,sku,quantity,unit_price) VALUES
(1,1001,'SKU001',2,799.00),(2,1001,'SKU002',1,499.00),
(3,1002,'SKU001',1,799.00),(4,1002,'SKU004',3,120.00),
(5,1003,'SKU003',1,1299.00),(6,1003,'SKU001',1,799.00),
(7,1004,'SKU002',2,499.00),(8,1004,'SKU008',2,199.00),
(9,1005,'SKU001',2,799.00),(10,1005,'SKU007',1,2499.00),
(11,1006,'SKU004',5,120.00),(12,1006,'SKU008',2,199.00),
(13,1007,'SKU001',1,799.00),(14,1007,'SKU006',2,699.00),
(15,1008,'SKU003',1,1299.00),(16,1008,'SKU009',2,899.00),
(17,1009,'SKU002',1,499.00),(18,1009,'SKU006',1,699.00),
(19,1010,'SKU005',1,5499.00),(20,1011,'SKU007',1,2499.00),
(21,1012,'SKU001',1,799.00)
ON DUPLICATE KEY UPDATE quantity=VALUES(quantity),unit_price=VALUES(unit_price);

INSERT INTO payment (payment_id,order_id,payment_date,amount,payment_status) VALUES
(1,1001,'2026-01-05 10:16:00',2097.00,'PAID'),
(2,1002,'2026-01-18 11:21:00',1159.00,'PAID'),
(3,1003,'2026-02-03 12:01:00',2098.00,'PAID'),
(4,1004,'2026-02-19 15:11:00',1396.00,'PAID'),
(5,1005,'2026-03-02 16:31:00',4097.00,'PAID'),
(6,1006,'2026-01-12 09:31:00',998.00,'PAID'),
(7,1007,'2026-03-11 13:46:00',2197.00,'PAID'),
(8,1008,'2026-02-08 14:26:00',3097.00,'PAID'),
(9,1009,'2026-03-15 17:01:00',1198.00,'PAID'),
(10,1010,'2026-03-21 10:01:00',5499.00,'PAID'),
(11,1011,'2026-04-04 12:16:00',2499.00,'PAID')
ON DUPLICATE KEY UPDATE amount=VALUES(amount),payment_status=VALUES(payment_status);

INSERT INTO sales_return (return_id,order_item_id,return_date,return_quantity,return_reason,return_status) VALUES
(1,1,'2026-01-10',1,'Damaged package','APPROVED'),
(2,3,'2026-01-22',1,'Wrong item','APPROVED'),
(3,5,'2026-02-10',1,'Changed mind','APPROVED'),
(4,7,'2026-02-25',1,'Damaged item','APPROVED'),
(5,9,'2026-03-08',1,'Late delivery','APPROVED'),
(6,11,'2026-01-17',1,'Not as described','APPROVED'),
(7,15,'2026-02-15',1,'Defective','APPROVED'),
(8,17,'2026-03-19',1,'Wrong size','REQUESTED')
ON DUPLICATE KEY UPDATE return_status=VALUES(return_status);

INSERT INTO refund (refund_id,return_id,refund_date,refund_amount,refund_status) VALUES
(1,1,'2026-01-12',799.00,'PROCESSED'),
(2,3,'2026-02-12',1299.00,'PROCESSED'),
(3,4,'2026-02-27',499.00,'PROCESSED'),
(4,6,'2026-01-19',120.00,'PROCESSED'),
(5,7,NULL,1299.00,'PENDING')
ON DUPLICATE KEY UPDATE refund_amount=VALUES(refund_amount),refund_status=VALUES(refund_status);

-- Quick row-count verification
SELECT 'customers' AS table_name,COUNT(*) AS rows_loaded FROM customer
UNION ALL SELECT 'orders',COUNT(*) FROM sales_order
UNION ALL SELECT 'order_items',COUNT(*) FROM order_item
UNION ALL SELECT 'payments',COUNT(*) FROM payment
UNION ALL SELECT 'returns',COUNT(*) FROM sales_return
UNION ALL SELECT 'refunds',COUNT(*) FROM refund;
