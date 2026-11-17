# Day 6 – Retail Sales Reporting (MySQL 8.4)

**Selected assignment:** Set 1 – Retail Sales Reporting.

## Business scenario
The retail sales team needs daily and monthly reporting from customers, products, orders, order items and payments. This solution uses the Day 5 `retail_inventory` database and extends it with sales and customer data.

## Deliverables
- `setup.sql` – creates customers, stores, employees, product prices, sales orders, order items, payments, returns and refunds.
- `seed_data.sql` – inserts reproducible sample data for Days 6–8.
- `reports.sql` – eight required sales reports plus NULL behaviour and WHERE/HAVING demonstrations.
- `expected_results.md` – purpose and expected result structure for every report.

## Run order
1. Run the Day 5 `schema.sql` and `seed_data.sql`.
2. Run `setup.sql`.
3. Run `seed_data.sql`.
4. Run `reports.sql`.

Use MySQL Workbench or the MySQL command-line client. The setup and sample inserts use InnoDB and are designed for MySQL 8.4.
