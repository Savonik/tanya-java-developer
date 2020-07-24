package controllers;

import models.Model;

import java.awt.event.ActionListener;

/**
 * @author Tatiana Savonik
 */
public class Controller {
    private final Model model;
    private ActionListener buttonListener;

    public Controller(Model model) {
        this.model = model;
    }

    public ActionListener getButtonListener() {
        if (buttonListener != null) {
            return buttonListener;
        }

        buttonListener = e -> {
            String actionCommand = e.getActionCommand();
            model.setExpression(actionCommand);
        };
        return buttonListener;
    }
}
    

