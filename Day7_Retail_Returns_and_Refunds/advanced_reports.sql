-- DAY 7: RETAIL RETURNS AND REFUNDS
-- MySQL 8.4 LTS | Run after Day 6 setup.sql and seed_data.sql
USE retail_inventory;

-- Q1. Products with a return rate above 10 percent (returned units / sold units).
SELECT p.sku,p.product_name,
       SUM(oi.quantity) AS units_sold,
       COALESCE(SUM(sr.return_quantity),0) AS units_returned,
       ROUND(100 * COALESCE(SUM(sr.return_quantity),0) / NULLIF(SUM(oi.quantity),0),2) AS return_rate_percent
FROM product p
JOIN order_item oi ON oi.sku=p.sku
JOIN sales_order so ON so.order_id=oi.order_id AND so.order_status='COMPLETED'
LEFT JOIN sales_return sr ON sr.order_item_id=oi.order_item_id AND sr.return_status<>'REJECTED'
GROUP BY p.sku,p.product_name
HAVING 100 * COALESCE(SUM(sr.return_quantity),0) / NULLIF(SUM(oi.quantity),0) > 10
ORDER BY return_rate_percent DESC;

-- Q2. Customers who have returns but no refund record for at least one return.
SELECT DISTINCT c.customer_id,c.customer_name,c.city
FROM customer c
JOIN sales_order so ON so.customer_id=c.customer_id
JOIN order_item oi ON oi.order_id=so.order_id
JOIN sales_return sr ON sr.order_item_id=oi.order_item_id
LEFT JOIN refund r ON r.return_id=sr.return_id
WHERE r.refund_id IS NULL
ORDER BY c.customer_id;

-- Q3. Stores ranked by total processed refund value.
SELECT st.store_id,st.store_name,st.region,
       ROUND(COALESCE(SUM(CASE WHEN r.refund_status='PROCESSED' THEN r.refund_amount ELSE 0 END),0),2) AS processed_refund_value
FROM store st
LEFT JOIN sales_order so ON so.store_id=st.store_id
LEFT JOIN order_item oi ON oi.order_id=so.order_id
LEFT JOIN sales_return sr ON sr.order_item_id=oi.order_item_id
LEFT JOIN refund r ON r.return_id=sr.return_id
GROUP BY st.store_id,st.store_name,st.region
ORDER BY processed_refund_value DESC,st.store_id;

-- Q4. Employees and their managers (self join).
SELECT e.employee_name AS employee,
       COALESCE(m.employee_name,'No manager assigned') AS manager,
       st.store_name
FROM employee e
LEFT JOIN employee m ON m.employee_id=e.manager_id
JOIN store st ON st.store_id=e.store_id
ORDER BY st.store_name,e.employee_name;

-- Q5. Return details with the customer, product and store.
SELECT sr.return_id,c.customer_name,p.product_name,st.store_name,
       sr.return_quantity,sr.return_reason,sr.return_status
FROM sales_return sr
JOIN order_item oi ON oi.order_item_id=sr.order_item_id
JOIN sales_order so ON so.order_id=oi.order_id
JOIN customer c ON c.customer_id=so.customer_id
JOIN product p ON p.sku=oi.sku
JOIN store st ON st.store_id=so.store_id
ORDER BY sr.return_date,sr.return_id;

-- Q6. Return count and returned quantity by return status.
SELECT return_status,COUNT(*) AS return_requests,
       SUM(return_quantity) AS total_units
FROM sales_return
GROUP BY return_status
ORDER BY return_status;

-- Q7. Processed refund value by store region.
SELECT st.region,
       ROUND(SUM(CASE WHEN r.refund_status='PROCESSED' THEN r.refund_amount ELSE 0 END),2) AS processed_refund_total
FROM store st
JOIN sales_order so ON so.store_id=st.store_id
JOIN order_item oi ON oi.order_id=so.order_id
JOIN sales_return sr ON sr.order_item_id=oi.order_item_id
JOIN refund r ON r.return_id=sr.return_id
GROUP BY st.region
ORDER BY processed_refund_total DESC;

-- Q8. Products that have never been returned (NOT EXISTS).
SELECT p.sku,p.product_name
FROM product p
WHERE NOT EXISTS (
    SELECT 1
    FROM order_item oi
    JOIN sales_return sr ON sr.order_item_id=oi.order_item_id
    WHERE oi.sku=p.sku
)
ORDER BY p.sku;

-- IN demonstration: customers who have at least one returned order item.
SELECT customer_id,customer_name
FROM customer
WHERE customer_id IN (
    SELECT so.customer_id
    FROM sales_order so
    JOIN order_item oi ON oi.order_id=so.order_id
    JOIN sales_return sr ON sr.order_item_id=oi.order_item_id
)
ORDER BY customer_id;

