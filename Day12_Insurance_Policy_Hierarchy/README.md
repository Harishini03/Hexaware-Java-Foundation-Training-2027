# Day 12 – Insurance Policy Hierarchy

## Objective
Model motor, health, travel and home insurance policies using enums, abstract classes, inheritance, encapsulation and runtime polymorphism.

## Requirements covered
1. `PolicyStatus` enum with DRAFT, ACTIVE, LAPSED and CANCELLED.
2. Abstract `Policy` class with `calculatePremium()` and validated, private policy number.
3. Eight policy objects stored in a `Policy[]` and processed in one polymorphic loop.
4. Two-dimensional regional collection data and a jagged branch-wise array with totals.
5. A new `HomePolicy` subclass added without changing existing policy subclasses (Open/Closed Principle).

## Files
- `src/Main.java` – complete runnable Java program; supporting classes are kept in the same file for easy execution.
- `output.txt` – representative console output.
- `class-diagram.md` – text UML-style class diagram and design note.

## Prerequisites
- JDK 17 or later
- Windows Command Prompt or PowerShell

## Run
From this folder:

```powershell
javac -d out src/Main.java
java -cp out Main
```

## Notes
Premium values are illustrative inputs for demonstrating different subclass formulas, not real insurance quotations. The program validates policy numbers and demonstrates both rectangular and jagged arrays.
