/*
Write number in expanded form. All numbers will be whole numbers greater than 0.
User gives a number and you will need to return it as a string in Expanded Form. For example:
expandedForm(12); # Should return "10 + 2"
expandedForm(42); # Should return "40 + 2"
expandedForm(70304); # Should return "70000 + 300 + 4"
 */

package tasks;

public class ExpandNumber {
    public static void main(String[] args) {
    }

    public static String expandedForm(int number) {
        StringBuilder stringBuilder = new StringBuilder("");
        int numAmount = Integer.toString(number).length();
        for (int i = numAmount; i > 0; i--) {
            int rankNumber = (int) (number % Math.pow(10, i) - number % Math.pow(10, i - 1));
            if (i != numAmount && rankNumber != 0) {
                stringBuilder.append(" + ");
            }
            if (rankNumber != 0) {
                stringBuilder.append(rankNumber);
            }
        }
        return stringBuilder.toString();
    }
}
