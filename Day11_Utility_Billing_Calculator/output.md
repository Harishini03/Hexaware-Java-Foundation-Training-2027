# Day 11 – Utility Billing Calculator Task Outputs

## Sample Output – Electricity Bill

Example input: Domestic customer, 150 units, late payment = true, online payment = true.

| Bill component | Calculation | Amount |
|---|---|---:|
| First 100 units | 100 × ₹1.50 | ₹150.00 |
| Next 50 units | 50 × ₹2.50 | ₹125.00 |
| Energy charge | ₹150 + ₹125 | ₹275.00 |
| Fixed charge | Domestic | ₹50.00 |
| Late surcharge | 5% of ₹325.00 | ₹16.25 |
| Online rebate | 2% of ₹341.25 | ₹6.83 |
| **Final bill** | **Rounded to 2 decimal places** | **₹334.43** |

*Illustrative calculation using the practice tariff assumptions listed above, not an official electricity tariff. Full console example is in sample_runs.md.*
