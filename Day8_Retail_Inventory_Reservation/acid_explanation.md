# Day 8 – Retail Inventory Reservation: ACID Explanation

**Selected assignment:** Set 3 – Retail Inventory Reservation  
**Database:** `retail_inventory` | **Engine:** InnoDB | **Server:** MySQL 8.4 LTS

## Business scenario

When a customer places an order, the system must reserve the required stock, create the order and create its order line as one reliable operation. If the requested stock is unavailable or any insert/update fails, the complete operation must be undone.

## ACID properties

| Property | Meaning | Example in this project |
|---|---|---|
| Atomicity | All steps in a transaction succeed together, or all are undone. | If the inventory update fails, the order header and order line are rolled back as well. |
| Consistency | A transaction moves the database from one valid state to another while preserving constraints. | The inventory CHECK constraint prevents negative quantity, and foreign keys prevent an order line from referencing a missing product or order. |
| Isolation | Concurrent transactions should not interfere in a way that produces an invalid result. | `SELECT ... FOR UPDATE` locks the selected SKU/warehouse inventory row while a reservation is being processed. A second transaction must wait for that row lock before changing the same stock row. |
| Durability | Once COMMIT succeeds, the committed change is retained by the database. | After a successful reservation commits, the reduced stock and order records remain stored. |

## How the transaction works

1. Start a transaction.
2. Read and lock the matching inventory row with `SELECT ... FOR UPDATE`.
3. Check that the inventory row exists and the available quantity is sufficient.
4. Insert the order header.
5. Decrement inventory with an additional condition that quantity must remain sufficient.
6. Confirm that exactly one inventory row was updated.
7. Insert the order item.
8. Commit. If any SQL exception occurs, the error handler rolls back and rethrows the error.

## Rollback evidence to capture

Run the intentional failure call in `reservation.sql` with a quantity much larger than available stock. MySQL should report the custom insufficient-stock error. Then run the verification SELECT statements:

- The quantity for SKU001 in warehouse 1 should be the same as it was before the failed call.
- Order 9001 should not exist.
- Its order item should not exist.

Next, run the successful call for order 9002. The inventory quantity should decrease by two and the order/order-item records should exist. Capture the before/after result grids and the error message from your own MySQL Workbench session.

## Non-transactional design failure

If stock were stored in a non-transactional table such as MyISAM, a failure after decrementing stock might not undo that decrement. The database could then have lower stock without a matching order. InnoDB supports transactions, row-level locking and rollback, which are required for this workflow.

## Isolation note

The row lock is held until COMMIT or ROLLBACK. Two sessions reserving the same SKU in the same warehouse cannot both read and consume the same unlocked quantity at the same time. The second session waits for the first transaction to finish, then evaluates the updated quantity. This example demonstrates row-level locking; exact wait behaviour can be observed by running two Workbench sessions concurrently.
