package tasks;

import org.junit.Assert;
import org.junit.Test;

public class SplitStringByPairsTest {
    @Test
    public void testSplitStringByPairsTest() {
        Assert.assertArrayEquals(new String[]{"ab", "c_"}, SplitStringByPairs.splitByPairs("abc"));
        Assert.assertArrayEquals(new String[]{"ab", "cd", "ef"}, SplitStringByPairs.splitByPairs("abcdef"));
    }
}
