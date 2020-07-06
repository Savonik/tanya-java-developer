import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

/**
 * @author Tatiana Savonik
 */

public class UI extends JFrame {
    private JTextField expressionField;
    private MyButton equalsBtn;
    private ButtonsPanel buttonsPanel;

    public UI(String title) {
        super(title);
        init();
    }

    public static void main(String[] args) throws ClassNotFoundException, UnsupportedLookAndFeelException, InstantiationException, IllegalAccessException {
        UI frame = new UI("Calculator");
        frame.setLocationRelativeTo(null);
        UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
        frame.setVisible(true);
    }

    private void init() {
        this.setSize(320, 400);
        this.setResizable(false);
        BorderLayout borderLayout = new BorderLayout();
        borderLayout.setHgap(2);
        borderLayout.setVgap(2);
        this.getContentPane().setLayout(borderLayout);
        this.add(this.getExpressionField(), BorderLayout.NORTH);
        this.add(this.getEqualsBtn(), BorderLayout.EAST);
        this.add(this.getButtonsPanel());
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }

    private ButtonsPanel getButtonsPanel() {
        if (buttonsPanel != null) {
            return buttonsPanel;
        }
        buttonsPanel = new ButtonsPanel(expressionField);
        buttonsPanel.setBackground(Color.orange);
        return buttonsPanel;
    }

    private MyButton getEqualsBtn() {
        if (equalsBtn != null) {
            return equalsBtn;
        }
        equalsBtn = new MyButton("=");
        equalsBtn.addActionListener(new ButtonListener());
        return equalsBtn;
    }

    private JTextField getExpressionField() {
        if (expressionField != null) {
            return expressionField;
        }
        expressionField = new JTextField("");
        expressionField.setEditable(false);
        expressionField.setBackground(Color.white);
        expressionField.setPreferredSize(new Dimension(30, 50));
        expressionField.setFont(new Font("Dialog", Font.ITALIC, 20));
        return expressionField;
    }

    class ButtonListener implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            try {
                expressionField.setText(String.valueOf(Calculator.calculate(getExpressionField().getText())));
            } catch (Exception ex) {
                JOptionPane.showMessageDialog(UI.this, "Invalid expression", "ERROR", JOptionPane.ERROR_MESSAGE);
            }
        }
    }
}
