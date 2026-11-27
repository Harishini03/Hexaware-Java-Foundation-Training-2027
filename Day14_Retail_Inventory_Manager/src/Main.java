import java.util.*;

public class Main {
    interface InventoryEntity {
        String getId();
    }

    static class Product implements InventoryEntity, Comparable<Product> {
        private final String sku;
        private final String name;
        private final String category;
        private int stock;

        Product(String sku, String name, String category, int stock) {
            if (sku == null || sku.isBlank() || stock < 0) throw new IllegalArgumentException("Invalid product");
            this.sku = sku; this.name = name; this.category = category; this.stock = stock;
        }
        @Override public String getId() { return sku; }
        public String getName() { return name; }
        public String getCategory() { return category; }
        public int getStock() { return stock; }
        public void setStock(int stock) {
            if (stock < 0) throw new IllegalArgumentException("Stock cannot be negative");
            this.stock = stock;
        }
        // Natural order: category, stock descending, then product name.
        @Override public int compareTo(Product other) {
            int result = category.compareToIgnoreCase(other.category);
            if (result == 0) result = Integer.compare(other.stock, stock);
            if (result == 0) result = name.compareToIgnoreCase(other.name);
            return result;
        }
        @Override public String toString() {
            return String.format("%-8s %-22s %-12s %5d", sku, name, category, stock);
        }
    }

    static class Supplier implements InventoryEntity {
        private final String supplierId;
        private final String name;
        Supplier(String supplierId, String name) { this.supplierId = supplierId; this.name = name; }
        @Override public String getId() { return supplierId; }
        @Override public String toString() { return supplierId + " - " + name; }
    }

    static class Repository<T extends InventoryEntity> {
        private final Map<String, T> data = new LinkedHashMap<>();
        public void add(T item) { data.put(item.getId(), item); }
        public T find(String id) { return data.get(id); }
        public boolean remove(String id) { return data.remove(id) != null; }
        public List<T> findAll() { return new ArrayList<>(data.values()); }
    }

    static class InventoryManager {
        private final Map<String, Product> products = new HashMap<>();
        private final Deque<String> recentActivity = new ArrayDeque<>();

        void add(Product product) {
            products.put(product.getId(), product);
            log("Added " + product.getId());
        }
        void updateStock(String sku, int newStock) {
            Product product = products.get(sku);
            if (product == null) { System.out.println("SKU not found: " + sku); return; }
            product.setStock(newStock);
            log("Updated " + sku + " stock to " + newStock);
        }
        void remove(String sku) {
            if (products.remove(sku) != null) log("Removed " + sku);
        }
        List<Product> lowStock(int threshold) {
            List<Product> result = new ArrayList<>();
            for (Product p : products.values()) if (p.getStock() < threshold) result.add(p);
            result.sort(Comparator.comparingInt(Product::getStock));
            return result;
        }
        void log(String message) {
            if (recentActivity.size() == 10) recentActivity.removeFirst();
            recentActivity.addLast(message);
        }
        Collection<Product> allProducts() { return products.values(); }
        Deque<String> activity() { return recentActivity; }
    }

    public static void main(String[] args) {
        InventoryManager manager = new InventoryManager();
        manager.add(new Product("SKU101", "Wireless Mouse", "Accessories", 35));
        manager.add(new Product("SKU102", "USB Keyboard", "Accessories", 12));
        manager.add(new Product("SKU103", "Office Chair", "Furniture", 8));
        manager.add(new Product("SKU104", "Study Table", "Furniture", 18));
        manager.add(new Product("SKU105", "Web Camera", "Electronics", 6));
        manager.add(new Product("SKU106", "Monitor", "Electronics", 22));
        manager.add(new Product("SKU107", "Notebook", "Stationery", 70));
        manager.add(new Product("SKU108", "Pen Set", "Stationery", 9));
        manager.add(new Product("SKU109", "Desk Lamp", "Furniture", 14));
        manager.add(new Product("SKU110", "Headset", "Electronics", 11));

        System.out.println("INVENTORY – HASHMAP LOOKUP");
        System.out.println(manager.allProducts().stream().filter(p -> p.getId().equals("SKU103")).findFirst().orElse(null));

        manager.updateStock("SKU102", 25);
        manager.remove("SKU110");
        System.out.println("\nLOW STOCK (below 15)");
        for (Product p : manager.lowStock(15)) System.out.println(p);

        List<Product> naturalOrder = new ArrayList<>(manager.allProducts());
        Collections.sort(naturalOrder);
        System.out.println("\nCOMPARABLE ORDER: CATEGORY, STOCK DESCENDING, NAME");
        naturalOrder.forEach(System.out::println);

        List<Product> nameOrder = new ArrayList<>(manager.allProducts());
        nameOrder.sort(Comparator.comparing(Product::getName));
        System.out.println("\nCOMPARATOR ORDER: PRODUCT NAME");
        nameOrder.forEach(System.out::println);

        System.out.println("\nRECENT STOCK ACTIVITY (MAXIMUM 10)");
        for (String activity : manager.activity()) System.out.println(activity);

        Repository<Product> productRepository = new Repository<>();
        productRepository.add(new Product("SKU201", "Travel Adapter", "Accessories", 16));
        Repository<Supplier> supplierRepository = new Repository<>();
        supplierRepository.add(new Supplier("SUP01", "Metro Supplies"));
        System.out.println("\nGENERIC REPOSITORY");
        System.out.println("Product found: " + productRepository.find("SKU201"));
        System.out.println("Supplier found: " + supplierRepository.find("SUP01"));

        int primitive = 100;
        Integer boxed = primitive; // Autoboxing
        int unboxed = boxed;       // Unboxing
        Integer cachedA = 100;
        Integer cachedB = 100;
        Integer outsideCacheA = 1000;
        Integer outsideCacheB = 1000;
        System.out.println("\nWRAPPER CLASS DEMONSTRATION");
        System.out.println("Autoboxed and unboxed value: " + unboxed);
        System.out.println("100 references using == : " + (cachedA == cachedB));
        System.out.println("1000 references using ==: " + (outsideCacheA == outsideCacheB));
        System.out.println("1000 values using equals(): " + outsideCacheA.equals(outsideCacheB));
    }
}
