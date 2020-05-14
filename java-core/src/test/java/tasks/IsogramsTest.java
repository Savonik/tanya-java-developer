package tasks;

import org.junit.Assert;
import org.junit.Test;

public class IsogramsTest {
    @Test
    public void testNotIsogram(){
        Assert.assertFalse(Isograms.isIsogram("ooo"));
        Assert.assertFalse("Eugene is not isogram", Isograms.isIsogram("Eugene"));
    }
    @Test
    public void testIsEmptyIsogram(){
        Assert.assertTrue(Isograms.isIsogram(""));
    }
    @Test
    public void testIsogram(){
        Assert.assertTrue(Isograms.isIsogram("Tany"));
        Assert.assertTrue(Isograms.isIsogram("Lida"));
    }
}
