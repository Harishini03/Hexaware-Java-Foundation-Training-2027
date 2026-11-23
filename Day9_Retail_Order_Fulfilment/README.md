# Day 9 – Retail Order Fulfilment

## Objective
Move important order rules into MySQL so that every application follows the same stock and order logic.

**Selected assignment:** Set 1 – Retail Order Fulfilment (from the Day 9 assignment sheet).

## What you will learn
- Create views to show only the columns a user needs.
- Use `WITH CHECK OPTION` to stop invalid updates through a view.
- Create a stored procedure with IN and OUT parameters.
- Use a transaction and an exception handler to roll back a failed order.
- Create and call a stored function.
- Use a cursor with a `NOT FOUND` handler.
- Compare a cursor with a set-based `INSERT ... SELECT`.
- Raise a clear business error with `SIGNAL`.

## Files in this folder
| File | Purpose |
|---|---|
| `schema_and_seed.sql` | Creates the Day 9 order tables and sample product prices |
| `views.sql` | Creates the two requested views and demonstrates an updatable view |
| `procedures.sql` | Creates the order procedure, total function and business-error example |
| `cursor.sql` | Creates follow-up queue, cursor procedure and set-based alternative |
| `comparison.md` | Beginner-friendly cursor vs set-based explanation and checks |

## Before you start
1. Install and open MySQL Workbench with MySQL 8.4.
2. Run the Day 5 database setup and seed scripts first:
   - `Day5_Retail_Inventory_Management/schema.sql`
   - `Day5_Retail_Inventory_Management/seed_data.sql`
3. The scripts here use the existing `retail_inventory` database, `product` and `inventory` tables.
4. Run the files in the order below.

## Execution order
1. Open `schema_and_seed.sql`, select all, and execute.
2. Execute `views.sql`.
3. Execute `procedures.sql`.
4. Execute `cursor.sql`.
5. Read `comparison.md` and run its verification queries.

Each SQL file sets the required database and has its own delimiter statements. Run the complete file, not only a selected middle section.

## Important testing notes
- The insufficient-stock procedure call is intentionally expected to fail and roll back. Run it separately so you can see the error, then verify that no partial order or stock deduction remains.
- The successful order example uses SKU001 in warehouse 1. The Day 5 sample data provides 40 units initially.
- The cursor and set-based examples each insert follow-up rows. Clear the demonstration rows between the two tests if you want to compare row counts fairly.
- The scripts are written for MySQL 8.4 but have not been executed against a local Workbench instance.

## Expected learning outcome
You should be able to explain how a view hides columns, how a transaction protects stock, why a procedure uses an OUT parameter, how a cursor reaches the end of its result set, and why a set-based statement is usually simpler for bulk work.

## Sample Output – Verification Checklist

| Feature | Expected result |
|---|---|
| Order summary view | Displays the selected order summary columns |
| Low-stock view | Lists inventory records that meet the low-stock condition |
| Successful order procedure | Creates one order header and its order line |
| Inventory update | Decreases stock by the ordered quantity |
| Order total function | Returns quantity × unit price plus tax |
| Insufficient-stock procedure call | Raises SQLSTATE 45000 and rolls back the order and stock change |
| Cursor and set-based insert | Both identify the same eligible old pending orders when started from the same data |

*Actual row values depend on database state. Use the verification queries in comparison.md after executing the SQL files.*
