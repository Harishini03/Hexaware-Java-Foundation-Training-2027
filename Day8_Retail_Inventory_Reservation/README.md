# Day 8 – Retail Inventory Reservation (MySQL 8.4)

**Selected assignment:** Set 3 – Retail Inventory Reservation.

## Deliverables
- `reservation.sql` – stored procedure for atomic stock reservation, row locking, stock validation, COMMIT and rollback-on-error evidence.
- `rank_report.sql` – correlated stock comparison, CTE top-three category ranking, LAG/LEAD monthly trend and RANK/DENSE_RANK comparison.
- `acid_explanation.md` – ACID explanation, transaction steps, rollback evidence checklist and non-transactional failure case.

## Run order
1. Complete Day 5 schema and seed scripts.
2. Complete Day 6 `setup.sql` and `seed_data.sql`.
3. Run `reservation.sql` in MySQL Workbench. The insufficient-stock CALL is an intentional error test; after it reports the expected error, execute the verification SELECT statements, then run the successful CALL.
4. Run `rank_report.sql`.
5. Read `acid_explanation.md` and capture the actual before/after results and error output from your database.

## Important
The procedure uses InnoDB tables and `SELECT ... FOR UPDATE`. Run the scripts in a test database, not against live customer or inventory records. The intentional failure is expected and is used to demonstrate rollback.
