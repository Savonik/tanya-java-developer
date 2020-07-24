package views;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionListener;

/**
 * @author Tatiana Savonik
 */
public class ButtonsPanel extends JPanel {

    protected ButtonsPanel() {
        this.setLayout(new GridLayout(4, 5, 2, 2));
        this.add(new MyButton("1"));
        this.add(new MyButton("2"));
        this.add(new MyButton("3"));
        this.add(new MyButton("+"));
        this.add(new MyButton("("));
        this.add(new MyButton("4"));
        this.add(new MyButton("5"));
        this.add(new MyButton("6"));
        this.add(new MyButton("-"));
        this.add(new MyButton(")"));
        this.add(new MyButton("7"));
        this.add(new MyButton("8"));
        this.add(new MyButton("9"));
        this.add(new MyButton("*"));
        this.add(new JLabel());
        this.add(new MyButton("."));
        this.add(new MyButton("0"));
        this.add(new MyButton("C"));
        this.add(new MyButton("/"));
    }

    protected void addListener(ActionListener listener) {
        Component[] components = this.getComponents();
        for (Component component:components) {
            if (component instanceof JButton){
                ((JButton)component).addActionListener(listener);
            }
        }
    }
}
