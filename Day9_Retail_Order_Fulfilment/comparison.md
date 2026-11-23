# Day 9 – Cursor vs Set-Based Processing

## What does the cursor do?
A cursor reads query results one row at a time. In this assignment, it fetches each old pending order and inserts a follow-up record for it.

### Important cursor steps
1. Declare the cursor with the SELECT query.
2. Declare a `CONTINUE HANDLER FOR NOT FOUND`. It sets a flag when there are no more rows.
3. Open the cursor.
4. Fetch one order number inside a loop.
5. Leave the loop when the flag becomes true.
6. Insert the follow-up row.
7. Close the cursor.

The handler must be declared before executable statements in the procedure block.

## Set-based alternative
The `INSERT ... SELECT` statement inserts all matching follow-up rows in one database statement. It uses `NOT EXISTS` to avoid duplicate follow-ups.

## Comparison

| Cursor approach | Set-based approach |
|---|---|
| Processes one row at a time | Processes all matching rows together |
| Needs cursor, fetch, loop and handler | Usually one SQL statement |
| Useful when each row needs different procedural steps | Best for straightforward bulk data changes |
| More code and overhead | Usually simpler and faster |

## How to compare fairly
1. Run `CALL sp_queue_old_orders_cursor();`.
2. Record the number of inserted rows.
3. Clear the demonstration queue rows with `DELETE FROM order_follow_up;` only if you are resetting this practice data.
4. Run the set-based `INSERT ... SELECT` statement.
5. Compare the row counts and elapsed time shown by Workbench.

Do not claim a measured execution-time result until you actually run both versions on your MySQL instance. For a tiny sample, timing differences may be too small to be meaningful.

## Function vs procedure

| Stored function | Stored procedure |
|---|---|
| Returns one value using `RETURN` | Can return values through OUT/INOUT parameters |
| Can be used inside expressions such as SELECT | Called using `CALL` |
| Suitable for reusable calculations | Suitable for multi-step tasks and transactions |
| Example: `fn_order_total_with_tax` | Example: `sp_place_order` |

## Verification queries
```sql
SELECT * FROM vw_order_summary;
SELECT * FROM vw_low_stock;
SELECT * FROM fulfilment_order ORDER BY order_no DESC;
SELECT * FROM fulfilment_order_line ORDER BY line_id DESC;
SELECT * FROM inventory WHERE sku = 'SKU001' AND warehouse_id = 1;
SELECT * FROM order_follow_up ORDER BY follow_up_id;
```

## Expected checks
- A successful order creates one header row and one line row.
- The requested stock decreases by the ordered quantity.
- The function returns quantity × unit price plus tax.
- An insufficient-stock request raises SQLSTATE 45000 and the transaction handler rolls back the order and stock change.
- Both cursor and set-based methods identify the same eligible old pending orders when run against the same starting data.
