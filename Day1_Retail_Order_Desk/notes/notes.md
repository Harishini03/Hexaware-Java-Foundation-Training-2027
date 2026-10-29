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


## Time Complexity Reference

Let:
- `n` = number of orders/elements
- `d` = number of coin denominations
- `A` = refund amount

### Time complexity table

| Task | Operation / algorithm | Best case | Average case | Worst case |
|---|---|---:|---:|---:|
| 1 | Linear search | O(1) | O(n) | O(n) |
| 1 | Binary search (sorted IDs) | O(1) | O(log n) | O(log n) |
| 1 | Sort IDs before binary search | O(n log n) | O(n log n) | O(n log n) |
| 2 | Bubble sort (current implementation) | O(n²) | O(n²) | O(n²) |
| 2 | Merge sort | O(n log n) | O(n log n) | O(n log n) |
| 2 | Java built-in `List.sort` | O(n) on already sorted input | O(n log n) | O(n log n) |
| 3 | Duplicate detection with `HashMap` | O(n) | O(n) average | O(n²) in a pathological collision case |
| 4 | Custom stack push/pop | O(1) | O(1) | O(1) per operation, excluding resizing |
| 4 | Custom queue enqueue | O(1) | O(1) amortized | O(1) amortized |
| 4 | Custom queue dequeue (`ArrayList.remove(0)`) | O(n) | O(n) | O(n) |
| 4 | `ArrayDeque` stack/queue operations | O(1) | O(1) amortized | A resize can take O(n) for an individual operation |
| 5 | Greedy refund calculation | O(d) | O(d) | O(d) |
| 5 | Dynamic programming refund calculation | O(A × d) | O(A × d) | O(A × d) |

### Space complexity table

| Operation / algorithm | Auxiliary space |
|---|---:|
| Linear search | O(1) |
| Binary search (iterative) | O(1), excluding the sorted copy |
| Sorting IDs for binary search | O(n) for the copied list |
| Bubble sort | O(1), excluding its copied input list |
| Merge sort implementation | O(n) for temporary merge lists and recursion |
| Java built-in sort | Typically O(n) auxiliary space for object lists |
| Duplicate detection | O(n) for the hash map |
| Custom stack | O(n) |
| Custom queue | O(n) |
| Greedy refund calculation | O(1) |
| Dynamic programming refund calculation | O(A) |

**Notes:** The current bubble-sort code does not stop early when a pass makes no swaps, so its best case is still O(n²). Binary search is O(log n) only after the IDs are sorted; sorting for a single search adds O(n log n). `ArrayDeque` operations are O(1) amortized, though a resize can make one operation O(n).


## Object-oriented design
- The `Order` data model and `OrderFileReader` CSV-loading logic are defined as package-private classes inside `src/main.java` to avoid separate files.
- Each task class contains logic for one task; `main` coordinates the tasks.
