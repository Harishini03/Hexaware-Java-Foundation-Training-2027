import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Deque;
import java.util.List;
import java.util.Queue;

class Task4_Sorting {
    static class SimpleStack<T> {
        private final List<T> items = new ArrayList<>();
        public void push(T item) { items.add(item); }
        public T pop() { return items.isEmpty() ? null : items.remove(items.size() - 1); }
        public boolean isEmpty() { return items.isEmpty(); }
    }
    static class SimpleQueue<T> {
        private final List<T> items = new ArrayList<>();
        public void enqueue(T item) { items.add(item); }
        public T dequeue() { return items.isEmpty() ? null : items.remove(0); }
        public boolean isEmpty() { return items.isEmpty(); }
    }
    public static void demonstrateStackAndQueue(List<Order> orders) {
        SimpleStack<String> customStack = new SimpleStack<>();
        customStack.push("Change delivery address");
        customStack.push("Change order quantity");
        System.out.println("Custom stack undo: " + customStack.pop());
        Deque<String> builtInStack = new ArrayDeque<>();
        builtInStack.push("Change delivery address");
        builtInStack.push("Change order quantity");
        System.out.println("Built-in stack undo: " + builtInStack.pop());
        SimpleQueue<Integer> customQueue = new SimpleQueue<>();
        Queue<Integer> builtInQueue = new ArrayDeque<>();
        int count = Math.min(3, orders.size());
        for (int i = 0; i < count; i++) {
            customQueue.enqueue(orders.get(i).orderId);
            builtInQueue.offer(orders.get(i).orderId);
        }
        System.out.println("Custom queue dispatch: " + customQueue.dequeue());
        System.out.println("Built-in queue dispatch: " + builtInQueue.poll());
        System.out.println("Stack push/pop: O(1) for both implementations here.");
        System.out.println("Custom queue dequeue is O(n) because it removes index 0; ArrayDeque queue operations are O(1) amortized.");
    }
}