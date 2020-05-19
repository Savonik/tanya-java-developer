package tasks;
import org.junit.Test;
import static org.junit.Assert.*;


public class EmailCheckTest {
    @Test
    public void testValidEmail() { 
        assertTrue(EmailCheck.isValid("savonik3636@gmail.com"));
        
    }
    @Test
    public void testInValidEmail() {
        assertFalse(EmailCheck.isValid("savonik3636@gma@il.com"));
        assertFalse(EmailCheck.isValid("savonik3636@@gmail.com"));
        assertFalse(EmailCheck.isValid("@gmail.com"));
        assertFalse(EmailCheck.isValid("savonik3636@gmail..com"));
        assertFalse(EmailCheck.isValid("savonik3636@.com"));
        assertFalse(EmailCheck.isValid("savonik3636@cc."));
        assertFalse(EmailCheck.isValid("savonik3636gmail.com@"));
      
              
    }
    
}
