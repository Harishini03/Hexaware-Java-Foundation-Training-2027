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
