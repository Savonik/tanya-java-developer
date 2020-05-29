/*
You are given an array of integers. 
Your job is to take that array and find an index N where the sum of the integers to the 
left of N is equal to the sum of the integers to the right of N. If there is no index 
that would make this happen, return -1.
 */

package tasks;

import java.util.stream.IntStream;
import static java.util.Arrays.stream;

public class SplitArrayBySums {
    public static void main(String[] args) {
        int[] array = {1, 3, 3, 4, 0};
        int[] array1 = {1, 3, 4, 0};
        System.out.println(splitBySums(array));
        System.out.println(splitBySums(array1));
    }
    
    public static int splitBySums(int[] array) {
        return IntStream
                .range(0, array.length)
                .filter(i -> sumBefore(array, i) == sumAfter(array, i))
                .findFirst()
                .orElse(-1);
    }

    private static int sumBefore(int[] array, int index) {
        return stream(array, 0, index).sum();
    }

    private static int sumAfter(int[] array, int index) {
        return stream(array, index + 1, array.length).sum();
    }
}
