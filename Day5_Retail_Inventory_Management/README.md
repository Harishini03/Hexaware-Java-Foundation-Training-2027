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
| `failing_insert_evidence.md` | Expected errors and instructions for capturing actual MySQL evidence |

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
- Error descriptions in the evidence notes explain the expected behaviour; capture your own result grids and error messages from MySQL Workbench for submission.
