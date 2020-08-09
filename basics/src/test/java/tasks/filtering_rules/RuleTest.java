package tasks.filtering_rules;

import junit.framework.TestCase;

public class RuleTest extends TestCase {

    public void testGetTypePriority() {
        assertEquals(0, new Rule("a", "a", 22).getTypePriority());
        assertEquals(3, new Rule("b", "child", 5).getTypePriority());
        assertEquals(2, new Rule("c", "sub", 12).getTypePriority());
        assertEquals(1, new Rule("d", "root", 2).getTypePriority());
    }

    public void testCompareTo() {
        Rule firstRule = new Rule("a", "sub", 15);
        Rule secondRule = new Rule("S", "child", 140);
        
        assertEquals(0, firstRule.compareTo(firstRule));
        assertEquals(1, firstRule.compareTo(secondRule));
        assertEquals(-1, secondRule.compareTo(firstRule));
    }
}
