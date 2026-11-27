# Day 14 – Retail Inventory Manager

## Objective
Maintain products by SKU, support stock operations and reorder alerts, sort inventory in different ways, retain recent stock activity and reuse storage logic with generics.

## Requirements covered
1. HashMap keyed by SKU with add, update, remove and low-stock listing.
2. Product implements Comparable; a Comparator provides an alternative sort order.
3. ArrayDeque retains the latest 10 stock movements.
4. Generic Repository<T> uses a bounded type parameter for Product and Supplier.
5. Demonstrates autoboxing, Integer cache and the `==` versus `equals()` difference.

## Files
- `src/Main.java` – complete Java program in one source file.
- `output.txt` – representative output log.
- `collection-notes.md` – why each collection is used and wrapper-class notes.

## Prerequisites
JDK 17 or later; Windows Command Prompt or PowerShell.

## Run
```powershell
javac -d out src/Main.java
java -cp out Main
```

## Notes
The sample data is embedded in Main.java so the program runs without an external database or input file. The activity deque stores no more than the latest ten movements.
