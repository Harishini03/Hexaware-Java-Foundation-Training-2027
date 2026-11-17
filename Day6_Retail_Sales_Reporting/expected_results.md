# Day 6 – Retail Sales Reporting: Expected Results

**Database:** `retail_inventory`  
**Server:** MySQL 8.4 LTS  
**Selected assignment:** Set 1 – Retail Sales Reporting

Run `setup.sql`, `seed_data.sql`, and then `reports.sql` in that order. The expected outputs below describe the columns and result patterns from the supplied sample data; they are not screenshots of a live MySQL execution.

| Query | Purpose | Expected result |
|---|---|---|
| Q1 | Top five products by revenue | Five rows with SKU, product name, units sold and revenue, ordered from highest revenue to lowest. |
| Q2 | Month-wise sales | One row per month containing completed order count and revenue. The sample covers January–April 2026. |
| Q3 | Customers with more than three orders | Aarav Kumar appears with five orders. Other customers do not meet the threshold. |
| Q4 | Average basket value by city | One row per customer city represented in completed orders, with average order total and order count. |
| Q5 | Orders without payment | Order 1012 appears because no payment row was inserted for it. |
| Q6 | Customers without orders | Tara M (customer 10) appears. |
| Q7 | Category revenue share | One row per category with sales, revenue and percentage of total revenue. Percentages sum to approximately 100% (rounding may apply). |
| Q8 | Highest-sales day | One date and its daily revenue; ties are resolved by the earlier date. |
| NULL demonstration | COUNT/SUM/AVG behaviour | COUNT(*) counts all three demonstration rows; COUNT(sample_value) counts two; SUM is 40 and AVG is 20. |

## Important SQL concepts

- **WHERE:** filters source rows before grouping. In Q3, it keeps only completed orders.
- **HAVING:** filters groups after aggregation. In Q3, it keeps customers whose order count is greater than three.
- **COUNT(*):** counts rows, including rows where a particular column is NULL.
- **COUNT(column):** counts only non-NULL values in that column.
- **SUM(column) and AVG(column):** ignore NULL values. If all values are NULL, they return NULL.
- **COALESCE(expression, 0):** displays zero when the expression evaluates to NULL.
- **LEFT JOIN:** preserves every row from the left table, allowing Q5 and Q6 to find missing related records.
- **DATE_FORMAT, UPPER, CONCAT and ROUND:** format dates, names, labels and numeric output for reports.

## Key values from the supplied sample data

- **Q1 top five:** SKU001 – 5593.00; SKU005 – 5499.00; SKU007 – 4998.00; SKU003 – 2598.00; SKU006 – 2097.00.
- **Q2 monthly revenue:** January 2026 – 4254.00; February 2026 – 6591.00; March 2026 – 12991.00; April 2026 – 2499.00.
- **Q3:** Aarav Kumar has five orders and is the only customer above three orders.
- **Q4:** Coimbatore average basket value is 1462.50 across four completed orders; Chennai is 1597.50 across two completed orders.
- **Q5:** Order 1012 has no payment record.
- **Q6:** Tara M (customer 10) has no orders.
- **Q8:** 21 March 2026 has the highest daily revenue in the sample (5499.00).

These values are calculated from the included sample rows and are intended as checks when you run the SQL. The exact display format may differ by MySQL Workbench settings.
