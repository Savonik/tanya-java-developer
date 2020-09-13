-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied

-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
37,
4,
'Given:
<code>class Hexy {
  public static void main(String[] args) {
    Integer i = 42;
    String s = (i&lt;40)?"life":(i&gt;50)?"universe":"everything";
    System.out.println(s);
  }
}</code>

What is the result?',
'✔ <b>D</b> is correct. This is a ternary nested in a ternary with a little unboxing thrown in. Both of the ternary expressions are <code>false</code>.
❌ <b>A, B, C, E,</b> and <b>F</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(37, 'A', '<code>null</code>', 0),
(37, 'B', '<code>life</code>', 0),
(37, 'C', '<code>universe</code>', 0),
(37, 'D', '<code>everything</code>', 1),
(37, 'E', 'Compilation fails', 0),
(37, 'F', 'An exception is thrown at runtime', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
38,
4,
'Given:
<code> 1. class Comp2 {
 2.   public static void main(String[] args) {
 3.     float f1 = 2.3f;
 4.     float[][] f2 = {{42.0f}, {1.7f, 2.3f}, {2.6f, 2.7f}};
 5.     float[] f3 = {2.7f};
 6.     Long x = 42L;
 7.     // insert code here
 8.     System.out.println("true");
 9.   }
10. }</code>

And the following five code fragments:
<code>F1. if(f1 == f2)
F2. if(f1 == f2[2][1])
F3. if(x == f2[0][0])
F4. if(f1 == f2[1,1])
F5. if(f3 == f2[2])</code>

What is true?',
'✔ <b>D</b> is correct. Fragments <code>F2, F3,</code> and <code>F5</code> will compile, and only <code>F3</code> is true.
❌ <b>A, B, C, E,</b> and <b>F</b> are incorrect. <code>F1</code> is incorrect because you can’t compare a primitive to an array. <code>F4</code> is incorrect syntax to access an element of a two-dimensional array.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(38, 'A', 'One of them will compile, only one will be <code>true</code>', 0),
(38, 'B', 'Two of them will compile, only one will be <code>true</code>', 0),
(38, 'C', 'Two of them will compile, two will be <code>true</code>', 0),
(38, 'D', 'Three of them will compile, only one will be <code>true</code>', 1),
(38, 'E', 'Three of them will compile, exactly two will be <code>true</code>', 0),
(38, 'F', 'Three of them will compile, exactly three will be <code>true</code>', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
39,
4,
'Given:
<code>class Fork {
  public static void main(String[] args) {
    if(args.length == 1 | args[1].equals("test")) {
      System.out.println("test case");
    } else {
      System.out.println("production " + args[0]);
    }
  }
}</code>

And the command-line invocation:
<code>java Fork live2</code>

What is the result?',
'✔ <b>E</b> is correct. Because the short circuit (<code>||</code>) is not used, both operands are evaluated. Since <code>args[1]</code> is past the args array bounds, an <code>ArrayIndexOutOfBoundsException</code> is thrown.
❌ <b>A, B, C,</b> and <b>D</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(39, 'A', '<code>test case</code>', 0),
(39, 'B', '<code>production live2</code>', 0),
(39, 'C', '<code>test case live2</code>', 0),
(39, 'D', 'Compilation fails', 0),
(39, 'E', 'An exception is thrown at runtime', 1);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
40,
4,
'Given:
<code>class Feline {
  public static void main(String[] args) {
    Long x = 42L;
    Long y = 44L;
    System.out.print(" " + 7 + 2 + " ");
    System.out.print(foo() + x + 5 + " ");
    System.out.println(x + y + foo());
  }
  static String foo() { return "foo"; }
}</code>

What is the result?',
'✔ <b>G</b> is correct. Concatenation runs from left to right, and if either operand is a <code>String</code>, the operands are concatenated. If both operands are numbers they are added together. Unboxing works in conjunction with concatenation.
❌ <b>A, B, C, D, E, F, H,</b> and <b>I</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(40, 'A', '<code>9 foo47 86foo</code>', 0),
(40, 'B', '<code>9 foo47 4244foo</code>', 0),
(40, 'C', '<code>9 foo425 86foo</code>', 0),
(40, 'D', '<code>9 foo425 4244foo</code>', 0),
(40, 'E', '<code>72 foo47 86foo</code>', 0),
(40, 'F', '<code>72 foo47 4244foo</code>', 0),
(40, 'G', '<code>72 foo425 86foo</code>', 1),
(40, 'H', '<code>72 foo425 4244foo</code>', 0),
(40, 'I', 'Compilation fails', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
41,
4,
'Given:
<code> 3. public class Twisty {
 4.   { index = 1; }
 5.   int index;
 6.   public static void main(String[] args) {
 7.     new Twisty().go();
 8.   }
 9.   void go() {
10.     int [][] dd = {{9,8,7}, {6,5,4}, {3,2,1,0}};
11.     System.out.println(dd[index++][index++]);
12.   }
13. }</code>

What is the result? (Choose all that apply.)',
'✔ <b>C</b> is correct. Multidimensional arrays'' dimensions can be inconsistent, the code uses an initialization block, and the increment operators are both post-increment operators.
❌ <b>A, B, D, E, F,</b> and <b>G</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(41, 'A', '1', 0),
(41, 'B', '2', 0),
(41, 'C', '4', 1),
(41, 'D', '6', 0),
(41, 'E', '8', 0),
(41, 'F', 'Compilation fails', 0),
(41, 'G', 'An exception is thrown at runtime', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
42,
4,
'Given:
<code> 3. public class McGee {
 4.   public static void main(String[] args) {
 5.     Days d1 = Days.TH;
 6.     Days d2 = Days.M;
 7.     for(Days d: Days.values()) {
 8.       if(d.equals(Days.F)) break;
 9.       d2 = d;
10.     }
11.     System.out.println((d1 == d2)?"same old" : "newly new");
12.   }
13.   enum Days {M, T, W, TH, F, SA, SU};
14. }</code>

What is the result?',
'✔ <b>A</b> is correct. All of this syntax is correct. The for-each iterates through the enum using the <code>values()</code> method to return an array. Enums can be compared using either <code>equals()</code> or ==. Enums can be used in a ternary operator''s Boolean test.
❌ <b>B, C, D, E, F,</b> and <b>G</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(42, 'A', '<code>same old</code>', 1),
(42, 'B', '<code>newly new</code>', 0),
(42, 'C', 'Compilation fails due to multiple errors', 0),
(42, 'D', 'Compilation fails due only to an error on line 7', 0),
(42, 'E', 'Compilation fails due only to an error on line 8', 0),
(42, 'F', 'Compilation fails due only to an error on line 11', 0),
(42, 'G', 'Compilation fails due only to an error on line 13', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
43,
4,
'Given:
<code> 4. public class SpecialOps {
 5.   public static void main(String[] args) {
 6.     String s = "";
 7.     Boolean b1 = true;
 8.     Boolean b2 = false;
 9.     if((b2 = false) | (21%5) &gt; 2) s += "x";
10.     if(b1 || (b2 = true)) s += "y";
11.     if(b2 == true) s += "z";
12.     System.out.println(s);
13.   }
14. }</code>

Which are true? (Choose all that apply.)',
'✔ <b>C</b> is correct. First of all, boxing takes care of the Boolean. Line 9 uses the modulus operator, which returns the remainder of the division, which in this case is 1. Also, line 9 sets <code>b2</code> to false, and it doesn''t test <code>b2</code>''s value. Line 10 sets <code>b2</code> to true, and it doesn''t test its value; however, the short circuit operator keeps the expression <code>b2 = true</code> from being executed.
❌ <b>A, B, D,</b> and <b>E</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(43, 'A', 'Compilation fails', 0),
(43, 'B', 'x will be included in the output', 0),
(43, 'C', 'y will be included in the output', 1),
(43, 'D', 'z will be included in the output', 0),
(43, 'E', 'An exception is thrown at runtime', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
44,
4,
'Given:
<code> 3. public class Spock {
 4.   public static void main(String[] args) {
 5.     int mask = 0;
 6.     int count = 0;
 7.     if( ((5 &lt; 7) || (++count &lt; 10)) | mask++ &lt; 10 ) mask = mask + 1;
 8.     if( (6 &gt; 8) ^ false) mask = mask + 10;
 9.     if( !(mask &gt; 1) && ++count &gt; 1) mask = mask + 100;
10.     System.out.println(mask + " " + count);
11.   }
12. }</code>

Which two answers are true about the value of mask and the value of count at line 10? (Choose two.)',
'✔ <b>C</b> and <b>F</b> are correct. At line 7 the <code>||</code> keeps <code>count</code> from being incremented, but the | allows <code>mask</code> to be incremented. At line 8 the <code>^</code> returns true only if exactly one operand is true. At line 9 <code>mask</code> is 2 and the <code>&&</code> keeps <code>count</code> from being incremented.
❌ <b>A, B, D, E,</b> and <b>G</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(44, 'A', '<code>mask</code> is 0', 0),
(44, 'B', '<code>mask</code> is 1', 0),
(44, 'C', '<code>mask</code> is 2', 1),
(44, 'D', '<code>mask</code> is 10', 0),
(44, 'E', '<code>mask</code> is greater than 10', 0),
(44, 'F', '<code>count</code> is 0', 1),
(44, 'G', '<code>count</code> is greater than 0', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
45,
4,
'Given:
<code> 3. interface Vessel { }
 4. interface Toy { }
 5. class Boat implements Vessel { }
 6. class Speedboat extends Boat implements Toy { }
 7. public class Tree {
 8.   public static void main(String[] args) {
 9.     String s = "0";
10.     Boat b = new Boat();
11.     Boat b2 = new Speedboat();
12.     Speedboat s2 = new Speedboat();
13.     if((b instanceof Vessel) && (b2 instanceof Toy)) s += "1";
14.     if((s2 instanceof Vessel) && (s2 instanceof Toy)) s += "2";
15.     System.out.println(s);
16.   }
17. }</code>

What is the result?',
'✔ <b>D</b> is correct. First, remember that <code>instanceof</code> can look up through multiple levels of an inheritance tree. Also remember that <code>instanceof</code> is commonly used before attempting a downcast, so in this case, after line 15, it would be possible to say <code>Speedboat s3 = (Speedboat)b2;</code>.
❌ <b>A, B, C, E,</b> and <b>F</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(45, 'A', '<code>0</code>', 0),
(45, 'B', '<code>01</code>', 0),
(45, 'C', '<code>02</code>', 0),
(45, 'D', '<code>012</code>', 1),
(45, 'E', 'Compilation fails', 0),
(45, 'F', 'An exception is thrown at runtime', 0);

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
