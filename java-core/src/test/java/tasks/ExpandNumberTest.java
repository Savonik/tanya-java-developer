package tasks;


import org.junit.Test;
import static org.junit.Assert.assertEquals;
import static tasks.ExpandNumber.expandedForm;

public class ExpandNumberTest {
    @Test
    public void testExpandNumber() {
        assertEquals("1000000000 + 200000000 + 5000 + 100 + 60", expandedForm(1200005160));
        assertEquals("10 + 2", expandedForm(12));
        assertEquals("40 + 2", expandedForm(42));
        assertEquals("70000 + 300 + 4", expandedForm(70304));
    }
}
