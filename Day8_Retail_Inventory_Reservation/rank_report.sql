-- DAY 8: CTEs, CORRELATED SUBQUERIES AND WINDOW FUNCTIONS
-- MySQL 8.4 LTS | Run after Day 6 setup.sql and seed_data.sql
USE retail_inventory;

-- Q1. Correlated subquery: products whose stock is below the average stock
-- of products in the same category. Stock is evaluated per SKU/warehouse row.
SELECT p.sku,p.product_name,c.category_name,w.warehouse_name,
       i.quantity AS current_stock,
       ROUND((
           SELECT AVG(i2.quantity)
           FROM inventory i2
           JOIN product p2 ON p2.sku=i2.sku
           WHERE p2.category_id=p.category_id
       ),2) AS category_average_stock
FROM inventory i
JOIN product p ON p.sku=i.sku
JOIN category c ON c.category_id=p.category_id
JOIN warehouse w ON w.warehouse_id=i.warehouse_id
WHERE i.quantity < (
    SELECT AVG(i2.quantity)
    FROM inventory i2
    JOIN product p2 ON p2.sku=i2.sku
    WHERE p2.category_id=p.category_id
)
ORDER BY c.category_name,p.product_name;

-- Q2. CTE + ROW_NUMBER: rank products by sales revenue within each category.
-- Return the top three products in each category.
WITH product_sales AS (
    SELECT c.category_id,c.category_name,p.sku,p.product_name,
           SUM(oi.quantity) AS units_sold,
           SUM(oi.quantity*oi.unit_price) AS revenue
    FROM category c
    JOIN product p ON p.category_id=c.category_id
    JOIN order_item oi ON oi.sku=p.sku
    JOIN sales_order so ON so.order_id=oi.order_id
    WHERE so.order_status='COMPLETED'
    GROUP BY c.category_id,c.category_name,p.sku,p.product_name
),
ranked_products AS (
    SELECT product_sales.*,
           ROW_NUMBER() OVER (
               PARTITION BY category_id
               ORDER BY revenue DESC,sku
           ) AS category_rank
    FROM product_sales
)
SELECT category_name,sku,product_name,units_sold,
       ROUND(revenue,2) AS revenue,category_rank
FROM ranked_products
WHERE category_rank<=3
ORDER BY category_name,category_rank;

-- Q3. Month-on-month sales change for each product using LAG and LEAD.
WITH monthly_product_sales AS (
    SELECT oi.sku,p.product_name,
           DATE_FORMAT(so.order_date,'%Y-%m-01') AS sales_month,
           SUM(oi.quantity*oi.unit_price) AS monthly_revenue
    FROM order_item oi
    JOIN sales_order so ON so.order_id=oi.order_id
    JOIN product p ON p.sku=oi.sku
    WHERE so.order_status='COMPLETED'
    GROUP BY oi.sku,p.product_name,DATE_FORMAT(so.order_date,'%Y-%m-01')
),
sales_trend AS (
    SELECT sku,product_name,sales_month,monthly_revenue,
           LAG(monthly_revenue) OVER (
               PARTITION BY sku ORDER BY sales_month
           ) AS previous_month_revenue,
           LEAD(monthly_revenue) OVER (
               PARTITION BY sku ORDER BY sales_month
           ) AS next_month_revenue
    FROM monthly_product_sales
)
SELECT sku,product_name,sales_month,
       ROUND(monthly_revenue,2) AS monthly_revenue,
       ROUND(previous_month_revenue,2) AS previous_month_revenue,
       ROUND(monthly_revenue-previous_month_revenue,2) AS change_from_previous_month,
       ROUND(next_month_revenue,2) AS next_month_revenue
FROM sales_trend
ORDER BY sku,sales_month;

-- Q4. RANK and DENSE_RANK comparison for product revenue within category.
WITH product_sales AS (
    SELECT c.category_name,p.sku,p.product_name,
           SUM(oi.quantity*oi.unit_price) AS revenue
    FROM category c
    JOIN product p ON p.category_id=c.category_id
    JOIN order_item oi ON oi.sku=p.sku
    JOIN sales_order so ON so.order_id=oi.order_id
    WHERE so.order_status='COMPLETED'
    GROUP BY c.category_name,p.sku,p.product_name
)
SELECT category_name,product_name,ROUND(revenue,2) AS revenue,
       RANK() OVER (PARTITION BY category_name ORDER BY revenue DESC) AS revenue_rank,
       DENSE_RANK() OVER (PARTITION BY category_name ORDER BY revenue DESC) AS dense_revenue_rank
FROM product_sales
ORDER BY category_name,revenue DESC;
