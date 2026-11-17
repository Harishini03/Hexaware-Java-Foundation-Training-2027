# Day 7 – Retail Returns and Refunds: Explanation

**Selected assignment:** Set 3 – Retail Returns and Refunds  
**Database:** `retail_inventory` | **MySQL:** 8.4 LTS

## Join-choice table

| Query | Join type | Why it is used |
|---|---|---|
| Q1 Return rate | INNER + LEFT | INNER joins restrict the calculation to sold products; LEFT JOIN retains sold order lines even when they have no return. |
| Q2 Returns without refund | INNER + LEFT | INNER JOIN follows a return to its customer; LEFT JOIN keeps the return even when no refund row exists. |
| Q3 Store refund ranking | LEFT | All stores remain in the report, including stores with no refund activity. |
| Q4 Employee and manager | SELF LEFT JOIN | The employee table is joined to itself; LEFT JOIN keeps employees without a manager. |
| Q5 Return details | INNER | Each displayed return must have a valid order, customer, product and store. |
| Q7 Refund by region | INNER | Only stores with an associated refund record contribute to this grouped report. |

## Subquery concepts

- **IN:** tests whether a value belongs to a returned list. It is useful for membership checks.
- **EXISTS:** checks whether a related row exists. It is suitable for correlated existence checks.
- **NOT EXISTS:** finds rows without a matching related row and is safe when the subquery contains NULL values.
- **ANY:** the comparison is true when it is true for at least one value returned by the subquery.
- **ALL:** the comparison must be true for every value returned by the subquery.
- **Nested subquery:** a query is placed inside another query. The two nested examples in `advanced_reports.sql` calculate store refund totals and the maximum returned units.

## NOT IN and NULL

A comparison such as `customer_id NOT IN (1, 2, NULL)` cannot determine that a non-matching customer is definitely absent. SQL's three-valued logic makes the comparison UNKNOWN, so the row is filtered out by WHERE. The deliberately unsafe query in the SQL file demonstrates this. The following `NOT EXISTS` query is the corrected approach because it checks for a matching customer/order pair rather than comparing against a list that may contain NULL.

## Reading the results

The SQL file contains ten numbered business queries. Q1 calculates returned units divided by sold units; Q2 finds customers with returns that have no refund row; Q3 and Q7 summarize refunds; Q4 demonstrates a self join; Q8 demonstrates an anti-join; Q9 and Q10 demonstrate ANY and ALL. The final statements demonstrate the NULL pitfall and two nested queries.

The queries are designed for the sample records in Day 6 `seed_data.sql`. Their outputs should be captured from MySQL Workbench after running the scripts; this note does not claim that a live database execution or screenshot has already been performed.
