# Four Deliberately Failing Inserts – Evidence Guide

Run `schema.sql` and `seed_data.sql` successfully first. Then execute the four INSERT statements in `failing_inserts.sql` **one at a time** in MySQL Workbench. They are designed to fail and should not add rows.

| Test | Violation | Expected MySQL error |
|---|---|---|
| 1 | Duplicate primary key `SKU001` | Error 1062: Duplicate entry for key PRIMARY |
| 2 | Product references missing category_id 999 | Error 1452: Cannot add or update a child row; foreign key constraint fails |
| 3 | Quantity is -5 | Error 3819: Check constraint is violated |
| 4 | Mandatory product_name is NULL | Error 1048: Column 'product_name' cannot be null |

## How to capture actual evidence
1. Open MySQL Workbench and connect to your MySQL 8.4 server.
2. Execute `failing_inserts.sql` one statement at a time (highlight one INSERT and click Execute).
3. Capture a screenshot showing the SQL statement and the Action Output/error message.
4. Save the four screenshots in your assignment evidence folder if your trainer asks for screenshots.

**Evidence note:** The error numbers above are the expected MySQL 8.4 outcomes based on the defined constraints. This repository documents the test statements and expected errors; screenshots must be captured from your own MySQL execution.
