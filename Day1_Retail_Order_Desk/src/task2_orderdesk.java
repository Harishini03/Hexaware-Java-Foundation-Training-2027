import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

class Task2_OrderDesk {
    public static void compareSorting(List<Order> orders) {
        int count = Math.min(orders.size(), 10000);
        List<Order> original = new ArrayList<>(orders.subList(0, count));
        long start = System.nanoTime();
        List<Order> bubble = new ArrayList<>(original);
        bubbleSortDescending(bubble);
        long bubbleTime = System.nanoTime() - start;
        start = System.nanoTime();
        List<Order> merge = new ArrayList<>(original);
        mergeSortDescending(merge, 0, merge.size() - 1);
        long mergeTime = System.nanoTime() - start;
        start = System.nanoTime();
        List<Order> builtIn = new ArrayList<>(original);
        builtIn.sort(Comparator.comparingDouble((Order order) -> order.amount).reversed());
        long builtInTime = System.nanoTime() - start;
        System.out.println("Records sorted: " + count);
        System.out.println("Bubble sort O(n^2): " + bubbleTime + " ns");
        System.out.println("Merge sort O(n log n): " + mergeTime + " ns");
        System.out.println("Built-in sort: " + builtInTime + " ns");
        System.out.println("Top 3 orders by amount:");
        for (int i = 0; i < Math.min(3, builtIn.size()); i++) builtIn.get(i).displayOrder();
        System.out.println("Bubble sort first three passes are described in notes/notes.md.");
    }
    private static void bubbleSortDescending(List<Order> orders) {
        for (int i = 0; i < orders.size() - 1; i++) {
            for (int j = 0; j < orders.size() - 1 - i; j++) {
                if (orders.get(j).amount < orders.get(j + 1).amount) {
                    Order temp = orders.get(j); orders.set(j, orders.get(j + 1)); orders.set(j + 1, temp);
                }
            }
        }
    }
    private static void mergeSortDescending(List<Order> orders, int left, int right) {
        if (left >= right) return;
        int middle = left + (right - left) / 2;
        mergeSortDescending(orders, left, middle);
        mergeSortDescending(orders, middle + 1, right);
        merge(orders, left, middle, right);
    }
    private static void merge(List<Order> orders, int left, int middle, int right) {
        List<Order> temp = new ArrayList<>();
        int i = left, j = middle + 1;
        while (i <= middle && j <= right) {
            if (orders.get(i).amount >= orders.get(j).amount) temp.add(orders.get(i++));
            else temp.add(orders.get(j++));
        }
        while (i <= middle) temp.add(orders.get(i++));
        while (j <= right) temp.add(orders.get(j++));
        for (int k = 0; k < temp.size(); k++) orders.set(left + k, temp.get(k));
    }
}