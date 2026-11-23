# Day 8 – Retail Inventory Reservation

**Selected assignment:** Set 3 – Retail Inventory Reservation  
**Database:** MySQL 8.4  
**Storage engine:** InnoDB

## Objective
Demonstrate how a retail system can reserve stock safely during an order. The stored procedure validates available stock, locks the relevant row, creates the reservation within a transaction and commits or rolls back the operation. The reporting queries demonstrate ranking and trend analysis.

## Files in this folder
| File | Purpose |
|---|---|
| `reservation.sql` | Stored procedure for stock reservation, row locking, stock validation, COMMIT and rollback-on-error |
| `rank_report.sql` | Correlated subqueries, CTEs, category ranking, monthly LAG/LEAD analysis and RANK/DENSE_RANK comparison |
| `acid_explanation.md` | ACID properties, transaction workflow, rollback behaviour and explanation of non-transactional table behaviour |

## Prerequisites
The reservation and reporting scripts use the retail database and sample data prepared in the earlier assignments. Complete these steps first, in the same MySQL database:

1. In `Day5_Retail_Inventory_Management`, execute `schema.sql` and `seed_data.sql`.
2. In `Day6_Retail_Sales_Reporting`, execute `setup.sql` and `seed_data.sql`.

Do not create duplicate copies of the shared tables.

## How to run
1. Open `reservation.sql` in MySQL Workbench and execute the procedure definition.
2. Run the insufficient-stock test CALL. It is designed to fail and demonstrate rollback.
3. After the expected error, execute the verification SELECT statements to confirm that stock and order data were not partially changed.
4. Run the successful reservation CALL and inspect the resulting records.
5. Execute `rank_report.sql`.
6. Read `acid_explanation.md` to understand the transaction behaviour.

## Important notes
- The insufficient-stock error is intentional; it is not a syntax failure. Do not skip the verification queries after it.
- The procedure relies on InnoDB transactions and `SELECT ... FOR UPDATE`. Run it in a test database, not against live customer or inventory records.

## Outputs
See [`output.md`](output.md) for the task output and expected result checks.
