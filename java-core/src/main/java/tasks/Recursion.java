package tasks;

public class Recursion {
    public static void main(String[] args) {
        rInc(1, 5);
        display(5);
    }

    public static void rInc(int first, int last) {
        if (first > last) {
            return;
        }
        System.out.print(first+"    ");
        rInc(first + 1, last);
    }

    private static void display(int n) {
        if (n > 1) {
            display(n - 1);
        }
        System.out.print(n + "  ");
    }

    public static void nDesc(int last) {
        if (last < 1) {
            return;
        }
        System.out.print(last+"    ");
        nDesc(last-1);
    }
    
    
}

