# Java Track – SQL Assignments (Days 5–8)

This repository contains selected, completed assignment solutions and supporting notes. The SQL work for Days 6, 7 and 8 uses one consistent **Retail Operations and Inventory Management** scenario.

## Assignment selection

| Day | Selected set | Business focus | Main concepts |
|---|---|---|---|
| Day 5 | Set 1 | Retail Inventory Management | Table design, keys, constraints, normalisation and DML |
| Day 6 | Set 1 | Retail Sales Reporting | Aggregate functions, GROUP BY, HAVING, joins, NULL handling and reporting |
| Day 7 | Set 3 | Retail Returns and Refunds | Joins, self joins, IN, EXISTS, NOT EXISTS, ANY, ALL and nested subqueries |
| Day 8 | Set 3 | Retail Inventory Reservation | Transactions, rollback, ACID, correlated subqueries, CTEs and window functions |

## Folder guide

- [Day 5 – Retail Inventory Management](./Day5_Retail_Inventory_Management/)
- [Day 6 – Retail Sales Reporting](./Day6_Retail_Sales_Reporting/)
- [Day 7 – Retail Returns and Refunds](./Day7_Retail_Returns_and_Refunds/)
- [Day 8 – Retail Inventory Reservation](./Day8_Retail_Inventory_Reservation/)

## Recommended execution order

1. Run Day 5 `schema.sql`.
2. Run Day 5 `seed_data.sql`.
3. Run Day 6 `setup.sql` to create the shared retail sales, customer, store, employee, returns and refund tables.
4. Run Day 6 `seed_data.sql` to load sample records for all three assignments.
5. Run the Day 6 `reports.sql`.
6. Run Day 7 `advanced_reports.sql`.
7. Run Day 8 `reservation.sql`, then `rank_report.sql`.

Use **MySQL 8.4 LTS** and InnoDB. Read each folder's README before executing its scripts. Day 8 contains one intentional insufficient-stock failure call to demonstrate rollback; verify the unchanged stock and absent order after that expected error before running the successful reservation call.

## Evidence

The Markdown result guides explain expected result shapes and concepts. Capture actual result grids, error output and transaction before/after values from your own MySQL Workbench session when submitting execution evidence. Expected outputs in the notes are not represented as screenshots or as proof of a live execution.
