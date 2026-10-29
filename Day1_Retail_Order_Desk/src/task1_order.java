import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

class Task1_Order {
    public static void searchOrder(List<Order> orders, int searchId) {
        long start = System.nanoTime();
        Order linearResult = null;
        for (Order order : orders) {
            if (order.orderId == searchId) { linearResult = order; break; }
        }
        long linearTime = System.nanoTime() - start;
        System.out.println("Linear Search: " + (linearResult == null ? "Order not found" : "Order found"));
        if (linearResult != null) linearResult.displayOrder();

        List<Order> sortedOrders = new ArrayList<>(orders);
        sortedOrders.sort(Comparator.comparingInt(order -> order.orderId));
        start = System.nanoTime();
        int low = 0, high = sortedOrders.size() - 1;
        Order binaryResult = null;
        while (low <= high) {
            int mid = low + (high - low) / 2;
            Order order = sortedOrders.get(mid);
            if (order.orderId == searchId) { binaryResult = order; break; }
            else if (order.orderId < searchId) low = mid + 1;
            else high = mid - 1;
        }
        long binaryTime = System.nanoTime() - start;
        System.out.println("Binary Search: " + (binaryResult == null ? "Order not found" : "Order found"));
        if (binaryResult != null) binaryResult.displayOrder();
        System.out.println("Linear search time: " + linearTime + " ns");
        System.out.println("Binary search time (excluding sorting): " + binaryTime + " ns");
        System.out.println("Note: binary search needs sorted IDs; sorting cost is O(n log n).");
    }
}