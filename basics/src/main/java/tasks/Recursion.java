package tasks;

public class Recursion {
    public static void main(String[] args) {
        printNumbersAsc(1, 5);
        display(5);
        printNumbersDesc(5);
    }

    public static void printNumbersAsc(int first, int last) {
        if (first > last) {
            return;
        }
        System.out.print(first+"    ");
        printNumbersAsc(first + 1, last);
    }

    private static void display(int n) {
        if (n > 1) {
            display(n - 1);
        }
        System.out.print(n + "  ");
    }

    public static void printNumbersDesc(int last) {
        if (last < 1) {
            return;
        }
        System.out.print(last+"    ");
        printNumbersDesc(last-1);
    }
}

