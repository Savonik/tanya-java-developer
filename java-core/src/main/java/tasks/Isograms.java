/*
An isogram is a word that has no repeating letters, consecutive or non-consecutive. 
Implement a function that determines whether a string that contains only letters 
is an isogram. Assume the empty string is an isogram. Ignore letter case.
    isIsogram("Dermatoglyphics") == true
    isIsogram("aba") == false
    isIsogram "moOse" == false -- ignore letter case
 */

package tasks;
import java.util.Scanner;
public class Isograms {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String s = scanner.nextLine();
        System.out.println(isIsogram(s));
    }

    static boolean isIsogram(String s) {
        s = s.toUpperCase();
        char[] chars = s.toCharArray();
        for (int i = 0; i < chars.length; i++)
            for (int j = 1; j < chars.length-i; j++)
                if (chars[i] == chars[i+j]) {
                    return false;
                }
        return true;
    }
}
