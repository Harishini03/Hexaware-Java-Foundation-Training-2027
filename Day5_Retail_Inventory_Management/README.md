# Day 5 – Retail Inventory Management

**Selected assignment:** Set 1 – Retail Inventory Management  
**Database:** MySQL 8.4  
**Storage engine:** InnoDB

## Objective
Design a relational database for a retailer that previously maintained product, supplier and warehouse information in one spreadsheet. The solution separates the data into related tables and demonstrates keys, constraints, referential integrity and normalisation up to 3NF.

## Files in this folder
| File | Purpose |
|---|---|
| `schema.sql` | Creates the database and tables with primary keys, foreign keys, constraints and referential actions |
| `seed_data.sql` | Inserts the sample records |
| `er_diagram.md` | ER diagram and explanation of table relationships |
| `normalisation.md` | 1NF, 2NF, 3NF and update/insert/delete anomalies |
| `operations_and_checks.sql` | UPDATE, DELETE, verification queries and system-database inspection |
| `failing_inserts.sql` | Four intentional examples of constraint violations |
| `failing_insert_evidence.md` | Explains the expected constraint errors |

## How to run
Run the scripts in MySQL Workbench or the MySQL command-line client, in this order:

1. Open and execute `schema.sql`.
2. Execute `seed_data.sql`.
3. Execute `operations_and_checks.sql`.
4. Execute each statement in `failing_inserts.sql` separately to observe the expected constraint errors.

## Important notes
- This folder is the starting point for the retail database used in this assignment.
- The UPDATE and DELETE examples change sample records. Re-run the schema and seed scripts if you need a fresh copy of the original data.
- The statements in `failing_inserts.sql` are deliberately invalid. Run them separately, not as part of the normal setup.

## Sample Output – Seed Data Verification

After running the seed script, the verification query should return:

| Table name | Expected row count |
|---|---:|
| category | 10 |
| supplier | 10 |
| warehouse | 10 |
| product | 10 |
| inventory | 10 |

**Example inventory records**

| SKU | Product | Warehouse | Quantity | Reorder level |
|---|---|---|---:|---:|
| SKU001 | Wireless Mouse | Central Warehouse | 40 | 10 |
| SKU002 | Organic Rice 5kg | North Storage | 75 | 20 |
| SKU003 | Electric Kettle | South Storage | 18 | 5 |
| SKU004 | Notebook Pack | East Distribution | 120 | 25 |
| SKU005 | Office Chair | West Distribution | 12 | 4 |

*Expected values are taken from the included seed script. Results will differ if you modify the sample data.*
