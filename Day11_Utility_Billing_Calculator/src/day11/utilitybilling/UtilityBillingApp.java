package day11.utilitybilling;

import java.util.Scanner;

/**
 * Beginner-friendly electricity bill calculator.
 * Sample tariff values are used because the assignment sheet does not give rates.
 */
public class UtilityBillingApp {

    enum ConsumerCategory {
        DOMESTIC, COMMERCIAL, INDUSTRIAL
    }

    private static final double RATE_FIRST_100 = 1.50;
    private static final double RATE_101_TO_200 = 2.50;
    private static final double RATE_201_TO_400 = 4.00;
    private static final double RATE_ABOVE_400 = 6.00;

    public static void main(String[] args) {
        try (Scanner scanner = new Scanner(System.in)) {
            System.out.println("===== ELECTRICITY BILLING =====");

            System.out.print("Category (DOMESTIC/COMMERCIAL/INDUSTRIAL): ");
            String categoryText = scanner.next().trim().toUpperCase();

            ConsumerCategory category;
            try {
                category = ConsumerCategory.valueOf(categoryText);
            } catch (IllegalArgumentException exception) {
                System.out.println("Invalid category. Using DOMESTIC.");
                category = ConsumerCategory.DOMESTIC;
            }

            System.out.print("Units consumed: ");
            int units = scanner.nextInt();
            if (units < 0) {
                System.out.println("Units cannot be negative. Using zero.");
                units = 0;
            }

            System.out.print("Late payment? (true/false): ");
            boolean late = scanner.nextBoolean();
            System.out.print("Online payment? (true/false): ");
            boolean online = scanner.nextBoolean();

            double energy = calculateEnergyCharge(units);
            double fixed = getFixedCharge(category);
            double beforeAdjustments = energy + fixed;
            double surcharge = late ? beforeAdjustments * 0.05 : 0.0;
            double afterSurcharge = beforeAdjustments + surcharge;
            double rebate = online ? afterSurcharge * 0.02 : 0.0;
            double finalBill = afterSurcharge - rebate;

            printBill(units, category, energy, fixed, surcharge, rebate, finalBill);
            printTwelveMonthStatement();
            readMeterReadings(scanner);
            showCastingExamples();
        }
    }

    // Progressive slabs: every part of the units uses its own rate.
    private static double calculateEnergyCharge(int units) {
        if (units <= 100) {
            return units * RATE_FIRST_100;
        } else if (units <= 200) {
            return 100 * RATE_FIRST_100
                    + (units - 100) * RATE_101_TO_200;
        } else if (units <= 400) {
            return 100 * RATE_FIRST_100
                    + 100 * RATE_101_TO_200
                    + (units - 200) * RATE_201_TO_400;
        } else {
            return 100 * RATE_FIRST_100
                    + 100 * RATE_101_TO_200
                    + 200 * RATE_201_TO_400
                    + (units - 400) * RATE_ABOVE_400;
        }
    }

    // A switch expression returns the fixed charge.
    private static double getFixedCharge(ConsumerCategory category) {
        return switch (category) {
            case DOMESTIC -> 50.00;
            case COMMERCIAL -> 150.00;
            case INDUSTRIAL -> 300.00;
        };
    }

    private static void printBill(int units, ConsumerCategory category,
            double energy, double fixed, double surcharge,
            double rebate, double finalBill) {
        System.out.println("\n----------- BILL -----------");
        System.out.printf("Category          : %s%n", category);
        System.out.printf("Units             : %d%n", units);
        System.out.printf("Energy charge     : Rs. %.2f%n", energy);
        System.out.printf("Fixed charge      : Rs. %.2f%n", fixed);
        System.out.printf("Late surcharge    : Rs. %.2f%n", surcharge);
        System.out.printf("Online rebate     : Rs. %.2f%n", rebate);
        System.out.printf("Final bill        : Rs. %.2f%n", finalBill);
        System.out.println("----------------------------");
    }

    // The for loop runs exactly 12 times to print the sample monthly statement.
    private static void printTwelveMonthStatement() {
        int[] monthlyUnits = {80, 95, 110, 125, 150, 175,
                              190, 210, 230, 260, 300, 120};

        System.out.println("\n------ 12-MONTH STATEMENT ------");
        System.out.printf("%-8s %-8s %-15s%n", "Month", "Units", "Energy charge");
        for (int month = 0; month < monthlyUnits.length; month++) {
            double charge = calculateEnergyCharge(monthlyUnits[month]);
            System.out.printf("%-8d %-8d Rs. %-10.2f%n",
                    month + 1, monthlyUnits[month], charge);
        }
    }

    // A do-while loop runs at least once and stops when the user enters 0.
    private static void readMeterReadings(Scanner scanner) {
        int reading;
        System.out.println("\nEnter meter readings (0 to stop).");
        do {
            System.out.print("Meter reading: ");
            reading = scanner.nextInt();
            if (reading < 0) {
                System.out.println("A reading cannot be negative.");
            } else if (reading > 0) {
                System.out.println("Reading saved: " + reading);
            }
        } while (reading != 0);
        System.out.println("Meter-reading input completed.");
    }

    private static void showCastingExamples() {
        System.out.println("\n------ PRIMITIVE CASTING ------");

        int total = 5;
        int count = 2;
        double wrongAverage = total / count; // Integer division: result is 2.
        double correctAverage = (double) total / count;
        System.out.println("5 / 2 with int values: " + wrongAverage);
        System.out.println("(double) 5 / 2: " + correctAverage);

        int overflowExample = Integer.MAX_VALUE + 1;
        long safeValue = (long) Integer.MAX_VALUE + 1;
        System.out.println("int overflow: " + overflowExample);
        System.out.println("long value: " + safeValue);

        double amount = 125.75;
        int truncatedAmount = (int) amount;
        System.out.println("double amount: " + amount);
        System.out.println("after int cast: " + truncatedAmount);
    }
}
