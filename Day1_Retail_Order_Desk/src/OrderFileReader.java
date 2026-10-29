import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

class OrderFileReader {
    public static List<Order> loadOrders(String fileName) {
        List<Order> orders = new ArrayList<>();
        try (BufferedReader reader = Files.newBufferedReader(Path.of(fileName))) {
            String line;
            boolean firstLine = true;
            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                if (firstLine && line.toLowerCase().startsWith("orderid")) {
                    firstLine = false;
                    continue;
                }
                firstLine = false;
                try { orders.add(Order.fromCsv(line)); }
                catch (IllegalArgumentException e) { System.out.println("Skipping row: " + e.getMessage()); }
            }
        } catch (IOException e) {
            System.out.println("Could not read " + fileName + ": " + e.getMessage());
        }
        return orders;
    }
}