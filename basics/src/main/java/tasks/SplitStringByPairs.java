/*
Write the method so that it splits the string into pairs of two characters. If the string contains an odd (1, 3, 5…) 
number of characters then it should replace the missing second character of the final pair with an underscore ('_').
Examples:
solution("abc") // should return {"ab", "c_"}
solution("abcdef") // should return {"ab", "cd", "ef"}
 */

package tasks;

import java.util.Arrays;

public class SplitStringByPairs {
    public static void main(String[] args) {
        System.out.println(Arrays.toString(splitByPairs("xdftg")));
    }

    public static String[] splitByPairs(String s) {
        if (s.length() % 2 != 0) {
            s += "_";
        }
        String[] stringByPairs = new String[s.length() / 2];
        for (int i = 1; i <= s.length(); i+=2) {
            stringByPairs[i / 2] = s.substring(i - 1, i + 1);
        }
        return stringByPairs;
    }
}
