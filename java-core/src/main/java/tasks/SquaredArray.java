/*
Valid arrays
a = [121, 144, 19, 161, 19, 144, 19, 11]
b = [121, 14641, 20736, 361, 25921, 361, 20736, 361]

comp(a, b) returns true because in b 121 is the square of 11, 14641 is the square of 121, 20736 the square of 144, 361 the square of 19, 25921 the square of 161, and so on. It gets obvious if we write b's elements in terms of squares:

a = [121, 144, 19, 161, 19, 144, 19, 11]
b = [11*11, 121*121, 144*144, 19*19, 161*161, 19*19, 144*144, 19*19]

Invalid arrays
If we change the first number to something else, comp may not return true anymore:

a = [121, 144, 19, 161, 19, 144, 19, 11]
b = [132, 14641, 20736, 361, 25921, 361, 20736, 361]

comp(a,b) returns false because in b 132 is not the square of any number of a.

a = [121, 144, 19, 161, 19, 144, 19, 11]
b = [121, 14641, 20736, 36100, 25921, 361, 20736, 361]

comp(a,b) returns false because in b 36100 is not the square of any number of a.

Remarks
Numbers in array a might be negative.
a or b might be []
a or b might be null

If a or b are null, the problem doesn't make sense so return false.
 */

package tasks;

import java.util.Arrays;

public class SquaredArray {
    public static void main(String[] args) {
        System.out.println(comp(new int[]{121, 144, 19, 161, 19, 144, 19, 11},
                new int[]{121, 14641, 20736, 361, 25921, 361, 20736, 361}));
        System.out.println(comp(new int[]{1}, new int[]{}));
        System.out.println(comp(new int[]{}, new int[]{}));
        System.out.println(comp(new int[]{121, 144, -19, 161, 19, -144, 19, 11},
                new int[]{121, 14641, 20736, 361, 25921, 361, 20736, 361}));
    }

    protected static boolean comp(int[] a, int[] b) {
        if ((a == null || b == null)||(a.length!=b.length)) {
            return false;
        }
        return Arrays.equals(Arrays.stream(a).map(value -> (int) Math.pow(value, 2)).sorted().toArray(),
                Arrays.stream(b).sorted().toArray());
    }
}
