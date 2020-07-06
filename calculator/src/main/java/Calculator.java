import java.util.ArrayList;
import java.util.List;
import java.util.Stack;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author Tatiana Savonik
 */
public class Calculator {

    public static double calculate(String expression) throws ExpressionFormatException {
        List<String> polishExpression = convertToPolishNotation(expression);
        Stack<Double> stack = new Stack<>();
        for (String s : polishExpression) {
            if (isNumber(s)) {
                stack.push(Double.parseDouble(s));
            } else {
                switch (s) {
                    case "+":
                        Double stackPop = stack.pop();
                        if (stack.empty()) {
                            stack.push(stackPop);
                            break;
                        }
                        stack.push(stackPop + stack.pop());
                        break;
                    case "-":
                        Double pop = stack.pop();
                        if (stack.empty()) {
                            stack.push(-pop);
                            break;
                        }
                        stack.push(-pop + stack.pop());
                        break;
                    case "*":
                        stack.push(stack.pop() * stack.pop());
                        break;
                    case "/":
                        Double value = stack.pop();
                        if (value == 0) {
                            Double push = stack.peek() == 0 ? Double.NaN :
                                    stack.peek() > 0 ? Double.POSITIVE_INFINITY : Double.NEGATIVE_INFINITY;
                            stack.pop();
                            stack.push(push);
                            break;
                        }
                        stack.push(stack.pop() / value);
                        break;
                }
            }
        }
        return stack.peek();
    }

    private static List<String> convertToPolishNotation(String expr) throws ExpressionFormatException {
        String expression = prepare(expr);
        if (!isValid(expression)) {
            throw new ExpressionFormatException(expr + " isn't valid");
        }
        String[] splitExpression = expression.split("(?<=[-+*/()])|(?=[-+*/()])");
        List<String> polishNotationList = new ArrayList<>();
        Stack<String> stack = new Stack<>();
        for (int i = 0; i < splitExpression.length; i++) {
            String s = splitExpression[i];
            if (isNumber(s)) {
                polishNotationList.add(s);
                continue;
            }
            if ("(".equals(s)) {
                StringBuilder substring = new StringBuilder();
                i++;
                while (!")".equals(splitExpression[i])) {
                    substring.append(splitExpression[i]);
                    i++;
                }
                polishNotationList.addAll(convertToPolishNotation(substring.toString()));
                continue;
            }
            if (!stack.empty()) {
                while (!stack.empty() && priority(s) <= priority(stack.peek())) {
                    polishNotationList.add(stack.pop());
                }
            }
            stack.push(s);
        }
        while (!stack.empty()) {
            polishNotationList.add(stack.pop());
        }
        return polishNotationList;
    }

    private static String prepare(String expr) {
        return expr.replace(" ", "").replace("--", "+")
                .replace("+-", "-").replace("-+", "-");
    }

    public static boolean isValid(String expression) {
        String exprWithoutLeftBracket = expression.replace("(","");
        String exprWithoutRightBracket = expression.replace(")","");
        
        Pattern p = Pattern.compile("[/+*-.]{2,}");
        Matcher matcher = p.matcher(expression);
        
        if (matcher.find()||exprWithoutLeftBracket.length()!=exprWithoutRightBracket.length()) {
            return false;
        }
        
        return expression.matches("^[0-9(-]{1}[0-9./*\\-+()]+$");
    }

    private static int priority(String token) {
        switch (token) {
            case "+":
            case "-":
                return 1;
            case "*":
            case "/":
                return 2;
            default:
                return 3;
        }
    }

    private static boolean isNumber(String s) {
        return s.matches("[0-9.]+");
    }

}
