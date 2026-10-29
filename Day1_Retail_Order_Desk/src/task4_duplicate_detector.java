import java.util.Arrays;
class Task4_Duplicate_Detector {
    public static void main(String[] args) {
        int[] ids = {101, 102, 103, 102, 104};
        Arrays.sort(ids);
        System.out.println("Sorted IDs: " + Arrays.toString(ids));
        for (int i = 1; i < ids.length; i++) {
            if (ids[i] == ids[i - 1]) System.out.println("Duplicate ID found: " + ids[i]);
        }
    }
}