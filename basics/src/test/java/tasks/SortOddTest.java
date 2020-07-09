package tasks;

import org.junit.Test;
import static org.junit.Assert.assertArrayEquals;
import static tasks.SortOdd.sortOdd;

public class SortOddTest {
    @Test
    public void testSortOdd() {
        assertArrayEquals(new int[]{1, 3, 2, 8, 5, 4}, sortOdd(new int[]{5, 3, 2, 8, 1, 4}));
        assertArrayEquals(new int[]{1, 0, 3, 2, 8, 5, 4, 0}, sortOdd(new int[]{5, 0, 3, 2, 8, 1, 4, 0}));
        assertArrayEquals(new int[]{}, sortOdd(new int[]{}));
    }
}
