import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;

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
        if (values.length != 4) throw new IllegalArgumentException("Invalid CSV row: " + line);
        try {
            return new Order(Integer.parseInt(values[0].trim()), Integer.parseInt(values[1].trim()),
                    Double.parseDouble(values[2].trim()), LocalDateTime.parse(values[3].trim()));
        } catch (NumberFormatException | DateTimeParseException e) {
            throw new IllegalArgumentException("Invalid order data: " + line, e);
        }
    }
}