package views;

import controllers.Controller;
import models.Model;

import javax.swing.*;
import java.awt.*;

/**
 * @author Tatiana Savonik
 */
public class View extends JFrame {

    private static JTextField expressionField;
    private MyButton equalsBtn;
    private ButtonsPanel buttonsPanel;
    private final Controller controller;

    public View(String title, Controller controller) throws ClassNotFoundException, UnsupportedLookAndFeelException, InstantiationException, IllegalAccessException {
        super(title);
        this.controller = controller;
        init();
        UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
        this.setLocationRelativeTo(null);
        this.setVisible(true);
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
        buttonsPanel = new ButtonsPanel();
        buttonsPanel.addListener(controller.getButtonListener());
        buttonsPanel.setBackground(Color.orange);
        return buttonsPanel;
    }

    private MyButton getEqualsBtn() {
        if (equalsBtn != null) {
            return equalsBtn;
        }
        equalsBtn = new MyButton("=");
        equalsBtn.addActionListener(controller.getButtonListener());
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

    public static void setExpressionField(String expression) {
        expressionField.setText(expression);
    }

    public static void printError() {
        JOptionPane.showMessageDialog(null, "Invalid expression", "ERROR", JOptionPane.ERROR_MESSAGE);
    }
}
