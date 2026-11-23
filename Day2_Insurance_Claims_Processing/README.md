# Day 2 — Insurance Claims Processing (Set 2)

Beginner-friendly Java implementation of the Hexaware Day 2 assignment.

## Topics
- Binary Search Tree
- Hashing with HashSet
- Directed graphs, BFS and DFS
- Longest consecutive run using a single-pass sliding-window-style counter
- Two-pointer merge of sorted lists

## Run
```bash
javac src/main.java
java -cp src main
```

See `notes/notes.md` for the decision table, complexity analysis, test cases and sample output.

## Sample Output

| Task | Operation | Example output |
|---|---|---|
| BST | Inorder traversal | 20, 30, 40, 50, 60, 70, 80 |
| BST | Search claim 60 | Found |
| BST | Search claim 99 | Not found |
| Duplicate detection | Normalised policy key | Duplicate: pol100, incident date 2026-10-20 |
| Approval graph | Shortest path | Registration → Assessment → Surveyor → Settlement |
| Approval graph | Cycle detection | Normal flow: false; after adding Settlement → Assessment: true |
| Claim spike | Longest run above 100 | 3 consecutive days |
| Merge | Two sorted regional lists | 101, 102, 103, 104, 108, 109, 115, 120 |

*Example values correspond to the sample test cases documented in the notes file.*
