import java.util.HashSet;
import java.util.Set;

public class Main {
    static class Customer {
        private final String name;
        private final String email;
        private final String phone;

        Customer(String name, String email, String phone) {
            this.name = name.trim();
            this.email = normalizeEmail(email);
            this.phone = phone;
        }
        static String normalizeEmail(String email) {
            if (email == null || email.isBlank()) throw new IllegalArgumentException("Email is required");
            return email.trim().toLowerCase();
        }
        @Override public boolean equals(Object obj) {
            if (this == obj) return true;
            if (!(obj instanceof Customer other)) return false;
            return email.equals(other.email);
        }
        @Override public int hashCode() { return email.hashCode(); }
        @Override public String toString() {
            return "Customer{name='" + name + "', email='" + email + "', phone='" + phone + "'}";
        }
    }

    record CustomerRecord(String name, String email, String phone) {
        CustomerRecord {
            name = name.trim();
            email = Customer.normalizeEmail(email);
        }
    }

    interface Notifier {
        void send(String recipient, String message);
        default void showStatus() { System.out.println("Notification service is ready."); }
        static boolean isValidRecipient(String recipient) {
            return recipient != null && !recipient.isBlank();
        }
    }
    static class EmailNotifier implements Notifier {
        @Override public void send(String recipient, String message) {
            if (Notifier.isValidRecipient(recipient))
                System.out.println("EMAIL to " + recipient + ": " + message);
        }
    }
    static class SmsNotifier implements Notifier {
        @Override public void send(String recipient, String message) {
            if (Notifier.isValidRecipient(recipient))
                System.out.println("SMS to " + recipient + ": " + message);
        }
    }

    interface Auditable { } // Marker interface: no methods
    @FunctionalInterface
    interface CustomerValidator { boolean isValid(Customer customer); }

    static String cleanName(String value) { return value.trim().replaceAll("\\s+", " "); }
    static String maskPhone(String phone) {
        if (phone == null || phone.length() < 4) return "INVALID";
        return "*".repeat(phone.length() - 4) + phone.substring(phone.length() - 4);
    }

    public static void main(String[] args) {
        Set<Customer> customers = new HashSet<>();
        customers.add(new Customer("Asha Kumar", " ASHA@MAIL.COM ", "9876543210"));
        customers.add(new Customer("Asha K.", "asha@mail.com", "9876500000"));
        customers.add(new Customer("Bala Raj", "bala@mail.com", "9123456780"));
        customers.add(new Customer("Charan", "charan@mail.com", "9988776655"));

        System.out.println("CUSTOMER MASTER – DUPLICATE REMOVAL");
        System.out.println("Input records : 4");
        System.out.println("Unique records: " + customers.size());
        for (Customer customer : customers) System.out.println(customer);

        CustomerRecord record = new CustomerRecord("  Divya Rao ", " DIVYA@MAIL.COM ", "9000012345");
        System.out.println("\nRECORD VALUE OBJECT");
        System.out.println(record);
        System.out.println("Record accessors: " + record.name() + " | " + record.email());

        String rawName = "  Asha   Kumar  ";
        String cleaned = cleanName(rawName);
        String firstName = cleaned.split(" ")[0];
        System.out.println("\nSTRING CLEANING");
        System.out.println("Original: [" + rawName + "]");
        System.out.println("Cleaned : [" + cleaned + "]");
        System.out.println("First name: " + firstName);
        System.out.println("Masked phone: " + maskPhone("9876543210"));

        String first = "JAVA";
        String second = "JAVA";
        String third = new String("JAVA");
        System.out.println("\nSTRING CONSTANT POOL");
        System.out.println("first == second: " + (first == second));
        System.out.println("first == third : " + (first == third));
        System.out.println("first.equals(third): " + first.equals(third));
        String original = "hello";
        String changed = original.concat(" world");
        System.out.println("Original after concat: " + original);
        System.out.println("New string: " + changed);

        System.out.println("\nNOTIFIERS");
        Notifier email = new EmailNotifier();
        Notifier sms = new SmsNotifier();
        email.showStatus();
        email.send("asha@mail.com", "Welcome");
        sms.send("9876543210", "Your profile is updated");

        Customer sample = new Customer("Test User", "test@mail.com", "9000000000");
        CustomerValidator validator = c -> c.email.endsWith("@mail.com");
        System.out.println("\nFUNCTIONAL INTERFACE VALIDATION: " + validator.isValid(sample));
        System.out.println("Marker interface Auditable: identifies objects that may be audited.");
    }
}
