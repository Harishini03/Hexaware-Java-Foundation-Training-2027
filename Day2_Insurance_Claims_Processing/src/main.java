import java.util.*;

/*
 * Day 2 - Set 2: Insurance Claims Processing
 * Beginner-friendly implementation of BST, hashing, graphs,
 * sliding window, and two pointers.
 */
public class main {

    public static void main(String[] args) {
        System.out.println("DAY 2 - INSURANCE CLAIMS PROCESSING");

        // TASK 1: Binary Search Tree
        System.out.println("\n===== TASK 1: CLAIM ID BST =====");
        int[] claimIds = {50, 30, 70, 20, 40, 60, 80};
        BST tree = new BST();
        for (int id : claimIds) {
            tree.insert(id);
        }
        System.out.print("Inorder: ");
        tree.inorder(tree.root);
        System.out.print("\nPreorder: ");
        tree.preorder(tree.root);
        System.out.print("\nPostorder: ");
        tree.postorder(tree.root);
        System.out.println("\nSearch 60: " + (tree.search(60) ? "Found" : "Not found"));
        System.out.println("Search 99: " + (tree.search(99) ? "Found" : "Not found"));
        BST emptyTree = new BST();
        System.out.println("Empty tree search: " + (emptyTree.search(10) ? "Found" : "Not found"));

        // TASK 2: Hashing for duplicate claims
        System.out.println("\n===== TASK 2: DUPLICATE CLAIM DETECTION =====");
        String[][] claims = {
            {"POL100", "2026-10-20"},
            {"pol100 ", "2026-10-20"},
            {"POL200", "2026-10-21"},
            {"POL300", "2026-10-22"}
        };
        findDuplicateClaims(claims);
        System.out.println("Empty claim list test:");
        findDuplicateClaims(new String[0][0]);

        // TASK 3: Graph, BFS and DFS cycle detection
        System.out.println("\n===== TASK 3: CLAIM APPROVAL GRAPH =====");
        Map<String, List<String>> stages = new LinkedHashMap<>();
        addEdge(stages, "Registration", "Assessment");
        addEdge(stages, "Assessment", "Surveyor");
        addEdge(stages, "Surveyor", "Settlement");
        System.out.println("Shortest approval path: "
                + bfsPath(stages, "Registration", "Settlement"));
        System.out.println("Cycle in normal approval flow: " + hasCycle(stages));

        Map<String, List<String>> stagesWithLoop = new LinkedHashMap<>();
        addEdge(stagesWithLoop, "Registration", "Assessment");
        addEdge(stagesWithLoop, "Assessment", "Surveyor");
        addEdge(stagesWithLoop, "Surveyor", "Settlement");
        addEdge(stagesWithLoop, "Settlement", "Assessment");
        System.out.println("Cycle after adding Settlement -> Assessment: "
                + hasCycle(stagesWithLoop));

        // TASK 4: Longest consecutive run above 100 claims
        System.out.println("\n===== TASK 4: CLAIM SPIKE ANALYSIS =====");
        int[] dailyClaims = {80, 120, 130, 150, 90, 110, 140, 160, 70, 130};
        System.out.println("Daily claims: " + Arrays.toString(dailyClaims));
        System.out.println("Longest consecutive days above 100: "
                + longestRunAbove100(dailyClaims));
        System.out.println("Empty input result: " + longestRunAbove100(new int[0]));

        // TASK 5: Merge two sorted regional claim lists
        System.out.println("\n===== TASK 5: MERGE REGIONAL CLAIM LISTS =====");
        int[] northClaims = {101, 104, 108, 115};
        int[] southClaims = {102, 103, 109, 120};
        System.out.println("Merged claims: "
                + Arrays.toString(mergeSorted(northClaims, southClaims)));
        System.out.println("Empty list test: "
                + Arrays.toString(mergeSorted(new int[0], new int[]{5, 8, 10})));
        System.out.println("Both empty test: "
                + Arrays.toString(mergeSorted(new int[0], new int[0])));
    }

    // TASK 1: Binary Search Tree
    static class Node {
        int claimId;
        Node left, right;

        Node(int claimId) {
            this.claimId = claimId;
        }
    }

    static class BST {
        Node root;

        void insert(int claimId) {
            root = insertNode(root, claimId);
        }

        Node insertNode(Node current, int claimId) {
            if (current == null) {
                return new Node(claimId);
            }
            if (claimId < current.claimId) {
                current.left = insertNode(current.left, claimId);
            } else if (claimId > current.claimId) {
                current.right = insertNode(current.right, claimId);
            }
            return current; // Ignore duplicate claim IDs.
        }

