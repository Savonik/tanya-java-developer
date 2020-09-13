-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied

-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
46,
5,
'Given two files:
<code>1. class One {
2.   public static void main(String[] args) {
3.     int assert = 0;
4.   }
5. }
1. class Two {
2.   public static void main(String[] args) {
3.     assert(false);
4.   }
5. }</code>

And the four command-line invocations:
<code>javac -source 1.3 One.java
javac -source 1.4 One.java
javac -source 1.3 Two.java
javac -source 1.4 Two.java
</code>

What is the result? (Choose all that apply.)',
'✔ <b>B</b> and <b>F</b> are correct. Class One will compile (and issue a warning) using the <code>1.3</code> flag, and class Two will compile using the <code>1.4</code> flag.
❌ <b>A, C, D,</b> and <b>E</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(46, 'A', 'Only one compilation will succeed', 0),
(46, 'B', 'Exactly two compilations will succeed', 1),
(46, 'C', 'Exactly three compilations will succeed', 0),
(46, 'D', 'All four compilations will succeed', 0),
(46, 'E', 'No compiler warnings will be produced', 0),
(46, 'F', 'At least one compiler warning will be produced', 1);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
47,
5,
'Given:
<code>class Plane {
  static String s = "-";
  public static void main(String[] args) {
    new Plane().s1();
    System.out.println(s);
  }
  void s1() {
    try { s2(); }
    catch (Exception e) { s += "c"; }
  }
  void s2() throws Exception {
    s3(); s += "2";
    s3(); s += "2b";
  }
  void s3() throws Exception {
    throw new Exception();
} }</code>

