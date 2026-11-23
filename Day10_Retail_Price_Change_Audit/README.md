# Day 10 – Retail Price Change Audit

## Objective
Keep a record of product price changes and prevent a selling price from being lower than its cost price.

**Selected assignment:** Set 1 – Retail Price Change Audit (from the Day 10 assignment sheet).

## What you will learn
- Difference between BEFORE and AFTER triggers.
- How `OLD` and `NEW` refer to row values.
- How MySQL triggers work once for each affected row.
- How `SIGNAL SQLSTATE '45000'` rejects an invalid change.
- How to test one-row and multi-row updates.
- How to list triggers using `information_schema`.

## Files
| File | Purpose |
|---|---|
| `triggers.sql` | Creates the audit table and both triggers |
| `test_evidence.sql` | Contains valid, invalid and multi-row test statements |
| `pitfalls.md` | Explains trigger risks and when application logic is preferable |

## Prerequisites
1. MySQL 8.4 and MySQL Workbench.
2. Complete Day 5 database setup and seed data.
3. Complete Day 9 `schema_and_seed.sql`, because this assignment uses `retail_inventory.product_price`.

## Execution order
1. Run Day 9 `schema_and_seed.sql` if it has not been run.
2. Run `triggers.sql`.
3. Run the successful tests in `test_evidence.sql`.
4. Run each intentionally failing statement separately (they are commented out by default).
5. Run the information_schema query to verify that both triggers exist.
6. Read `pitfalls.md`.

## Expected behaviour
- A valid update is recorded with old price, new price, database user and timestamp.
- An update that makes the selling price lower than cost is rejected with a readable error.
- MySQL executes the trigger once for each affected row.
- With InnoDB, a failing row-level trigger causes the failing statement to fail; rows changed by that statement are rolled back as part of statement atomicity.

The SQL is prepared for MySQL 8.4 but has not been run on a local database.