        boolean search(int claimId) {
            Node current = root;
            while (current != null) {
                if (current.claimId == claimId) return true;
                if (claimId < current.claimId) current = current.left;
                else current = current.right;
            }
            return false;
        }

        void inorder(Node node) {
            if (node == null) return;
            inorder(node.left);
            System.out.print(node.claimId + " ");
            inorder(node.right);
        }

        void preorder(Node node) {
            if (node == null) return;
            System.out.print(node.claimId + " ");
            preorder(node.left);
            preorder(node.right);
        }

        void postorder(Node node) {
            if (node == null) return;
            postorder(node.left);
            postorder(node.right);
            System.out.print(node.claimId + " ");
        }
    }

    // TASK 2: Normalize policy number before checking duplicates.
    static void findDuplicateClaims(String[][] claims) {
        Set<String> seen = new HashSet<>();
        boolean duplicateFound = false;

        for (String[] claim : claims) {
            if (claim == null || claim.length < 2) continue;
            String policy = claim[0].trim().toLowerCase(Locale.ROOT);
            String date = claim[1].trim();
            String key = policy + "|" + date;

            if (!seen.add(key)) {
                System.out.println("Duplicate claim: policy " + policy + ", date " + date);
                duplicateFound = true;
            }
        }

        if (!duplicateFound) {
            System.out.println("No duplicate claims found.");
        }
    }

    // TASK 3: Directed graph represented by an adjacency list.
    static void addEdge(Map<String, List<String>> graph, String from, String to) {
        graph.putIfAbsent(from, new ArrayList<>());
        graph.putIfAbsent(to, new ArrayList<>());
        graph.get(from).add(to);
    }

    // BFS finds the shortest path in an unweighted graph.
    static List<String> bfsPath(Map<String, List<String>> graph, String start, String target) {
        List<String> path = new ArrayList<>();
        if (!graph.containsKey(start) || !graph.containsKey(target)) return path;

        Queue<String> queue = new ArrayDeque<>();
        Map<String, String> parent = new HashMap<>();
        Set<String> visited = new HashSet<>();

        queue.offer(start);
        visited.add(start);

        while (!queue.isEmpty()) {
            String current = queue.poll();
            if (current.equals(target)) break;

            for (String next : graph.get(current)) {
                if (visited.add(next)) {
                    parent.put(next, current);
                    queue.offer(next);
                }
            }
        }

        if (start.equals(target)) {
            path.add(start);
        } else if (parent.containsKey(target)) {
            String current = target;
            while (current != null) {
                path.add(current);
                current = parent.get(current);
            }
            Collections.reverse(path);
        }
        return path;
    }

    // DFS cycle detection for a directed graph.
    static boolean hasCycle(Map<String, List<String>> graph) {
        Set<String> visited = new HashSet<>();
        Set<String> active = new HashSet<>();

        for (String node : graph.keySet()) {
            if (detectCycle(node, graph, visited, active)) return true;
        }
        return false;
    }

    static boolean detectCycle(String node, Map<String, List<String>> graph,
                               Set<String> visited, Set<String> active) {
        if (active.contains(node)) return true;
        if (visited.contains(node)) return false;

        visited.add(node);
        active.add(node);

        for (String next : graph.getOrDefault(node, Collections.emptyList())) {
            if (detectCycle(next, graph, visited, active)) return true;
        }

        active.remove(node);
        return false;
    }

    // TASK 4: Count consecutive days with more than 100 claims.
    static int longestRunAbove100(int[] dailyClaims) {
        int currentRun = 0;
        int longestRun = 0;

        for (int count : dailyClaims) {
            if (count > 100) {
                currentRun++;
                longestRun = Math.max(longestRun, currentRun);
            } else {
                currentRun = 0;
            }
        }
        return longestRun;
    }

    // TASK 5: Merge two already sorted arrays using two pointers.
    static int[] mergeSorted(int[] first, int[] second) {
        int[] merged = new int[first.length + second.length];
        int i = 0, j = 0, k = 0;

        while (i < first.length && j < second.length) {
            if (first[i] <= second[j]) {
                merged[k++] = first[i++];
            } else {
                merged[k++] = second[j++];
            }
        }

        while (i < first.length) merged[k++] = first[i++];
        while (j < second.length) merged[k++] = second[j++];

        return merged;
    }
}
