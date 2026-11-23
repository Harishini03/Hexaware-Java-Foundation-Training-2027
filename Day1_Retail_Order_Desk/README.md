# Day 1 — Retail Order Desk

Java practice project for **Problem Solving Techniques and Data Structures I**.

## Tasks
1. Linear and binary search for orders.
2. Bubble sort, merge sort, and Java built-in sorting benchmark.
3. Hash-based duplicate detection by customer, amount, and minute.
4. Custom stack and queue compared with Java's `ArrayDeque`.
5. Greedy refund calculation and a dynamic programming counterexample.

## Requirements
- Java 11 or newer
- `orders.csv` in this project folder

## Run
From this folder, run:

```bash
javac src/*.java
java -cp src main
```

See `notes/notes.md` for complexity, data-structure rationale, and a bubble-sort trace. Benchmark timings vary by system and JVM warm-up; replace the included sample CSV with the provided 50,000-record dataset for the assignment benchmark.

## Sample Output

**Task 1 – Search and sorting (illustrative values)**

| Operation | Input / key | Expected result |
|---|---|---|
| Linear search | Order ID 104 | Order found (works even when records are unsorted) |
| Binary search | Sorted order IDs, key 104 | Order found |
| Bubble sort | Amounts: 20, 50, 10, 40 | 50, 40, 20, 10 |
| Duplicate detection | Same customer, amount and minute | Possible duplicate flagged |

**Task 5 – Refund calculation**

| Method | Denominations | Refund amount | Coins returned |
|---|---|---:|---|
| Greedy | 4, 3, 1 | 6 | 4 + 1 + 1 (3 coins) |
| Dynamic programming | 4, 3, 1 | 6 | 3 + 3 (2 coins) |

*Illustrative examples only. Actual order IDs and benchmark timings depend on the CSV file used.*
