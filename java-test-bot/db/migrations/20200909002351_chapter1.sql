-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied

INSERT INTO question (id, chapter_id, text, explanation) VALUES (
1,
1,
'Which is true? (Choose all that apply.)',
'✔ Answer: <b>C</b> is correct.
❌ <b>A</b> is incorrect because classes implement interfaces, they don''t extend them. <b>B</b> is incorrect because interfaces only "inherit from" other interfaces. <b>D</b> is incorrect based on the preceding rules.'
);

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(1, 'A','"X extends Y" is correct if and only if X is a class and Y is an interface', 0),
(1, 'B','"X extends Y" is correct if and only if X is an interface and Y is a class', 0),
(1, 'C','"X extends Y" is correct if X and Y are either both classes or both interfaces', 1),
(1, 'D','"X extends Y" is correct for all combinations of X and Y being classes and/or interfaces', 0);


INSERT INTO question (id, chapter_id, text, explanation) VALUES (
2,
1,
'Which method names follow the JavaBeans standard? (Choose all that apply.)',
'✔ <b>B</b> and <b>D</b> use the valid prefixes ''<code>get</code>'' and ''<code>is</code>''.
❌ <b>A</b> is incorrect because ''add'' can be used only with Listener methods. <b>C</b> and <b>E</b> are incorrect because ''<code>delete</code>'' and ''<code>put</code>'' are not standard JavaBeans name prefixes.');

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(2, 'A','<code>addSize</code>', 0),
(2, 'B','<code>getCust</code>', 1),
(2, 'C','<code>deleteRep</code>', 0),
(2, 'D','<code>isColorado</code>', 1),
(2, 'E','<code>putDimensions</code>', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
3,
1,
'Given:
<code>1. class Voop {
2.   public static void main(String [] args) {
3.     doStuff(1);
4.     doStuff(1,2);
5.   }
6.   // insert code here
7. }</code>

Which, inserted independently at line 6, will compile? (Choose all that apply.)',
'✔ <b>A</b> and <b>E</b> use valid var-args syntax.
❌ <b>B</b> and <b>C</b> are invalid var-arg syntax, and <b>D</b> is invalid because the var-arg must be the last of a method''s arguments.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(3, 'A','<code>static void doStuff(int... doArgs) { }</code>', 1),
(3, 'B','<code>static void doStuff(int[] doArgs) { }</code>', 0),
(3, 'C','<code>static void doStuff(int doArgs...) { }</code>', 0),
(3, 'D','<code>static void doStuff(int... doArgs, int y) { }</code>', 0),
(3, 'E','<code>static void doStuff(int x, int... doArgs) { }</code>', 1);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
4,
1,
'Given:
<code>1. enum Animals {
 2.   DOG("woof"), CAT("meow"), FISH("burble");
 3.   String sound;
 4.   Animals(String s) { sound = s; }
 5. }
 6. class TestEnum {
 7.   static Animals a;
 8.   public static void main(String[] args) {
 9.     System.out.println(a.DOG.sound + " " + a.FISH.sound);
10.   }
11. }</code>

What is the result?',
'✔ <b>A</b> is correct; enums can have constructors and variables.
❌ <b>B, C, D, E</b>, and <b>F</b> are incorrect; these lines all use correct syntax.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(4, 'A','<code>woof burble</code>', 1),
(4, 'B','Multiple compilation errors', 0),
(4, 'C','Compilation fails due to an error on line 2', 0),
(4, 'D','Compilation fails due to an error on line 3', 0),
(4, 'E','Compilation fails due to an error on line 4', 0),
(4, 'F','Compilation fails due to an error on line 9', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
5,
1,
'Given two files:
<code> 1. package pkgA;
 2. public class Foo {
 3.   int a = 5;
 4.   protected int b = 6;
 5.   public int c = 7;
 6. }

 3. package pkgB;
 4. import pkgA.*;
 5. public class Baz {
 6.   public static void main(String[] args) {
 7.     Foo f = new Foo();
 8.     System.out.print(" " + f.a);
 9.     System.out.print(" " + f.b);
10.     System.out.println(" " + f.c);
11.   }
12. }</code>

What is the result? (Choose all that apply.)',
'✔ <b>D</b> and <b>E</b> are correct. Variable a has default access, so it cannot be accessed from outside the package. Variable <code>b</code> has protected access in pkgA.
❌ <b>A, B, C,</b> and <b>F</b> are incorrect based on the above information.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(5, 'A','5 6 7', 0),
(5, 'B','5 followed by an exception', 0),
(5, 'C','Compilation fails with an error on line 7', 0),
(5, 'D','Compilation fails with an error on line 8', 1),
(5, 'E','Compilation fails with an error on line 9', 1),
(5, 'F','Compilation fails with an error on line 10', 0);

-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
6,
1,
'Given:
<code>1. public class Electronic implements Device
       { public void doIt() { } }
2.
3. abstract class Phone1 extends Electronic { }
4.
5. abstract class Phone2 extends Electronic
       { public void doIt(int x) { } }
6.
7. class Phone3 extends Electronic implements Device
       { public void doStuff() { } }
8.
9. interface Device { public void doIt(); }</code>

What is the result? (Choose all that apply.)',
'✔ <b>A</b> is correct; all of these are legal declarations.
❌ <b>B, C, D, E,</b> and <b>F</b> are incorrect based on the above information.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(6, 'A','Compilation succeeds', 1),
(6, 'B','Compilation fails with an error on line 1', 0),
(6, 'C','Compilation fails with an error on line 3', 0),
(6, 'D','Compilation fails with an error on line 5', 0),
(6, 'E','Compilation fails with an error on line 7', 0),
(6, 'F','Compilation fails with an error on line 9', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
7,
1,
'Given:
<code> 4. class Announce {
 5.   public static void main(String[] args) {
 6.     for(int __x = 0; __x &lt; 3; __x++) ;
 7.     int #lb = 7;
 8.     long [] x [5];
 9.     Boolean []ba[];
10.     enum Traffic { RED, YELLOW, GREEN };
11.   }
12. }</code>

What is the result? (Choose all that apply.)',
'✔ <b>C, D,</b> and <b>F</b> are correct. Variable names cannot begin with a #, an array declaration can''t include a size without an instantiation, and enums can''t be declared within a method.
❌ <b>A, B,</b> and <b>E</b> are incorrect based on the above information.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(7, 'A','Compilation succeeds', 0),
(7, 'B','Compilation fails with an error on line 6', 0),
(7, 'C','Compilation fails with an error on line 7', 1),
(7, 'D','Compilation fails with an error on line 8', 1),
(7, 'E','Compilation fails with an error on line 9', 0),
(7, 'F','Compilation fails with an error on line 10', 1);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
8,
1,
'Given:
<code> 3. public class TestDays {
 4.   public enum Days { MON, TUE, WED };
 5.   public static void main(String[] args) {
 6.     for(Days d : Days.values() )
 7.       ;
 8.     Days [] d2 = Days.values();
 9.     System.out.println(d2[2]);
10.   }
11. }</code>

What is the result? (Choose all that apply.)',
'✔ <b>B</b> is correct. Every enum comes with a <code>static values()</code> method that returns an array of the enum''s values, in the order in which they are declared in the enum.
❌ <b>A, C, D, E, F,</b> and <b>G</b> are incorrect based on the above information.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(8, 'A','<code>TUE</code>', 0),
(8, 'B','<code>WED</code>', 1),
(8, 'C','The output is unpredictable', 0),
(8, 'D','Compilation fails with an error on line 4', 0),
(8, 'E','Compilation fails with an error on line 6', 0),
(8, 'F','Compilation fails with an error on line 8', 0),
(8, 'G','Compilation fails with an error on line 9', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
9,
1,
'Given:
<code> 4. public class Frodo extends Hobbit {
 5.   public static void main(String[] args) {
 6.     Short myGold = 7;
 7.     System.out.println(countGold(myGold, 6));
 8.   }
 9. }
10. class Hobbit {
11.   int countGold(int x, int y) { return x + y; }
12. }</code>

What is the result? (Choose all that apply.)',
'✔ <b>D</b> is correct. The Short <code>myGold</code> is autoboxed correctly, but the <code>countGold()</code> method cannot be invoked from a static context.
❌ <b>A, B, C,</b> and <b>E</b> are incorrect based on the above information.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(9, 'A','13', 0),
(9, 'B','Compilation fails due to multiple errors', 0),
(9, 'C','Compilation fails with an error on line 6', 0),
(9, 'D','Compilation fails with an error on line 7', 1),
(9, 'E','Compilation fails with an error on line 11', 0);


-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back


