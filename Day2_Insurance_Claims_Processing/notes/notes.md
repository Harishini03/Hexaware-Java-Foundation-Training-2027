# Day 2 — Set 2: Insurance Claims Processing

## Why Set 2?
This set uses a clear insurance-claims scenario and lets us practise all five Day 2 topics with simple Java examples. The implementation keeps the program in one source file, `src/main.java`, to make it easier to follow.

## Run
From the `Day2_Insurance_Claims_Processing` folder:
```bash
javac src/main.java
java -cp src main
```
Java 8 or newer is sufficient for the code.

## Task 1 — Binary Search Tree (BST)
A BST stores claim IDs so smaller IDs go to the left and larger IDs go to the right.
- Insert: compare the new ID with each node and move left or right.
- Search: follow the same comparisons until the ID is found or a null child is reached.
- Inorder (left, root, right) prints IDs in ascending sorted order.
- Preorder (root, left, right) visits the parent before its children.
- Postorder (left, right, root) visits the parent after its children.
- Duplicate claim IDs are ignored in this example.
- Average insert/search: O(log n) for a reasonably balanced tree; worst case: O(n) for a skewed tree.
- Recursive traversal: O(n) time. Recursion space: O(h), where h is tree height.

## Task 2 — Hashing for duplicate claims
- The key is policy number + incident date.
- Policy numbers are trimmed and converted to lowercase, so `POL100`, `pol100 `, and ` Pol100` match.
- A HashSet stores keys already seen. If adding a key returns false, the claim is a duplicate.
- Hash collisions are handled internally by Java's HashSet/HashMap; unequal keys are still checked for equality.
- Average lookup/insert: O(1); worst case: O(n). Total average processing for n claims: O(n).

## Task 3 — Approval graph
The directed graph represents the approval flow:
`Registration -> Assessment -> Surveyor -> Settlement`
- Adjacency list: each stage stores the stages directly reachable from it.
- BFS uses a queue and finds a path with the fewest edges in an unweighted graph.
- DFS cycle detection uses a visited set and an active recursion set. Reaching a node already in the active recursion path means a directed cycle exists.
- BFS: O(V + E) time and O(V) space.
- DFS cycle detection: O(V + E) time and O(V) space.
- V = number of stages (vertices); E = number of dependencies (edges).

## Task 4 — Longest consecutive run above 100
Walk through daily claim counts once:
- If a day's count is greater than 100, increase the current run.
- Otherwise reset the current run to zero.
- Keep the largest run seen so far.
- Time: O(n); extra space: O(1).
- This directly finds the longest consecutive sequence; no sorting is needed.

## Task 5 — Merge two sorted regional lists
Use two pointers, one for each sorted list:
- Compare the values at both pointers.
- Copy the smaller value to the result and move that pointer.
- Copy any remaining values after one list ends.
- Time: O(n + m); extra space: O(n + m) for the merged result.
- No additional sorting is performed.

## Decision table

| Problem | Data structure / pattern | Reason |
|---|---|---|
| Store, insert and search claim IDs | Binary Search Tree | Compares IDs and supports ordered traversal |
| Detect repeated claims | HashSet (hashing) | Fast average membership check after normalizing the key |
| Approval stages and dependencies | Directed graph + BFS/DFS | BFS finds the fewest steps; DFS detects cycles |
| Longest consecutive spike period | Single-pass sliding-window style counter | Tracks the current and longest run in one pass |
| Combine two sorted regional lists | Two pointers | Merges in order without sorting again |

## Complexity table

| Task | Operation | Time complexity | Auxiliary space |
|---|---|---:|---:|
| 1 | BST insert/search (average) | O(log n) | O(h) for recursive insert |
| 1 | BST insert/search (worst skewed tree) | O(n) | O(h) |
| 1 | Inorder/preorder/postorder traversals | O(n) | O(h) |
| 2 | HashSet duplicate check (average total) | O(n) | O(n) |
| 2 | HashSet duplicate check (worst total) | O(n²) | O(n) |
| 3 | BFS shortest path | O(V + E) | O(V) |
| 3 | DFS cycle detection | O(V + E) | O(V) |
| 4 | Longest run above 100 | O(n) | O(1) |
| 5 | Merge two sorted lists | O(n + m) | O(n + m) |

## Test cases included in the program
- BST search for an existing and missing claim ID, plus search in an empty tree.
- Hashing with a duplicate policy number that differs by letter case/spacing, plus an empty claim list.
- Graph with no cycle and a second graph with a deliberately added cycle.
- Sliding-window/run logic with sample data and empty input.
- Merge with two non-empty sorted lists, one empty list, and both lists empty.

## Sample output
```text
DAY 2 - INSURANCE CLAIMS PROCESSING

===== TASK 1: CLAIM ID BST =====
Inorder: 20 30 40 50 60 70 80
Preorder: 50 30 20 40 70 60 80
Postorder: 20 40 30 60 80 70 50
Search 60: Found
Search 99: Not found
Empty tree search: Not found

===== TASK 2: DUPLICATE CLAIM DETECTION =====
Duplicate claim: policy pol100, date 2026-10-20
Empty claim list test:
No duplicate claims found.

===== TASK 3: CLAIM APPROVAL GRAPH =====
Shortest approval path: [Registration, Assessment, Surveyor, Settlement]
Cycle in normal approval flow: false
Cycle after adding Settlement -> Assessment: true

===== TASK 4: CLAIM SPIKE ANALYSIS =====
Daily claims: [80, 120, 130, 150, 90, 110, 140, 160, 70, 130]
Longest consecutive days above 100: 3
Empty input result: 0

===== TASK 5: MERGE REGIONAL CLAIM LISTS =====
Merged claims: [101, 102, 103, 104, 108, 109, 115, 120]
Empty list test: [5, 8, 10]
Both empty test: []
```

Note: The longest consecutive run in the sample is 3 days. The code uses a simple running counter, which is the most beginner-friendly way to express this sliding-window-style task.
