# Day 7 – Retail Returns and Refunds

**Selected assignment:** Set 3 – Retail Returns and Refunds  
**Database:** MySQL 8.4  
**Scenario:** Analyse product returns, customer refunds and store operations

## Objective
Use retail transaction data to answer business questions about returned products, refund status and refund values. The exercises also demonstrate employee reporting relationships and different ways to express conditions using joins and subqueries.

## Files in this folder
| File | Purpose |
|---|---|
| `advanced_reports.sql` | Business-report queries using joins, IN, EXISTS, NOT EXISTS, ANY, ALL and nested subqueries |
| `join_and_subquery_notes.md` | Explains the join choices, subquery patterns, NULL-related behaviour and expected sample-result checks |

## Prerequisites
This folder uses the retail tables and sample records created for Day 6. Complete the following before running Day 7:

1. In `Day5_Retail_Inventory_Management`, execute `schema.sql` and `seed_data.sql`.
2. In `Day6_Retail_Sales_Reporting`, execute `setup.sql` and then `seed_data.sql`.

Do not create another copy of the shared tables. Run all scripts against the same MySQL database.

## How to run
1. Open `advanced_reports.sql` in MySQL Workbench.
2. Execute the queries and inspect each result.
3. Read `join_and_subquery_notes.md` to understand why each join or subquery is used.

## Important notes
- The `NOT IN` condition can behave unexpectedly when its subquery returns NULL. The notes explain the NULL-safe alternative using `NOT EXISTS`.
- The SQL files contain query examples; execute them after the prerequisites have created and populated the required tables.
- Expected-result descriptions are guidance and may vary if you change the sample data.

## Sample Output – Returns and Refunds

Expected checks from the Day 6 sample data:

| Query | Result to verify |
|---|---|
| Return rate above 10% | SKU001 – 42.86%; SKU002 – 25.00%; SKU003 – 50.00%; SKU004 – 12.50% |
| Returns without refund | Aarav Kumar and Meera S have at least one matching return without a refund |
| Store refund ranking | Chennai Central – ₹1,419.00; Central Coimbatore – ₹1,298.00 |
| Products without returns | SKU005, SKU006, SKU007, SKU008, SKU009, SKU011 and SKU012 |
| Average store refund comparison | Average processed refund total across five stores – ₹543.40 |
| Highest returned units | SKU001 – 3 units |

*Expected-result checks based on the shared sample records. See join_and_subquery_notes.md for explanations.*
