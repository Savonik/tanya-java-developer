package tasks;

import org.junit.Assert;
import org.junit.Test;

public class IsogramsTest {
    @Test
    public void testNotIsogram(){
        Assert.assertFalse(Isograms.isIsogram("ooo"));
    }
    @Test
    public void testIsEmptyIsogram(){
        Assert.assertTrue(Isograms.isIsogram(""));
    }
}
