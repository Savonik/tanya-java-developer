package tasks;
import org.junit.Test;
import static org.junit.Assert.*;


public class EmailCheckTest {
    @Test
    public void testValidEmail() { 
        assertEquals("Valid email", EmailCheck.isValid("savonik3636@gmail.com"));
        
    }
    @Test
    public void testInValidEmail() {
        assertEquals("Invalid email", EmailCheck.isValid("savonik3636@gma@il.com"));
        assertEquals("Invalid email", EmailCheck.isValid("savonik3636@@gmail.com"));
        assertEquals("Invalid email", EmailCheck.isValid("@gmail.com"));
        assertEquals("Invalid email", EmailCheck.isValid("savonik3636@gmail..com"));
        assertEquals("Invalid email", EmailCheck.isValid("savonik3636@.com"));
        assertEquals("Invalid email", EmailCheck.isValid("savonik3636@cc."));
        assertEquals("Invalid email", EmailCheck.isValid("savonik3636gmail.com@"));
        assertEquals("Invalid email", EmailCheck.isValid("@savonik3636gmail.com"));
              
    }
    
}
