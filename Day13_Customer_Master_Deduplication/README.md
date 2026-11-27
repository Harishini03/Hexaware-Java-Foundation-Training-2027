# Day 13 – Customer Master De-duplication

## Objective
Clean customer data received from multiple channels and identify duplicate customer records using a normalised email address.

## Requirements covered
1. Customer class overrides `equals()`, `hashCode()` and `toString()`; a HashSet removes duplicates.
2. A Java record provides the equivalent value-object implementation.
3. String cleaning demonstrates trim, case normalisation, name splitting, phone masking, immutability, `==` and `equals()`.
4. Notifier interface includes a default method and static helper, implemented by email and SMS notifiers.
5. Marker and functional interfaces are demonstrated.

## Files
- `src/Main.java` – complete Java 17 program in one source file.
- `output.txt` – representative output.
- `concept-notes.md` – equals/hashCode contract, interface types and String immutability notes.

## Prerequisites
JDK 17 or later; Windows Command Prompt or PowerShell.

## Run
```powershell
javac -d out src/Main.java
java -cp out Main
```

## Important
Email is trimmed and converted to lowercase before comparison. The record example uses the same normalisation in its compact constructor so both implementations behave consistently.