-- Q9. Stores whose processed refund total is greater than ANY processed refund total
-- from a different store in the same region.
WITH store_refunds AS (
    SELECT st.store_id,st.store_name,st.region,
           COALESCE(SUM(CASE WHEN r.refund_status='PROCESSED' THEN r.refund_amount ELSE 0 END),0) AS refund_total
    FROM store st
    LEFT JOIN sales_order so ON so.store_id=st.store_id
    LEFT JOIN order_item oi ON oi.order_id=so.order_id
    LEFT JOIN sales_return sr ON sr.order_item_id=oi.order_item_id
    LEFT JOIN refund r ON r.return_id=sr.return_id
    GROUP BY st.store_id,st.store_name,st.region
)
SELECT a.store_name,a.region,a.refund_total
FROM store_refunds a
WHERE a.refund_total > ANY (
    SELECT b.refund_total
    FROM store_refunds b
    WHERE b.region=a.region AND b.store_id<>a.store_id
);

-- Q10. Stores whose refund total is greater than ALL other stores' totals in their region.
WITH store_refunds AS (
    SELECT st.store_id,st.store_name,st.region,
           COALESCE(SUM(CASE WHEN r.refund_status='PROCESSED' THEN r.refund_amount ELSE 0 END),0) AS refund_total
    FROM store st
    LEFT JOIN sales_order so ON so.store_id=st.store_id
    LEFT JOIN order_item oi ON oi.order_id=so.order_id
    LEFT JOIN sales_return sr ON sr.order_item_id=oi.order_item_id
    LEFT JOIN refund r ON r.return_id=sr.return_id
    GROUP BY st.store_id,st.store_name,st.region
)
SELECT a.store_name,a.region,a.refund_total
FROM store_refunds a
WHERE a.refund_total > ALL (
    SELECT b.refund_total
    FROM store_refunds b
    WHERE b.region=a.region AND b.store_id<>a.store_id
);

-- NULL pitfall: if a NOT IN subquery returns even one NULL, the comparison can
-- become UNKNOWN and return no rows. This deliberately unsafe example returns no customers.
SELECT customer_id,customer_name
FROM customer
WHERE customer_id NOT IN (
    SELECT NULL
    UNION
    SELECT customer_id FROM sales_order
);

-- Correct NULL-safe anti-join: NOT EXISTS.
SELECT c.customer_id,c.customer_name
FROM customer c
WHERE NOT EXISTS (
    SELECT 1 FROM sales_order so
    WHERE so.customer_id=c.customer_id
)
ORDER BY c.customer_id;

-- Nested subquery 1: stores whose processed refund total exceeds the average
-- processed refund total across stores.
SELECT store_totals.store_id,store_totals.store_name,store_totals.refund_total
FROM (
    SELECT st.store_id,st.store_name,
           COALESCE(SUM(CASE WHEN r.refund_status='PROCESSED' THEN r.refund_amount ELSE 0 END),0) AS refund_total
    FROM store st
    LEFT JOIN sales_order so ON so.store_id=st.store_id
    LEFT JOIN order_item oi ON oi.order_id=so.order_id
    LEFT JOIN sales_return sr ON sr.order_item_id=oi.order_item_id
    LEFT JOIN refund r ON r.return_id=sr.return_id
    GROUP BY st.store_id,st.store_name
) AS store_totals
WHERE store_totals.refund_total > (
    SELECT AVG(region_totals.refund_total)
    FROM (
        SELECT st2.store_id,
               COALESCE(SUM(CASE WHEN r2.refund_status='PROCESSED' THEN r2.refund_amount ELSE 0 END),0) AS refund_total
        FROM store st2
        LEFT JOIN sales_order so2 ON so2.store_id=st2.store_id
        LEFT JOIN order_item oi2 ON oi2.order_id=so2.order_id
        LEFT JOIN sales_return sr2 ON sr2.order_item_id=oi2.order_item_id
        LEFT JOIN refund r2 ON r2.return_id=sr2.return_id
        GROUP BY st2.store_id
    ) AS region_totals
);

-- Nested subquery 2: product(s) with the highest number of returned units.
SELECT p.sku,p.product_name,product_returns.returned_units
FROM product p
JOIN (
    SELECT oi.sku,SUM(sr.return_quantity) AS returned_units
    FROM order_item oi
    JOIN sales_return sr ON sr.order_item_id=oi.order_item_id
    WHERE sr.return_status<>'REJECTED'
    GROUP BY oi.sku
) AS product_returns ON product_returns.sku=p.sku
WHERE product_returns.returned_units = (
    SELECT MAX(returned_units)
    FROM (
        SELECT SUM(sr2.return_quantity) AS returned_units
        FROM order_item oi2
        JOIN sales_return sr2 ON sr2.order_item_id=oi2.order_item_id
        WHERE sr2.return_status<>'REJECTED'
        GROUP BY oi2.sku
    ) AS return_totals
);
