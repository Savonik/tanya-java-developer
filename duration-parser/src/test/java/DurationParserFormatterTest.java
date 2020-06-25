import org.junit.Assert;
import org.junit.Test;

import java.time.Duration;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

/**
 * @author Tatiana Savonik
 */
public class DurationParserFormatterTest {
    
    @Test
    public void testDurationParser() throws DurationParserException {
        assertEquals(3602000, new DurationParserFormatter().parse("1h2s").toMillis());
        assertEquals(240000, new DurationParserFormatter().parse("240s").toMillis());
    }

    @Test
    public void testDurationFormatter() throws DurationParserException {
        Duration duration1 = new DurationParserFormatter().parse("16d80h");
        assertEquals("2w5d8h", new DurationParserFormatter().format(duration1));

        Duration duration2 = new DurationParserFormatter().parse("3600s");
        assertEquals("1h", new DurationParserFormatter().format(duration2));

        Duration duration3 = new DurationParserFormatter().parse("0s");
        assertEquals("0ms", new DurationParserFormatter().format(duration3));
    }

    @Test(expected = DurationParserException.class)
    public void testDurationFormatterWithException() throws DurationParserException {
        Duration duration4 = new DurationParserFormatter().parse("w10s");
        new DurationParserFormatter().format(duration4);
    }

    @Test
    public void testDurationFormatterException() {
        try {
            Duration duration5 = new DurationParserFormatter().parse("w10s");
            fail();
        } catch (DurationParserException e) {
            assertTrue(true);
        }
        try {
            Duration duration5 = new DurationParserFormatter().parse("10sm");
            fail();
        } catch (DurationParserException e) {
            assertTrue(true);
        }
    }

}
