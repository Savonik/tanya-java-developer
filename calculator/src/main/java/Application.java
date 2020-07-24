import controllers.Controller;
import models.Model;
import views.View;

import javax.swing.*;

/**
 * @author Tatiana Savonik
 */
public class Application {

    public static void main(String[] args) throws ClassNotFoundException, UnsupportedLookAndFeelException, InstantiationException, IllegalAccessException {

        Model model = new Model();
        Controller controller = new Controller(model);
        new View("calculator", controller);
    }
}
