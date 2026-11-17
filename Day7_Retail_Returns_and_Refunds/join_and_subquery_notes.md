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

## Expected result checks from the supplied sample data

These are result expectations derived from the inserted sample records. Capture the actual result grids from MySQL Workbench for submission evidence.

- **Q1:** Products above a 10% return rate include SKU001 (42.86%), SKU002 (25.00%), SKU003 (50.00%) and SKU004 (12.50%).
- **Q2:** Aarav Kumar and Meera S have at least one return without a refund record.
- **Q3:** Chennai Central (store 2) has the highest processed refund total (1419.00), followed by Central Coimbatore (store 1, 1298.00).
- **Q4:** Employee rows show each employee alongside their manager; employees without a manager display “No manager assigned”.
- **Q8:** Products with no return record include SKU005, SKU006, SKU007, SKU008, SKU009, SKU011 and SKU012.
- **Q9/Q10:** In the West region, Central Coimbatore has a higher processed refund total than Salem Main.
- **Nested query 1:** Central Coimbatore and Chennai Central exceed the average processed refund total across the five stores (543.40).
- **Nested query 2:** SKU001 has the greatest returned-unit total in the sample (three units).

## How the ten solutions should change if data volume grows 100 times

| Query | Scaling consideration |
|---|---|
| Q1 Return rate | Add indexes on `order_item(sku)`, `sales_return(order_item_id)` and `sales_order(order_id, order_status)`; aggregate return quantities before joining to avoid row multiplication if multiple return events are allowed per order line. |
| Q2 Returns without refund | Index `sales_return(order_item_id)` and `refund(return_id)`; retain the LEFT JOIN anti-match pattern and inspect the execution plan. |
| Q3 Store refund ranking | Aggregate refunds by store in a CTE or summary table before joining to the store list; this avoids repeatedly processing a large multi-table join. |
| Q4 Employee and manager | Index `employee(manager_id)` and `employee(store_id)`; use pagination or a filtered store/manager view for large employee lists. |
| Q5 Return detail | Add selective indexes on return date/status and foreign-key columns; return a date range or page of rows instead of loading the full history. |
| Q6 Return status summary | Index `sales_return(return_status)`; for frequent dashboards, maintain a refreshed summary table rather than repeatedly scanning every return. |
| Q7 Refund by region | Index `store(region)`, `sales_order(store_id)` and refund foreign keys; pre-aggregate processed refunds by store before grouping by region. |
| Q8 Products never returned | Keep the NOT EXISTS anti-join and ensure indexes exist on `order_item(sku)` and `sales_return(order_item_id)`; compare the plan with NOT IN only when NULL behaviour is controlled. |
| Q9 ANY comparison | Calculate store totals once in a CTE or summary table, index region/store identifiers, and avoid repeating expensive refund aggregation for every store. |
| Q10 ALL comparison | Use the same pre-aggregated store totals and region index; explicitly handle regions with no peer stores so ALL over an empty set does not produce misleading results. |

At 100 times the current volume, query plans should be checked with `EXPLAIN ANALYZE`, and date-based partitioning or maintained reporting summaries may be considered only after measuring the actual workload.
