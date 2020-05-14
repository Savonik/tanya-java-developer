package tasks;

import java.util.Scanner;

public class Isograms {
/*
An isogram is a word that has no repeating letters, consecutive or non-consecutive. 
Implement a function that determines whether a string that contains only letters 
is an isogram. Assume the empty string is an isogram. Ignore letter case.
    isIsogram("Dermatoglyphics") == true
    isIsogram("aba") == false
    isIsogram "moOse" == false -- ignore letter case
 */
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String s = scanner.nextLine().toUpperCase();
        if (s.length() == 0) {
            System.out.println(true);
        }
        char[] chars = s.toCharArray();

        for (int i = 0; i < chars.length; i++)
            for (int j = 0; j < chars.length; j++)
                if ((chars[j] == chars[i]) && (i != j)) {
                    chars[j] = ' ';
                }
        String isogram = String.valueOf(chars).replaceAll(" ", "");
        System.out.println(s.equals(isogram));
    }
}
