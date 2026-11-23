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

## Sample Results – Sales Reports

The following tables show sample result rows for each task using the supplied retail sales dataset.

### Task 1 – Top Five Products by Revenue

| SKU | Product Name | Units Sold | Revenue |
|---|---|---:|---:|
| SKU001 | Wireless Mouse | 7 | ₹5,593.00 |
| SKU005 | Office Chair | 1 | ₹5,499.00 |
| SKU007 | Running Shoes | 2 | ₹4,998.00 |
| SKU003 | Electric Kettle | 2 | ₹2,598.00 |
| SKU006 | Cotton T Shirt | 3 | ₹2,097.00 |

### Task 2 – Month-wise Sales

| Month | Completed Orders | Revenue |
|---|---:|---:|
| January 2026 | 3 | ₹4,254.00 |
| February 2026 | 3 | ₹6,591.00 |
| March 2026 | 4 | ₹12,991.00 |
| April 2026 | 1 | ₹2,499.00 |

### Task 3 – Customers with More Than Three Orders

| Customer Name | Order Count |
|---|---:|
| Aarav Kumar | 5 |

### Task 4 – Average Basket Value by City

| City | Average Basket Value | Number of Orders |
|---|---:|---:|
| Salem | ₹5,499.00 | 1 |
| Madurai | ₹3,097.00 | 1 |
| Trichy | ₹2,499.00 | 1 |
| Coimbatore | ₹2,007.50 | 6 |
| Chennai | ₹1,597.50 | 2 |

### Task 5 – Orders Without Payment

| Order ID | Customer Details | Order Date | Order Status |
|---:|---|---|---|
| 1012 | Vikram N - Chennai | 10-Apr-2026 | PLACED |

### Task 6 – Customers Without Orders

| Customer ID | Customer |
|---:|---|
| 10 | TARA M (Ooty) |

### Task 7 – Product Category Revenue Share

| Category | Revenue | Revenue Share |
|---|---:|---:|
| Furniture | ₹5,499.00 | 20.88% |
| Electronics | ₹5,593.00 | 21.24% |
| Footwear | ₹4,998.00 | 18.98% |
| Home Appliances | ₹2,598.00 | 9.86% |
| Clothing | ₹2,097.00 | 7.96% |
| Grocery | ₹1,996.00 | 7.58% |
| Sports | ₹1,798.00 | 6.83% |
| Stationery | ₹960.00 | 3.65% |
| Personal Care | ₹798.00 | 3.03% |

### Task 8 – Highest-sales Day

| Sales Date | Daily Revenue |
|---|---:|
| 21 March 2026 | ₹5,499.00 |

### NULL Demonstration – COUNT, SUM and AVG

| Total Rows | Non-NULL Values | SUM | AVG |
|---:|---:|---:|---:|
| 3 | 2 | 40 | 20 |

*These are sample result values based on the SQL files and included seed data. Run `setup.sql`, `seed_data.sql` and `reports.sql` in order to reproduce the results.*
