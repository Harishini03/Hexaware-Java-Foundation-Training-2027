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
