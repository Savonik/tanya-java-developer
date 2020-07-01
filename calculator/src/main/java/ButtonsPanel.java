import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

/**
 * @author Tatiana Savonik
 */
public class ButtonsPanel extends JPanel {
    private final JTextField textField;

    public ButtonsPanel(JTextField textField) {
        this.textField = textField;
        this.setLayout(new GridLayout(4, 5, 2, 2));
        this.add(getButton("1"));
        this.add(getButton("2"));
        this.add(getButton("3"));
        this.add(getButton("+"));
        this.add(getButton("("));
        this.add(getButton("4"));
        this.add(getButton("5"));
        this.add(getButton("6"));
        this.add(getButton("-"));
        this.add(getButton(")"));
        this.add(getButton("7"));
        this.add(getButton("8"));
        this.add(getButton("9"));
        this.add(getButton("*"));
        this.add(new JLabel());
        this.add(getButton("."));
        this.add(getButton("0"));
        this.add(getCButton());
        this.add(getButton("/"));
    }

    private Component getCButton() {
        MyButton button = new MyButton("C");
        button.addActionListener(new CButtonListener());
        return button;
    }

    private Component getButton(String name) {
        MyButton button = new MyButton(name);
        button.addActionListener(new CalcButtonListener());
        return button;
    }

    class CalcButtonListener implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            MyButton btn = (MyButton) e.getSource();
            textField.setText(textField.getText() + btn.getText());
        }
    }

    class CButtonListener implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            textField.setText("");
        }
    }
}
