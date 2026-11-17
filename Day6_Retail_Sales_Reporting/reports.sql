-- DAY 6: RETAIL SALES REPORTING
-- MySQL 8.4 LTS | Run after Day6 setup.sql and seed_data.sql
USE retail_inventory;

-- Q1. Top five products by sales revenue.
SELECT p.sku, p.product_name,
       SUM(oi.quantity) AS units_sold,
       ROUND(SUM(oi.quantity * oi.unit_price),2) AS revenue
FROM order_item oi
JOIN product p ON p.sku = oi.sku
JOIN sales_order so ON so.order_id = oi.order_id
WHERE so.order_status = 'COMPLETED'
GROUP BY p.sku, p.product_name
ORDER BY revenue DESC
LIMIT 5;

-- Q2. Month-wise sales revenue.
SELECT DATE_FORMAT(so.order_date,'%Y-%m') AS sales_month,
       COUNT(DISTINCT so.order_id) AS completed_orders,
       ROUND(SUM(oi.quantity * oi.unit_price),2) AS monthly_revenue
FROM sales_order so
JOIN order_item oi ON oi.order_id = so.order_id
WHERE so.order_status = 'COMPLETED'
GROUP BY DATE_FORMAT(so.order_date,'%Y-%m')
ORDER BY sales_month;

-- Q3. Customers who placed more than three orders (HAVING filters groups).
SELECT c.customer_id, UPPER(c.customer_name) AS customer_name,
       COUNT(so.order_id) AS order_count
FROM customer c
JOIN sales_order so ON so.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(so.order_id) > 3
ORDER BY order_count DESC;

-- Q4. Average basket value by customer city.
-- Each order total is calculated first; the outer query averages those totals.
SELECT c.city,
       ROUND(AVG(order_totals.order_value),2) AS average_basket_value,
       COUNT(*) AS number_of_orders
FROM customer c
JOIN (
    SELECT so.order_id, so.customer_id,
           SUM(oi.quantity * oi.unit_price) AS order_value
    FROM sales_order so
    JOIN order_item oi ON oi.order_id = so.order_id
    WHERE so.order_status = 'COMPLETED'
    GROUP BY so.order_id, so.customer_id
) AS order_totals ON order_totals.customer_id = c.customer_id
GROUP BY c.city
ORDER BY average_basket_value DESC;

-- Q5. Orders that do not have a payment record (LEFT JOIN).
SELECT so.order_id, CONCAT(c.customer_name,' - ',c.city) AS customer_details,
       DATE_FORMAT(so.order_date,'%d-%b-%Y') AS order_date,
       so.order_status
FROM sales_order so
JOIN customer c ON c.customer_id = so.customer_id
LEFT JOIN payment pay ON pay.order_id = so.order_id
WHERE pay.payment_id IS NULL
ORDER BY so.order_id;

-- Q6. Customers who have never placed an order.
SELECT c.customer_id, CONCAT(UPPER(c.customer_name),' (',c.city,')') AS customer_label
FROM customer c
LEFT JOIN sales_order so ON so.customer_id = c.customer_id
WHERE so.order_id IS NULL
ORDER BY c.customer_id;

-- Q7. Product-category revenue share.
WITH category_revenue AS (
    SELECT cat.category_id, cat.category_name,
           SUM(oi.quantity * oi.unit_price) AS revenue
    FROM category cat
    JOIN product p ON p.category_id = cat.category_id
    JOIN order_item oi ON oi.sku = p.sku
    JOIN sales_order so ON so.order_id = oi.order_id
    WHERE so.order_status = 'COMPLETED'
    GROUP BY cat.category_id, cat.category_name
)
SELECT category_name, ROUND(revenue,2) AS category_revenue,
       ROUND(100 * revenue / NULLIF(SUM(revenue) OVER (),0),2) AS revenue_share_percent
FROM category_revenue
ORDER BY revenue DESC;

-- Q8. Calendar day with the highest sales revenue.
SELECT DATE(so.order_date) AS sales_day,
       ROUND(SUM(oi.quantity * oi.unit_price),2) AS daily_revenue
FROM sales_order so
JOIN order_item oi ON oi.order_id = so.order_id
WHERE so.order_status = 'COMPLETED'
GROUP BY DATE(so.order_date)
ORDER BY daily_revenue DESC, sales_day
LIMIT 1;

-- NULL behaviour demonstration.
-- COUNT(*) counts rows; COUNT(column) ignores NULL values.
-- SUM and AVG also ignore NULL values. COALESCE can supply a display default.
SELECT COUNT(*) AS payment_rows,
       COUNT(payment_date) AS rows_with_payment_date,
       SUM(amount) AS sum_of_amounts,
       AVG(amount) AS average_amount,
       COALESCE(SUM(amount),0) AS sum_with_zero_default
FROM payment
WHERE payment_status IN ('PAID','PENDING');

-- A compact demonstration using explicit NULL values.
SELECT COUNT(*) AS total_rows,
       COUNT(sample_value) AS non_null_values,
       SUM(sample_value) AS sum_ignoring_null,
       AVG(sample_value) AS average_ignoring_null
FROM (
    SELECT 10 AS sample_value
    UNION ALL SELECT NULL
    UNION ALL SELECT 30
) AS null_demo;

-- WHERE filters individual rows before grouping.
-- HAVING filters grouped results after COUNT has been calculated.
SELECT customer_id, COUNT(*) AS order_count
FROM sales_order
WHERE order_status = 'COMPLETED'
GROUP BY customer_id
HAVING COUNT(*) > 3;
