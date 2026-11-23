# Day 10 – Retail Price Change Audit Task Outputs

## Sample Output – Trigger Tests

| Test | Expected result |
|---|---|
| Valid update for one SKU | One audit row is inserted with old price, new price, database user and timestamp |
| Valid update for two SKUs | Two audit rows are inserted (one per updated row) |
| Selling price changed below cost | Update is rejected with SQLSTATE 45000 |
| Rejected update audit check | No audit row is created for the rejected change |
| Trigger inspection | Both BEFORE and AFTER triggers appear in information_schema.TRIGGERS |

*Exact prices and timestamps depend on current database records. Run test_evidence.sql and inspect the audit table to obtain actual values.*
