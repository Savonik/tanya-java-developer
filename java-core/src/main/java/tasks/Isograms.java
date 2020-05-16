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
        s = s.toLowerCase();
        char[] chars = s.toCharArray();
        for (int i = 0; i < chars.length-1; i++)
            for (int j = i+1; j < chars.length; j++)
                if (chars[i] == chars[j]) {
                    return false;
                }
        return true;
    }
}
