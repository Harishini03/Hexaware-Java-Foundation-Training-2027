import java.util.Arrays;

public class Main {
    enum PolicyStatus { DRAFT, ACTIVE, LAPSED, CANCELLED }

    interface PolicyReport {
        void printSummary();
    }

    static abstract class Policy implements PolicyReport {
        private final String policyNumber;
        private final String holder;
        private PolicyStatus status;

        Policy(String policyNumber, String holder, PolicyStatus status) {
            if (policyNumber == null || !policyNumber.matches("POL-[0-9]{4}")) {
                throw new IllegalArgumentException("Policy number must match POL-1234");
            }
            if (holder == null || holder.isBlank()) {
                throw new IllegalArgumentException("Policy holder is required");
            }
            this.policyNumber = policyNumber;
            this.holder = holder;
            this.status = status;
        }

        public String getPolicyNumber() { return policyNumber; }
        public String getHolder() { return holder; }
        public PolicyStatus getStatus() { return status; }
        public void setStatus(PolicyStatus status) {
            if (status == null) throw new IllegalArgumentException("Status cannot be null");
            this.status = status;
        }

        public abstract double calculatePremium();

        @Override
        public void printSummary() {
            System.out.printf("%-10s %-14s %-10s Rs. %8.2f%n",
                    policyNumber, getClass().getSimpleName(), status, calculatePremium());
        }
    }

    static class MotorPolicy extends Policy {
        private final double vehicleValue;
        MotorPolicy(String no, String holder, PolicyStatus status, double value) {
            super(no, holder, status);
            if (value <= 0) throw new IllegalArgumentException("Vehicle value must be positive");
            vehicleValue = value;
        }
        @Override public double calculatePremium() { return vehicleValue * 0.025 + 1200; }
    }

    static class HealthPolicy extends Policy {
        private final int age;
        HealthPolicy(String no, String holder, PolicyStatus status, int age) {
            super(no, holder, status);
            if (age < 1 || age > 100) throw new IllegalArgumentException("Age must be 1-100");
            this.age = age;
        }
        @Override public double calculatePremium() { return 4000 + age * 85.0; }
    }

    static class TravelPolicy extends Policy {
        private final int travelDays;
        TravelPolicy(String no, String holder, PolicyStatus status, int days) {
            super(no, holder, status);
            if (days <= 0) throw new IllegalArgumentException("Travel days must be positive");
            travelDays = days;
        }
        @Override public double calculatePremium() { return 350 + travelDays * 125.0; }
    }

    // New product: existing policy classes do not need modification.
    static class HomePolicy extends Policy {
        private final double propertyValue;
        HomePolicy(String no, String holder, PolicyStatus status, double value) {
            super(no, holder, status);
            if (value <= 0) throw new IllegalArgumentException("Property value must be positive");
            propertyValue = value;
        }
        @Override public double calculatePremium() { return propertyValue * 0.004 + 1800; }
    }

    public static void main(String[] args) {
        Policy[] policies = {
            new MotorPolicy("POL-1001", "Asha", PolicyStatus.ACTIVE, 600000),
            new HealthPolicy("POL-1002", "Bala", PolicyStatus.ACTIVE, 28),
            new TravelPolicy("POL-1003", "Charan", PolicyStatus.DRAFT, 12),
            new MotorPolicy("POL-1004", "Divya", PolicyStatus.LAPSED, 850000),
            new HealthPolicy("POL-1005", "Eshan", PolicyStatus.ACTIVE, 42),
            new TravelPolicy("POL-1006", "Farah", PolicyStatus.CANCELLED, 7),
            new HomePolicy("POL-1007", "Gokul", PolicyStatus.ACTIVE, 4500000),
            new HomePolicy("POL-1008", "Hema", PolicyStatus.DRAFT, 3200000)
        };

        System.out.println("INSURANCE POLICY PREMIUM REPORT");
        System.out.println("Policy No  Policy Type    Status     Premium");
        for (Policy policy : policies) {
            policy.printSummary(); // Runtime polymorphism
        }

        double[][] monthlyByRegion = {
            {12000, 14500, 13200},
            {9800, 11200, 10500},
            {15600, 14800, 16200}
        };
        String[] regions = {"North", "South", "West"};
        System.out.println("\nMONTHLY COLLECTION BY REGION");
        for (int i = 0; i < monthlyByRegion.length; i++) {
            double total = 0;
            for (double amount : monthlyByRegion[i]) total += amount;
            System.out.printf("%-8s Rs. %.2f%n", regions[i], total);
        }

        double[][] jaggedBranches = {
            {5000, 6200},
            {7100, 6800, 7300},
            {4500, 4900, 5100, 5300}
        };
        System.out.println("\nCOLLECTION BY REGION WITH DIFFERENT BRANCH COUNTS");
        for (int i = 0; i < jaggedBranches.length; i++) {
            System.out.printf("%s: branches=%d, total=Rs. %.2f%n",
                    regions[i], jaggedBranches[i].length,
                    Arrays.stream(jaggedBranches[i]).sum());
        }

        System.out.println("\nOCP: HomePolicy was added as a new Policy subclass.");
        System.out.println("The existing MotorPolicy, HealthPolicy and TravelPolicy classes remain unchanged.");
    }
}
