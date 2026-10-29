import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
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

/* Order data model is kept here to avoid a separate Order.java file. */
class Order {
    int orderId;
    int customerId;
    double amount;
    LocalDateTime createdAt;

    public Order(int orderId, int customerId, double amount, LocalDateTime createdAt) {
        this.orderId = orderId;
        this.customerId = customerId;
        this.amount = amount;
        this.createdAt = createdAt;
    }

    public void displayOrder() {
        System.out.println("Order ID: " + orderId + ", Customer ID: " + customerId
                + ", Amount: " + String.format("%.2f", amount) + ", Created At: " + createdAt);
    }

    public static Order fromCsv(String line) {
        String[] values = line.split(",", -1);
        if (values.length != 4) {
            throw new IllegalArgumentException("Invalid CSV row: " + line);
        }
        try {
            return new Order(Integer.parseInt(values[0].trim()),
                    Integer.parseInt(values[1].trim()),
                    Double.parseDouble(values[2].trim()),
                    LocalDateTime.parse(values[3].trim()));
        } catch (NumberFormatException | DateTimeParseException e) {
            throw new IllegalArgumentException("Invalid order data: " + line, e);
        }
    }
}

/* CSV loading is kept here to avoid a separate OrderFileReader.java file. */
class OrderFileReader {
    public static List<Order> loadOrders(String fileName) {
        List<Order> orders = new ArrayList<>();
        try (BufferedReader reader = Files.newBufferedReader(Path.of(fileName))) {
            String line;
            boolean firstLine = true;
            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty()) {
                    continue;
                }
                if (firstLine && line.toLowerCase().startsWith("orderid")) {
                    firstLine = false;
                    continue;
                }
                firstLine = false;
                try {
                    orders.add(Order.fromCsv(line));
                } catch (IllegalArgumentException e) {
                    System.out.println("Skipping row: " + e.getMessage());
                }
            }
        } catch (IOException e) {
            System.out.println("Could not read " + fileName + ": " + e.getMessage());
        }
        return orders;
    }
}
