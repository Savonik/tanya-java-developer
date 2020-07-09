package tasks;

import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static tasks.SplitArrayBySums.splitBySums;

public class SplitArrayBySumsTest {
    @Test
    public void testIsSplitArray() {
        assertEquals(3, splitBySums(new int[]{1, 2, 3, 4, 3, 2, 1}));
        assertEquals(1, splitBySums(new int[]{1, 100, 50, -51, 1, 1}));
        assertEquals(0, splitBySums(new int[]{20, 10, -80, 10, 10, 15, 35}));
        assertEquals(-1, splitBySums(new int[]{1, 2, 3, 4, 5, 6}));
    }
}
