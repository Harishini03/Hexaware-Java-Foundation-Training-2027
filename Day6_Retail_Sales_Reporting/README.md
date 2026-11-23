# Day 6 – Retail Sales Reporting

**Selected assignment:** Set 1 – Retail Sales Reporting  
**Database:** MySQL 8.4  
**Scenario:** Retail sales and reporting

## Objective
Prepare useful sales reports from customer, product, order, order-item and payment information. The queries demonstrate aggregate functions, grouping, filtering grouped results, joins and handling of NULL values.

## Files in this folder
| File | Purpose |
|---|---|
| `setup.sql` | Creates the customer, store, employee, product-pricing, sales-order, order-item, payment, return and refund tables |
| `seed_data.sql` | Inserts reproducible sample data used by the Day 6, Day 7 and Day 8 SQL exercises |
| `reports.sql` | Contains the sales-report queries, aggregate calculations, joins and WHERE/HAVING/NULL demonstrations |
| `expected_results.md` | Explains each report and describes the expected result structure and key sample values |

## Prerequisite
The Day 6 setup extends the `retail_inventory` database created for Day 5. Before running this folder, complete the following from `Day5_Retail_Inventory_Management`:

1. Execute `schema.sql`.
2. Execute `seed_data.sql`.

## How to run
From this folder, execute these files in order:

1. `setup.sql`
2. `seed_data.sql`
3. `reports.sql`

Use MySQL Workbench or the MySQL command-line client. The scripts use InnoDB and are written for MySQL 8.4.

## Important notes
- Run the setup and seed scripts in the same MySQL schema/session environment.
- The Day 6 sample data is also used by the Day 7 returns/refunds queries and Day 8 inventory-reservation and ranking exercises. Do not create duplicate copies of these tables.
- Read `expected_results.md` alongside the query output. It describes expected results and key sample values.

## Exact Sample Query Outputs

The following tables show the result rows produced by the queries in `reports.sql` when they are run against the supplied Day 6 sample data. These are result tables, not descriptions of what a query is expected to return.

### Task 1 – Top Five Products by Revenue (Q1)

| SKU | Product Name | Units Sold | Revenue |
|---|---|---:|---:|
| SKU001 | Wireless Mouse | 7 | 5593.00 |
| SKU005 | Office Chair | 1 | 5499.00 |
| SKU007 | Running Shoes | 2 | 4998.00 |
| SKU003 | Electric Kettle | 2 | 2598.00 |
| SKU006 | Cotton T Shirt | 3 | 2097.00 |

### Task 2 – Month-wise Sales (Q2)

| Sales Month | Completed Orders | Monthly Revenue |
|---|---:|---:|
| 2026-01 | 3 | 4254.00 |
| 2026-02 | 3 | 6591.00 |
| 2026-03 | 4 | 12991.00 |
| 2026-04 | 1 | 2499.00 |

### Task 3 – Customers with More Than Three Orders (Q3)

| Customer ID | Customer Name | Order Count |
|---:|---|---:|
| 1 | AARAV KUMAR | 5 |

### Task 4 – Average Basket Value by Customer City (Q4)

| City | Average Basket Value | Number of Orders |
|---|---:|---:|
| Salem | 5499.00 | 1 |
| Madurai | 3097.00 | 1 |
| Trichy | 2499.00 | 1 |
| Coimbatore | 2007.50 | 6 |
| Chennai | 1597.50 | 2 |

### Task 5 – Orders Without a Payment Record (Q5)

| Order ID | Customer Details | Order Date | Order Status |
|---:|---|---|---|
| 1012 | Vikram N - Chennai | 10-Apr-2026 | PLACED |

### Task 6 – Customers Who Have Never Placed an Order (Q6)

| Customer ID | Customer Label |
|---:|---|
| 10 | TARA M (Ooty) |

### Task 7 – Product Category Revenue Share (Q7)

| Category Name | Category Revenue | Revenue Share (%) |
|---|---:|---:|
| Electronics | 5593.00 | 21.65 |
| Furniture | 5499.00 | 21.28 |
| Footwear | 4998.00 | 19.35 |
| Home Appliances | 2598.00 | 10.06 |
| Clothing | 2097.00 | 8.12 |
| Sports | 1798.00 | 6.96 |
| Grocery | 1497.00 | 5.79 |
| Stationery | 960.00 | 3.72 |
| Personal Care | 796.00 | 3.08 |

### Task 8 – Calendar Day with the Highest Sales Revenue (Q8)

| Sales Day | Daily Revenue |
|---|---:|
| 2026-03-21 | 5499.00 |

### NULL Demonstration – Payment Aggregates

| Payment Rows | Rows with Payment Date | Sum of Amounts | Average Amount | Sum with Zero Default |
|---:|---:|---:|---:|---:|
| 11 | 11 | 26335.00 | 2394.09 | 26335.00 |

### NULL Demonstration – Explicit NULL Values

| Total Rows | Non-NULL Values | Sum Ignoring NULL | Average Ignoring NULL |
|---:|---:|---:|---:|
| 3 | 2 | 40 | 20 |

*To reproduce these outputs, first run the Day 5 `schema.sql` and `seed_data.sql`, then run the Day 6 `setup.sql`, `seed_data.sql` and `reports.sql` in that order. MySQL Workbench may display decimal values with a different number of trailing zeros.*
