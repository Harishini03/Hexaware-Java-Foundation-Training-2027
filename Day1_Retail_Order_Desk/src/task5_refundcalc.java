import java.util.Arrays;
class Task5_RefundCalc {
    public static void demonstrateRefund() {
        int[] denominations = {25, 10, 5, 1};
        int amount = 63;
        System.out.println("Greedy example: refund " + amount + " using " + Arrays.toString(denominations));
        System.out.println("Greedy minimum notes/coins: " + greedyCount(denominations, amount));
        int[] failingDenominations = {4, 3, 1};
        int failingAmount = 6;
        System.out.println("Greedy failure example: denominations " + Arrays.toString(failingDenominations) + ", amount " + failingAmount);
        System.out.println("Greedy count: " + greedyCount(failingDenominations, failingAmount));
        System.out.println("Dynamic programming minimum count: " + minimumCoinsDP(failingDenominations, failingAmount));
        System.out.println("DP produces 3 + 3 (2 coins), while greedy produces 4 + 1 + 1 (3 coins).");
    }
    private static int greedyCount(int[] denominations, int amount) {
        int count = 0, remaining = amount;
        for (int coin : denominations) {
            if (coin <= 0) continue;
            count += remaining / coin;
            remaining %= coin;
        }
        return remaining == 0 ? count : -1;
    }
    private static int minimumCoinsDP(int[] denominations, int amount) {
        int[] dp = new int[amount + 1];
        Arrays.fill(dp, amount + 1);
        dp[0] = 0;
        for (int current = 1; current <= amount; current++) {
            for (int coin : denominations) {
                if (coin > 0 && coin <= current) dp[current] = Math.min(dp[current], dp[current - coin] + 1);
            }
        }
        return dp[amount] > amount ? -1 : dp[amount];
    }
}