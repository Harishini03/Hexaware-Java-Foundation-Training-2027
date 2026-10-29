# Day 1 — Retail Order Desk

## Run the project
Run from the `Day1_Retail_Order_Desk` folder:
```bash
javac src/*.java
java -cp src main
```
CSV columns: `orderId,customerId,amount,createdAt`; use ISO date-time like `2026-10-29T10:15:20`.

## Task 1 — Linear and binary search
- Linear search: O(n) time, O(1) extra space; works on unsorted data.
- Binary search: O(log n) once IDs are sorted. Sorting costs O(n log n), so sorting for one lookup can cost more than linear search. Binary search helps for repeated lookups on sorted data.
- Timings vary by machine and JVM warm-up.

## Task 2 — Sorting by amount descending
- Bubble sort: O(n²) time, O(1) auxiliary space.
- Merge sort: O(n log n) time, O(n) extra space.
- Java built-in `List.sort`: typically O(n log n), stable, and usually best in practice.
- Benchmark uses at most 10,000 records.

Example bubble-sort trace for amounts `[20, 50, 10, 40]` descending:
- Start: `[20, 50, 10, 40]`
- Pass 1: `[50, 20, 40, 10]`
- Pass 2: `[50, 40, 20, 10]`
- Pass 3: `[50, 40, 20, 10]`

## Task 3 — Duplicate detection
- Key: customer ID + amount rounded to cents + creation time truncated to the minute.
- Average time O(n), space O(n) using a hash map.
- This is a possible-duplicate rule for the assignment; confirm the business definition before blocking a real payment.

## Task 4 — Stack and queue
- Stack (LIFO): useful for undoing the most recent edit. Push/pop are O(1) for the custom list-backed stack and `ArrayDeque`.
- Queue (FIFO): useful for dispatching orders in arrival order. The custom queue removes index 0 from an `ArrayList`, O(n); `ArrayDeque` offer/poll are O(1) amortized.

## Task 5 — Refund calculation
- Greedy chooses the largest denomination that fits; fast, about O(d), but not optimal for every denomination system.
- Counterexample: denominations `[4, 3, 1]`, amount `6`. Greedy gives `4 + 1 + 1` (3 coins); optimal is `3 + 3` (2 coins).
- Dynamic programming: O(amount × d) time and O(amount) space. `dp[x]` stores the fewest coins for amount x.

## Object-oriented design
- `Order` models an order and owns display/CSV conversion behaviour.
- `OrderFileReader` handles file loading separately.
- Each task class contains logic for one task; `main` coordinates the tasks.
