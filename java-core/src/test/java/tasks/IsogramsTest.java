package tasks;
import org.junit.Test;
import static org.junit.Assert.*;
import static tasks.Isograms.isIsogram;


public class IsogramsTest {
    @Test
    public void testNotIsogram(){
        assertFalse("moOuse is not isogram", isIsogram("moOuse"));
        assertFalse("moOuse is not isogram", isIsogram("ooo"));
        assertFalse("Eugene is not isogram", isIsogram("Eugene"));
        
    }
    @Test
    public void testIsEmptyIsogram(){
        assertTrue(isIsogram(""));
    }
    @Test
    public void testIsogram(){
        assertTrue(isIsogram("Tany"));
        assertTrue(isIsogram("Lida"));
        
    }
}
