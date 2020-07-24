package models;

import views.View;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author Tatiana Savonik
 */
public class Model {

    private String expression = "";

    public Model() {
    }

    public void setExpression(String actionCommand) {
        switch (actionCommand) {
            case ("C"):
                setEmptyExpression();
                break;
            case ("="):
                try {
                    View.setExpressionField(Double.toString(Calculator.calculate(expression)));
                    expression = "";
                } catch (Exception ex) {
                    setEmptyExpression();
                    View.printError();
                }
                break;
            default:
                String newExpression = expression.concat(actionCommand);
                if (!isValid(newExpression)) {
                    System.out.println("Incorrect expression");
                    return;
                }
                expression = newExpression;
                View.setExpressionField(expression);
                break;
        }
    }

    protected void setEmptyExpression() {
        expression = "";
        View.setExpressionField(expression);
    }

    private boolean isValid(String newExpression) {
        Pattern p = Pattern.compile("^[/*0]|[/+*-.]{2,}");
        Matcher matcher = p.matcher(newExpression);
        return !matcher.find();
    }
}
