# Day 5 – Retail Inventory Management (MySQL 8.4)

**Selected assignment:** Set 1 – Retail Inventory Management.

## Scenario
A retailer originally stores SKU, product name, category, supplier name, supplier phone, warehouse, quantity and reorder level in one spreadsheet. This solution separates the data into related tables and normalises the design to 3NF.

## Deliverables
- `schema.sql` – database, InnoDB tables, keys, constraints and referential actions.
- `seed_data.sql` – 10 rows in each table.
- `er_diagram.md` – ER diagram and relationship explanation.
- `normalisation.md` – 1NF, 2NF, 3NF and anomalies.
- `failing_inserts.sql` – four intentional constraint violations.
- `failing_insert_evidence.md` – expected MySQL errors and how to capture actual evidence.
- `operations_and_checks.sql` – UPDATE, DELETE, before/after SELECTs and system-database inspection.

## Run in MySQL 8.4
Run these in order:
1. Open and execute `schema.sql`.
2. Execute `seed_data.sql`.
3. Execute `operations_and_checks.sql` (the UPDATE/DELETE demonstration changes the sample data).
4. Run each statement in `failing_inserts.sql` separately to observe its expected error.

You can use MySQL Workbench or the MySQL command-line client. The failing statements are intentionally invalid; do not mix them into the normal seed script.

## Important
The SQL is written for MySQL 8.4. The error messages listed in `failing_insert_evidence.md` are expected MySQL error codes/messages based on the constraints; they are not represented as screenshots or as a claim that the statements were executed on a live MySQL server.
