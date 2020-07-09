/*
Create 2 methods, both with recursion
Print all n Fibonacci numbers.
Print only value of n-th element.
 */

package tasks;

class FibonacciNumbers {
    public static void main(String[] args) {
        printFibonacci(15);
        printFibonacciSequence(5);
    }

    public static void printFibonacci(int n) {
        printFibonacciNumbers(n, 1, 1);
    }

    public static void printFibonacciSequence(int n) {
        printFibonacciNumber(n, 0, 1);
    }
    
    public static void printFibonacciNumbers(int n, int f0, int f1) {
        if (n == 0) {
            System.out.println();
            return;
        }
        System.out.print(f0 + " ");
        printFibonacciNumbers(n - 1, f1, f0 + f1);
    }

    public static void printFibonacciNumber(int n, int f0, int f1) {
        if (n == 1) {
            System.out.print(f0);
            return;
        }
        printFibonacciNumber(n - 1, f1, f0 + f1);
    }

}
