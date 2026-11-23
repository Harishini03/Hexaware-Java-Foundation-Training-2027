# Day 6 – SQL Query Outputs

The following tables are formatted like the result grids shown in MySQL command-line output. Each table contains the column names and rows returned by the corresponding query in `reports.sql`, using the supplied sample data.

### Query 1: Top Five Products by Revenue

```text
+--------+-----------------+------------+---------+
| sku    | product_name    | units_sold | revenue |
+--------+-----------------+------------+---------+
| SKU001 | Wireless Mouse  |          7 | 5593.00 |
| SKU005 | Office Chair    |          1 | 5499.00 |
| SKU007 | Running Shoes   |          2 | 4998.00 |
| SKU003 | Electric Kettle |          2 | 2598.00 |
| SKU006 | Cotton T Shirt  |          3 | 2097.00 |
+--------+-----------------+------------+---------+
```

### Query 2: Month-wise Sales Revenue

```text
+-------------+-----------------+-----------------+
| sales_month | completed_orders| monthly_revenue|
+-------------+-----------------+-----------------+
| 2026-01     |               3 |         4254.00 |
| 2026-02     |               3 |         6591.00 |
| 2026-03     |               4 |        12991.00 |
| 2026-04     |               1 |         2499.00 |
+-------------+-----------------+-----------------+
```

### Query 3: Customers with More Than Three Orders

```text
+-------------+--------------+-------------+
| customer_id | customer_name| order_count |
+-------------+--------------+-------------+
|           1 | AARAV KUMAR  |           5 |
+-------------+--------------+-------------+
```

### Query 4: Average Basket Value by Customer City

```text
+------------+----------------------+------------------+
| city       | average_basket_value | number_of_orders |
+------------+----------------------+------------------+
| Salem      |              5499.00 |                1 |
| Madurai    |              3097.00 |                1 |
| Trichy     |              2499.00 |                1 |
| Coimbatore |              2007.50 |                6 |
| Chennai    |              1597.50 |                2 |
+------------+----------------------+------------------+
```

### Query 5: Orders Without a Payment Record

```text
+----------+--------------------+------------+--------------+
| order_id | customer_details   | order_date | order_status |
+----------+--------------------+------------+--------------+
|     1012 | Vikram N - Chennai | 10-Apr-2026| PLACED       |
+----------+--------------------+------------+--------------+
```

### Query 6: Customers Who Have Never Placed an Order

```text
+-------------+-----------------+
| customer_id | customer_label  |
+-------------+-----------------+
|          10 | TARA M (Ooty)    |
+-------------+-----------------+
```

### Query 7: Product Category Revenue Share

```text
+-----------------+------------------+----------------------+
| category_name   | category_revenue | revenue_share_percent|
+-----------------+------------------+----------------------+
| Electronics     |          5593.00 |                21.65 |
| Furniture       |          5499.00 |                21.28 |
| Footwear        |          4998.00 |                19.35 |
| Home Appliances |          2598.00 |                10.06 |
| Clothing        |          2097.00 |                 8.12 |
| Sports          |          1798.00 |                 6.96 |
| Grocery         |          1497.00 |                 5.79 |
| Stationery      |           960.00 |                 3.72 |
| Personal Care   |           796.00 |                 3.08 |
+-----------------+------------------+----------------------+
```

### Query 8: Calendar Day with the Highest Sales Revenue

```text
+------------+---------------+
| sales_day  | daily_revenue |
+------------+---------------+
| 2026-03-21 |       5499.00 |
+------------+---------------+
```

### NULL Demonstration 1: Payment Aggregate Functions

```text
+--------------+------------------------+-----------------+---------------+----------------------+
| payment_rows | rows_with_payment_date | sum_of_amounts  | average_amount| sum_with_zero_default|
+--------------+------------------------+-----------------+---------------+----------------------+
|           11 |                     11 |        26335.00 |       2394.09 |             26335.00 |
+--------------+------------------------+-----------------+---------------+----------------------+
```

### NULL Demonstration 2: COUNT, SUM and AVG with Explicit NULL

```text
+------------+------------------+---------------------+------------------------+
| total_rows | non_null_values  | sum_ignoring_null   | average_ignoring_null  |
+------------+------------------+---------------------+------------------------+
|          3 |                2 |                  40 |                     20 |
+------------+------------------+---------------------+------------------------+
```

### Query 9: WHERE and HAVING – Completed Orders per Customer

```text
+-------------+-------------+
| customer_id | order_count |
+-------------+-------------+
|           1 |           5 |
+-------------+-------------+
```

*To reproduce these outputs, first run the Day 5 `schema.sql` and `seed_data.sql`, then run the Day 6 `setup.sql`, `seed_data.sql` and `reports.sql` in that order. The displayed values are based on the included sample records.*