What is the result?',
'✔ <b>B</b> is correct. Once <code>s3()</code> throws the exception to <code>s2()</code>, <code>s2()</code> throws it to <code>s1()</code>, and no more of <code>s2()</code>’s code will be executed.
❌ <b>A, C, D, E, F, G,</b> and <b>H</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(47, 'A', '<code>-</code>', 0),
(47, 'B', '<code>-c</code>', 1),
(47, 'C', '<code>-c2</code>', 0),
(47, 'D', '<code>-2c</code>', 0),
(47, 'E', '<code>-c22b</code>', 0),
(47, 'F', '<code>-2c2b</code>', 0),
(47, 'G', '<code>-2c2bc</code>', 0),
(47, 'H', 'Compilation fails', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
48,
5,
'Given:
<code>try { int x = Integer.parseInt("two"); }</code>

Which could be used to create an appropriate catch block? (Choose all that apply.)',
'✔ <b>C</b> and <b>D</b> are correct. <code>Integer.parseInt</code> can throw a <code>NumberFormatException</code>, and <code>IllegalArgumentException</code> is its superclass (i.e., a broader exception).
❌ <b>A, B, E,</b> and <b>F</b> are not in NumberFormatException’s class hierarchy.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(48, 'A', '<code>ClassCastException</code>', 0),
(48, 'B', '<code>IllegalStateException</code>', 0),
(48, 'C', '<code>NumberFormatException</code>', 1),
(48, 'D', '<code>IllegalArgumentException</code>', 1),
(48, 'E', '<code>ExceptionInInitializerError</code>', 0),
(48, 'F', '<code>ArrayIndexOutOfBoundsException</code>', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
49,
5,
'Which are true? (Choose all that apply.)',
'✔ <b>C, D,</b> and <b>E</b> are correct statements.
❌ <b>A</b> is incorrect. It is acceptable to use assertions to test the arguments of private methods. <b>B</b> is incorrect. While assertion errors can be caught, Sun discourages you from doing so.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(49, 'A', 'It is appropriate to use assertions to validate arguments to methods marked <code>public</code>', 0),
(49, 'B', 'It is appropriate to catch and handle assertion errors', 0),
(49, 'C', 'It is NOT appropriate to use assertions to validate command-line arguments', 1),
(49, 'D', 'It is appropriate to use assertions to generate alerts when you reach code that should not be reachable', 1),
(49, 'E', 'It is NOT appropriate for assertions to change a program’s state', 1);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
50,
5,
'Given:
<code>1. class Loopy {
2.   public static void main(String[] args) {
3.     int[] x = {7,6,5,4,3,2,1};
4.     // insert code here
5.       System.out.print(y + " ");
6.     }
7. } }</code>

Which, inserted independently at line 4, compiles? (Choose all that apply.)',
'✔ <b>A, D,</b> and <b>F</b> are correct. <b>A</b> is an example of the enhanced for loop. <b>D</b> and <b>F</b> are examples of the basic <code>for</code> loop.
❌ <b>B</b> is incorrect because its operands are swapped. <b>C</b> is incorrect because the enhanced for must declare its first operand. <b>E</b> is incorrect syntax to declare two variables in a for statement.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(50, 'A', '<code>for(int y : x) {</code>', 1),
(50, 'B', '<code>for(x : int y) {</code>', 0),
(50, 'C', '<code>int y = 0; for(y : x) {</code>', 0),
(50, 'D', '<code>for(int y=0, z=0; z&lt;x.length; z++) { y = x[z];</code>', 1),
(50, 'E', '<code>for(int y=0, int z=0; z&lt;x.length; z++) { y = x[z];</code>', 0),
(50, 'F', '<code>int y = 0; for(int z=0; z&lt;x.length; z++) { y = x[z];</code>', 1);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
51,
5,
'Given:
<code>class Emu {
  static String s = "-";
  public static void main(String[] args) {
    try {
      throw new Exception();
    } catch (Exception e) {
      try {
        try { throw new Exception();
        } catch (Exception ex) { s += "ic "; }
        throw new Exception(); }
      catch (Exception x) { s += "mc "; }
      finally { s += "mf "; }
    } finally { s += "of "; }
    System.out.println(s);
} }</code>

What is the result?',
'✔ <b>E</b> is correct. There is no problem nesting <code>try / catch</code> blocks. As is normal, when an exception is thrown, the code in the catch block runs, then the code in the <code>finally</code> block runs.
❌ <b>A, B, C, D,</b> and <b>F</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(51, 'A', '<code>-ic of</code>', 0),
(51, 'B', '<code>-mf of</code>', 0),
(51, 'C', '<code>-mc mf</code>', 0),
(51, 'D', '<code>-ic mf of</code>', 0),
(51, 'E', '<code>-ic mc mf of</code>', 1),
(51, 'F', '<code>-ic mc of mf</code>', 0),
(51, 'G', 'Compilation fails', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
52,
5,
'Given:
<code> 3. class SubException extends Exception { }
 4. class SubSubException extends SubException { }
 5.
 6. public class CC { void doStuff() throws SubException { } }
 7.
 8. class CC2 extends CC { void doStuff() throws SubSubException { } }
 9.
10. class CC3 extends CC { void doStuff() throws Exception { } }
11.
12. class CC4 extends CC { void doStuff(int x) throws Exception { } }
13.
14. class CC5 extends CC { void doStuff() { } }</code>

What is the result?',
'✔ <b>C</b> is correct. An overriding method cannot throw a broader exception than the method it''s overriding. Class CC4''s method is an overload, not an override.
❌ <b>A, B, D,</b> and <b>E</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(52, 'A', 'Compilation succeeds', 0),
(52, 'B', 'Compilation fails due to an error on line 8', 0),
(52, 'C', 'Compilation fails due to an error on line 10', 1),
(52, 'D', 'Compilation fails due to an error on line 12', 0),
(52, 'E', 'Compilation fails due to an error on line 14', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
53,
5,
'Given:
<code> 3. public class Ebb {
 4.   static int x = 7;
 5.   public static void main(String[] args) {
 6.     String s = "";
 7.     for(int y = 0; y &lt; 3; y++) {
 8.       x++;
 9.       switch(x) {
10.         case 8: s += "8 ";
11.         case 9: s += "9 ";
12.         case 10: { s+= "10 "; break; }
13.         default: s += "d ";
14.         case 13: s+= "13 ";
15.       }
16.     }
17.     System.out.println(s);
18.   }
19.   static { x++; }
20. }</code>

What is the result?',
'✔ <b>D</b> is correct. Did you catch the static initializer block? Remember that switches work on "fall-thru" logic, and that fall-thru logic also applies to the default case, which is used when no other case matches.
❌ <b>A, B, C, E, F,</b> and <b>G</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(53, 'A', '<code>9 10 d</code>', 0),
(53, 'B', '<code>8 9 10 d</code>', 0),
(53, 'C', '<code>9 10 10 d</code>', 0),
(53, 'D', '<code>9 10 10 d 13</code>', 1),
(53, 'E', '<code>8 9 10 10 d 13</code>', 0),
(53, 'F', '<code>8 9 10 9 10 10 d 13</code>', 0),
(53, 'G', 'Compilation fails', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
54,
5,
'Given:
<code> 3. class Infinity { }
 4. public class Beyond extends Infinity {
 5.   static Integer i;
 6.   public static void main(String[] args) {
 7.     int sw = (int)(Math.random() * 3);
 8.     switch(sw) {
 9.       case 0: { for(int x = 10; x &gt; 5; x++)
10.                   if(x &gt; 10000000) x = 10;
11.                 break; }
12.       case 1: { int y = 7 * i; break; }
13.       case 2: { Infinity inf = new Beyond();
14.                 Beyond b = (Beyond)inf; }
15.     }
16.   }
17. }</code>

And given that line 7 will assign the value 0, 1, or 2 to sw, which are true? (Choose all that apply.)',
'✔ <b>D</b> and <b>F</b> are correct. Because i was not initialized, case 1 will throw an NPE. Case 0 will initiate an endless loop, not a stack overflow. Case 2''s downcast will not cause an exception.
❌ <b>A, B, C, E,</b> and <b>G</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(54, 'A', 'Compilation fails', 0),
(54, 'B', 'A ClassCastException might be thrown', 0),
(54, 'C', 'A StackOverflowError might be thrown', 0),
(54, 'D', 'A NullPointerException might be thrown', 1),
(54, 'E', 'An IllegalStateException might be thrown', 0),
(54, 'F', 'The program might hang without ever completing', 1),
(54, 'G', 'The program will always complete without exception', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
55,
5,
'Given:
<code> 3. public class Circles {
 4.   public static void main(String[] args) {
 5.     int[] ia = {1,3,5,7,9};
 6.     for(int x : ia) {
 7.       for(int j = 0; j &lt; 3; j++) {
 8.         if(x &gt; 4 && x &lt; 8) continue;
 9.         System.out.print(" " + x);
10.         if(j == 1) break;
11.         continue;
12.       }
13.       continue;
14.     }
15.   }
16. }</code>

What is the result?',
'✔ <b>D</b> is correct. The basic rule for unlabeled continue statements is that the current iteration stops early and execution jumps to the next iteration. The last two continue statements are redundant!
❌ <b>A, B, C, E,</b> and <b>F</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(55, 'A', '<code>1 3 9</code>', 0),
(55, 'B', '<code>5 5 7 7</code>', 0),
(55, 'C', '<code>1 3 3 9 9</code>', 0),
(55, 'D', '<code>1 1 3 3 9 9</code>', 1),
(55, 'E', '<code>1 1 1 3 3 3 9 9 9</code>', 0),
(55, 'F', 'Compilation fails', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
56,
5,
'Given:
<code> 3. public class OverAndOver {
 4.   static String s = "";
 5.   public static void main(String[] args) {
 6.     try {
 7.       s += "1";
 8.       throw new Exception();
 9.     } catch (Exception e) { s += "2";
10.     } finally { s += "3"; doStuff(); s += "4";
11.     }
12.     System.out.println(s);
13.   }
14.   static void doStuff() { int x = 0; int y = 7/x; }
15. }</code>

What is the result?',
'✔ <b>H is correct. It''s true that the value of <code>String s</code> is <code>123</code> at the time that the divide-by- zero exception is thrown, but <code>finally()</code> is not guaranteed to complete, and in this case <code>finally()</code> never completes, so the System.out.println (S.O.P.) never executes.
❌ <b>A, B, C, D, E, F,</b> and <b>G</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(56, 'A', '<code>12</code>', 0),
(56, 'B', '<code>13</code>', 0),
(56, 'C', '<code>123</code>', 0),
(56, 'D', '<code>1234</code>', 0),
(56, 'E', 'Compilation fails', 0),
(56, 'F', '<code>123</code> followed by an exception', 0),
(56, 'G', '<code>1234</code> followed by an exception', 0),
(56, 'H', 'An exception is thrown with no other output', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
57,
5,
'Given:
<code> 3. public class Wind {
 4.   public static void main(String[] args) {
 5.     foreach:
 6.     for(int j=0; j&lt;5; j++) {
 7.       for(int k=0; k&lt;3; k++) {
 8.         System.out.print(" " + j);
 9.         if(j==3 && k==1) break foreach;
10.         if(j==0 || j==2) break;
11.       }
12.     }
13.   }
14. }</code>

What is the result?',
'✔ <b>C</b> is correct. A <code>break</code> breaks out of the current innermost loop and continues. A labeled <code>break</code> breaks out of and terminates the current loops.
❌ <b>A, B, D, E,</b> and <b>F</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(57, 'A', '<code>0 1 2 3</code>', 0),
(57, 'B', '<code>1 1 1 3 3</code>', 0),
(57, 'C', '<code>0 1 1 1 2 3 3</code>', 1),
(57, 'D', '<code>1 1 1 3 3 4 4 4</code>', 0),
(57, 'E', '<code>0 1 1 1 2 3 3 4 4 4</code>', 0),
(57, 'F', 'Compilation fails', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
58,
5,
'Given:
<code> 3. public class Gotcha {
 4.   public static void main(String[] args) {
 5.     // insert code here
 6.
 7.   }
 8.   void go() {
 9.     go();
10.   }
11. }</code>

And given the following three code fragments:
<code>I.   new Gotcha().go();
II.  try { new Gotcha().go(); }
     catch (Error e) { System.out.println("ouch"); }
III. try { new Gotcha().go(); }
     catch (Exception e) { System.out.println("ouch"); }</code>

When fragments I - III are added, independently, at line 5, which are true? (Choose all that apply.)',
'✔ <b>B</b> and <b>E</b> are correct. First off, <code>go()</code> is a badly designed recursive method, guaranteed to cause a StackOverflowError. Since <code>Exception</code> is not a superclass of <code>Error</code>, catching an <code>Exception</code> will not help handle an <code>Error</code>, so fragment III will not complete normally. Only fragment II will catch the <code>Error</code>.
❌ <b>A, C, D,</b> and <b>F</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(58, 'A', 'Some will not compile', 0),
(58, 'B', 'They will all compile', 1),
(58, 'C', 'All will complete normally', 0),
(58, 'D', 'None will complete normally', 0),
(58, 'E', 'Only one will complete normally', 1),
(58, 'F', 'Two of them will complete normally', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
59,
5,
'Given:
<code> 3. public class Clumsy {
 4.   public static void main(String[] args) {
 5.     int j = 7;
 6.     assert(++j &gt; 7);
 7.     assert(++j &gt; 8): "hi";
 8.     assert(j &gt; 10): j=12;
 9.     assert(j==12): doStuff();
10.     assert(j==12): new Clumsy();
11.   }
12.   static void doStuff() { }
13. }</code>

Which are true? (Choose all that apply.)',
'✔ <b>E</b> is correct. When an assert statement has two expressions, the second expression must return a value. The only two-expression assert statement that doesn''t return a value is on line 9.
❌ <b>A, B, C, D,</b> and <b>F</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(59, 'A', 'Compilation succeeds', 0),
(59, 'B', 'Compilation fails due to an error on line 6', 0),
(59, 'C', 'Compilation fails due to an error on line 7', 0),
(59, 'D', 'Compilation fails due to an error on line 8', 0),
(59, 'E', 'Compilation fails due to an error on line 9', 1),
(59, 'F', 'Compilation fails due to an error on line 10', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
60,
5,
'Given:
<code>1. public class Frisbee {
2.   // insert code here
3.     int x = 0;
4.     System.out.println(7/x);
5.   }
6. }</code>

And given the following four code fragments:
<code>I.   public static void main(String[] args) {
II.  public static void main(String[] args) throws Exception {
III. public static void main(String[] args) throws IOException {
IV.  public static void main(String[] args) throws RuntimeException {</code>

If the four fragments are inserted independently at line 4, which are true? (Choose all that apply.)',
'✔ <b>D</b> is correct. This is kind of sneaky, but remember that we''re trying to toughen you up for the real exam. If you''re going to throw an IOException, you have to import the java.io package or declare the exception with a fully qualified name.
❌ <b>E</b> is incorrect because it''s okay to both handle and declare an exception. <b>A, B,</b> and <b>C</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(60, 'A', 'All four will compile and execute without exception', 0),
(60, 'B', 'All four will compile and execute and throw an exception', 0),
(60, 'C', 'Some, but not all, will compile and execute without exception', 0),
(60, 'D', 'Some, but not all, will compile and execute and throw an exception', 1),
(60, 'E', 'When considering fragments II, III, and IV, of those that will compile, adding a try/catch block around line 6 will cause compilation to fail', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
61,
5,
'Given:
<code> 2. class MyException extends Exception { }
 3. class Tire {
 4.   void doStuff() { }
 5. }
 6. public class Retread extends Tire {
 7.   public static void main(String[] args) {
 8.     new Retread().doStuff();
 9.   }
10.   // insert code here
11.     System.out.println(7/0);
12.   }
13. }</code>

And given the following four code fragments:
<code>I.   void doStuff() {
II.  void doStuff() throws MyException {
III. void doStuff() throws RuntimeException {
IV.  void doStuff() throws ArithmeticException {</code>

When fragments I - IV are added, independently, at line 10, which are true? (Choose all that apply.)',
'✔ <b>C</b> and <b>D</b> are correct. An overriding method cannot throw checked exceptions that are broader than those thrown by the overridden method. However an overriding method can throw RuntimeExceptions not thrown by the overridden method.
❌ <b>A, B, E,</b> and <b>F</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(61, 'A', 'None will compile', 0),
(61, 'B', 'They will all compile', 0),
(61, 'C', 'Some, but not all, will compile', 1),
(61, 'D', 'All of those that compile will throw an exception at runtime', 1),
(61, 'E', 'None of those that compile will throw an exception at runtime', 0),
(61, 'F', 'Only some of those that compile will throw an exception at runtime', 0);

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back

