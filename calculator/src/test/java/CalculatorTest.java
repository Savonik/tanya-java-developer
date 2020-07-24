import models.Calculator;
import models.ExpressionFormatException;
import org.junit.Assert;
import org.junit.Test;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

/**
 * @author Tatiana Savonik
 */
public class CalculatorTest {
    @Test
    public void testCalculator() throws ExpressionFormatException {
        Assert.assertEquals(3.5, Calculator.calculate("5/2+1"), 0.00001);
        Assert.assertEquals(11, Calculator.calculate("5*(3-2)+6"), 0.00001);
        Assert.assertEquals(-14, Calculator.calculate("2*(1-8)"), 0.00001);
        Assert.assertEquals(32, Calculator.calculate("2*2*2*2*2"), 0.00001);
        Assert.assertEquals(3, Calculator.calculate("1.5+1.5"), 0.00001);
        Assert.assertEquals(-1.5, Calculator.calculate("1.5*(3-8/2)"), 0.00001);
        Assert.assertEquals(7, Calculator.calculate("5.5+1.5"), 0.00001);
        Assert.assertEquals(3, Calculator.calculate("1 + 2 "), 0.00001);
        Assert.assertEquals(-1, Calculator.calculate("4+-5"), 0.00001);
        Assert.assertEquals(-1, Calculator.calculate("4+(-5)"), 0.00001);
        Assert.assertEquals(Double.NaN, Calculator.calculate("0/0"), 0.00001);
        Assert.assertEquals(Double.NEGATIVE_INFINITY, Calculator.calculate("5-3/(4-4)"), 0.00001);
        Assert.assertEquals(Double.NaN, Calculator.calculate("-1/0+1/0"), 0.00001);
        Assert.assertEquals(Double.POSITIVE_INFINITY, Calculator.calculate("1+10000/0"), 0.00001);
    }

    @Test
    public void ExpressionFormatException() {
        try {
            Calculator.calculate("1.5+2%");
            fail();
        } catch (ExpressionFormatException e) {
            assertTrue(true);
        }

        try {
            Calculator.calculate("...5+5");
            fail();
        } catch (ExpressionFormatException e) {
            assertTrue(true);
        }

        try {
            Calculator.calculate("1..5+5");
            fail();
        } catch (ExpressionFormatException e) {
            assertTrue(true);
        }

        try {
            Calculator.calculate("1+2)");
            fail();
        } catch (ExpressionFormatException e) {
            assertTrue(true);
        }
    }
}
