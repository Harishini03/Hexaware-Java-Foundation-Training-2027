# Day Retail_Order_Fulfilment – Task Outputs

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
