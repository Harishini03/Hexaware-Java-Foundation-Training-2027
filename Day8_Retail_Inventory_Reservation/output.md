# Day Retail_Inventory_Reservation – Task Outputs

## Sample Output – Transaction Verification

The Day 5 seed data starts SKU001 at 40 units in warehouse 1.

| Test | Expected result |
|---|---|
| Before reservation | SKU001, warehouse 1 – 40 units |
| Insufficient-stock call (order 9001) | Error: “Insufficient stock; order was rolled back” |
| After failed call | Stock remains 40; order 9001 and its order item are absent |
| Successful reservation (order 9002, quantity 2) | Procedure completes successfully |
| After successful call | SKU001, warehouse 1 – 38 units; order 9002 and its order item exist |

*Expected checks from the provided procedure and seed data. Run failure and success tests separately in your test database.*
