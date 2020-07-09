package tasks;
import org.junit.Test;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static tasks.SquaredArray.comp;

public class SquaredArrayTest {
    @Test
    public void testNotSquaredArray() {
        assertFalse( comp(null,null));
        assertFalse( comp(new int[]{121, 144, 19, 161, 19, 144, 19, 11},
                          new int[]{132, 14641, 20736, 361, 25921, 361, 20736, 361}));
        assertFalse( comp(new int[]{121, 144, 19, 161, 19, 144, 19, 11},
                          new int[]{121, 14641, 20736, 36100, 25921, 361, 20736, 361}));
        assertFalse( comp(new int[]{-144, 19, -161, 19, -144, 19, 11},
                new int[]{121, 14641, 20736, 361, 25921, 361, 20736, 361}));

    }

    @Test
    public void testSquaredArray() {
        assertTrue( comp(new int[]{121, 144, 19, 161, 19, 144, 19, 11},
                         new int[]{121, 14641, 20736, 361, 25921, 361, 20736, 361}));
        assertTrue( comp(new int[]{},new int[]{}));
        assertTrue( comp(new int[]{121, -144, 19, -161, 19, -144, 19, 11},
                new int[]{121, 14641, 20736, 361, 25921, 361, 20736, 361}));
    }

}
