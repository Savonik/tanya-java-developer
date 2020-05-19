package tasks;

import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class EmailCheck {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String str = scanner.nextLine();
        System.out.println(isValid(str) ? "Valid email" : "Invalid email");
    }

    public static boolean isValid(String s) {
        String regexp = "^[a-zA-Z0-9]+[\\w.-]+[\\w&&[^_]]{1}@{1}[a-zA-Z]+\\.{1}[a-zA-Z]+";
        Pattern pattern = Pattern.compile(regexp);
        Matcher matcher = pattern.matcher(s);
        return matcher.find();
    }
}
