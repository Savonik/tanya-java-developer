package views;

import javax.swing.*;
import java.awt.*;

/**
 * @author Tatiana Savonik
 */
public class MyButton extends JButton {

    public MyButton(String text) {
        super(text);
        this.setMinimumSize(new Dimension(40, 40));
        this.setMaximumSize(new Dimension(40, 40));
        this.setFont(new Font("Dialog", Font.BOLD, 20));
    }
}
