import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Task3_RefundCalc {
    public static void detectDuplicates(List<Order> orders) {
        Map<String, Order> seen = new HashMap<>();
        int duplicateCount = 0;
        for (Order order : orders) {
            LocalDateTime minute = order.createdAt.truncatedTo(ChronoUnit.MINUTES);
            long amountInCents = Math.round(order.amount * 100);
            String key = order.customerId + "|" + amountInCents + "|" + minute;
            if (seen.containsKey(key)) {
                duplicateCount++;
                System.out.println("Possible duplicate: order " + order.orderId + " matches order " + seen.get(key).orderId);
            } else seen.put(key, order);
        }
        System.out.println("Possible duplicate count: " + duplicateCount);
        System.out.println("Time complexity: O(n) average; space complexity: O(n).");
    }
}