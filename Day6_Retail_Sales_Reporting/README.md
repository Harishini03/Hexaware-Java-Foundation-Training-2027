# Day 6 – Retail Sales Reporting

**Selected assignment:** Set 1 – Retail Sales Reporting  
**Database:** MySQL 8.4  
**Scenario:** Retail sales and reporting

## Objective
Prepare useful sales reports from customer, product, order, order-item and payment information. The queries demonstrate aggregate functions, grouping, filtering grouped results, joins and handling of NULL values.

## Files in this folder
| File | Purpose |
|---|---|
| `setup.sql` | Creates the customer, store, employee, product-pricing, sales-order, order-item, payment, return and refund tables |
| `seed_data.sql` | Inserts reproducible sample data used by the Day 6, Day 7 and Day 8 SQL exercises |
| `reports.sql` | Contains the sales-report queries, aggregate calculations, joins and WHERE/HAVING/NULL demonstrations |
| `expected_results.md` | Explains each report and describes the expected result structure and key sample values |

## Prerequisite
The Day 6 setup extends the `retail_inventory` database created for Day 5. Before running this folder, complete the following from `Day5_Retail_Inventory_Management`:

1. Execute `schema.sql`.
2. Execute `seed_data.sql`.

## How to run
From this folder, execute these files in order:

1. `setup.sql`
2. `seed_data.sql`
3. `reports.sql`

Use MySQL Workbench or the MySQL command-line client. The scripts use InnoDB and are written for MySQL 8.4.

## Important notes
- Run the setup and seed scripts in the same MySQL schema/session environment.
- The Day 6 sample data is also used by the Day 7 returns/refunds queries and Day 8 inventory-reservation and ranking exercises. Do not create duplicate copies of these tables for those days.
- Read `expected_results.md` alongside the query output. It describes expected results but is not a substitute for screenshots of your own execution.
