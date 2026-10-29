import java.util.List;

public class main {
    public static void main(String[] args) {
        String csvFile = args.length > 0 ? args[0] : "orders.csv";
        List<Order> orders = OrderFileReader.loadOrders(csvFile);
        if (orders.isEmpty()) {
            System.out.println("No orders loaded. Check that orders.csv exists and has valid rows.");
            return;
        }
        System.out.println("Loaded orders: " + orders.size());
        System.out.println("\n========== TASK 1: SEARCH ==========");
        int searchId = orders.get(orders.size() / 2).orderId;
        Task1_Order.searchOrder(orders, searchId);
        System.out.println("\n========== TASK 2: SORTING ==========");
        Task2_OrderDesk.compareSorting(orders);
        System.out.println("\n========== TASK 3: DUPLICATES ==========");
        Task3_RefundCalc.detectDuplicates(orders);
        System.out.println("\n========== TASK 4: STACK AND QUEUE ==========");
        Task4_Sorting.demonstrateStackAndQueue(orders);
        System.out.println("\n========== TASK 5: REFUND ==========");
        Task5_RefundCalc.demonstrateRefund();
    }
}