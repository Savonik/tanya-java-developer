/*
You have an array of numbers.
Your task is to sort ascending odd (1, 3, 5…) 
numbers but even (2, 4, 6…) numbers must be on their places.
Zero isn't an odd number and you don't need to move it. 
If you have an empty array, you need to return it.
ExamplesortArray([5, 3, 2, 8, 1, 4]) == [1, 3, 2, 8, 5, 4]
 */

package tasks;

import java.util.Arrays;
import java.util.concurrent.atomic.AtomicInteger;

public class SortOdd {
    public static int[] sortOdd(int[] array) {
        int[] sortedOddArray = Arrays.stream(array)
                .filter(value -> value % 2 != 0)
                .sorted()
                .toArray();
        AtomicInteger count = new AtomicInteger();
        return Arrays.stream(array)
                .map(value -> value % 2 != 0 ? sortedOddArray[count.getAndIncrement()] : value)
                .toArray();
    }
}
