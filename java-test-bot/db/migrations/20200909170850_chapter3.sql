-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied

-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
24,
3,
'Given:
<code>class CardBoard {
  Short story = 200;
  CardBoard go(CardBoard cb) {
    cb = null;
    return cb;
  }
  public static void main(String[] args) {
    CardBoard c1 = new CardBoard();
    CardBoard c2 = new CardBoard();
    CardBoard c3 = c1.go(c2);
    c1 = null;
    // do Stuff
} }</code>

When <code>// doStuff</code> is reached, how many objects are eligible for GC?',
'✔ <b>C</b> is correct. Only one <code>CardBoard object (c1)</code> is eligible, but it has an associated Short wrapper object that is also eligible.
❌ <b>A, B, D, E,</b> and <b>F</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(24, 'A','0', 0),
(24, 'B','1', 0),
(24, 'C','2', 1),
(24, 'D','Compilation fails', 0),
(24, 'E','It is not possible to know', 0),
(24, 'F','An exception is thrown at runtime', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
25,
3,
'Given:
<code>class Alien {
  String invade(short ships) { return "a few"; }
  String invade(short... ships) { return "many"; }
}
class Defender {
  public static void main(String [] args) {
    System.out.println(new Alien().invade(7));
} }</code>

What is the result?',
'✔ <b>C</b> is correct, compilation fails. The var-args declaration is fine, but invade takes a short, so the argument 7 needs to be cast to a short. With the cast, the answer is B, ''a few''.
❌ <b>A, B, D,</b> and <b>E</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(25, 'A','<code>many</code>', 0),
(25, 'B','<code>a few</code>', 0),
(25, 'C','Compilation fails', 1),
(25, 'D','The output is not predictable', 0),
(25, 'E','An exception is thrown at runtime', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
26,
3,
'Given:
<code>1. class Dims {
2.   public static void main(String[] args) {
3.     int[][] a = {{1,2,}, {3,4}};
4.     int[] b = (int[]) a[1];
5.     Object o1 = a;
6.     int[][] a2 = (int[][]) o1;
7.     int[] b2 = (int[]) o1;
8.     System.out.println(b[1]);
9. } }</code>

What is the result?',
'✔ <b>C</b> is correct. A <code>ClassCastException</code> is thrown at line 7 because <code>o1</code> refers to an <code>int[][]</code> not an <code>int[]</code>. If line 7 was removed, the output would be 4.
❌ <b>A, B, D, E, F,</b> and <b>G</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(26, 'A','2', 0),
(26, 'B','4', 0),
(26, 'C','An exception is thrown at runtime', 1),
(26, 'D','Compilation fails due to an error on line 4', 0),
(26, 'E','Compilation fails due to an error on line 5', 0),
(26, 'F','Compilation fails due to an error on line 6', 0),
(26, 'G','Compilation fails due to an error on line 7', 0);

-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
27,
3,
'Given:
<code>class Mixer {
  Mixer() { }
  Mixer(Mixer m) { m1 = m; }
  Mixer m1;
  public static void main(String[] args) {
    Mixer m2 = new Mixer();
    Mixer m3 = new Mixer(m2); m3.go();
    Mixer m4 = m3.m1; m4.go();
    Mixer m5 = m2.m1; m5.go();
  }
  void go() { System.out.print("hi "); }
}</code>

What is the result?',
'✔ <b>F</b> is correct. The <code>m2</code> object’s m1 instance variable is never initialized, so when m5 tries to use it a <code>NullPointerException</code> is thrown.
❌ <b>A, B, C, D,</b> and <b>E</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(27, 'A','<code>hi</code>', 0),
(27, 'B','<code>hi hi</code>', 0),
(27, 'C','<code>hi hi hi</code>', 0),
(27, 'D','Compilation fails', 0),
(27, 'E','<code>hi</code>, followed by an exception', 0),
(27, 'F','<code>hi hi</code>, followed by an exception', 1);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
28,
3,
'Given:
<code>class Fizz {
  int x = 5;
  public static void main(String[] args) {
    final Fizz f1 = new Fizz();
    Fizz f2 = new Fizz();
    Fizz f3 = FizzSwitch(f1,f2);
    System.out.println((f1 == f3) + " " + (f1.x == f3.x));
  }
  static Fizz FizzSwitch(Fizz x, Fizz y) {
    final Fizz z = x;
    z.x = 6;
    return z;
} }</code>

What is the result?',
'✔ <b>A</b> is correct. The references <code>f1</code>, <code>z</code>, and <code>f3</code> all refer to the same instance of Fizz. The final modifier assures that a reference variable cannot be referred to a different object, but final doesn''t keep the object''s state from changing.
❌ <b>B, C, D, E,</b> and <b>F</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(28, 'A','<code>true true</code>', 1),
(28, 'B','<code>false true</code>', 0),
(28, 'C','<code>true false</code>', 0),
(28, 'D','<code>false false</code>', 0),
(28, 'E','Compilation fails', 0),
(28, 'F','An exception is thrown at runtime', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
29,
3,
'Given:
<code>class Bird {
  { System.out.print("b1 "); }
  public Bird() { System.out.print("b2 "); }
}
class Raptor extends Bird {
  static { System.out.print("r1 "); }
  public Raptor() { System.out.print("r2 "); }
  { System.out.print("r3 "); }
  static { System.out.print("r4 "); }
}
class Hawk extends Raptor {
  public static void main(String[] args) {
    System.out.print("pre ");
    new Hawk();
    System.out.println("hawk ");
  }
}</code>

What is the result?',
'✔ <b>D</b> is correct. Static init blocks are executed at class loading time, instance init blocks run right after the call to <code>super()</code> in a constructor. When multiple init blocks of a single type occur in a class, they run in order, from the top down.
❌ <b>A, B, C, E, F, G, H,</b> and <b>I</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(29, 'A','<code>pre b1 b2 r3 r2 hawk</code>', 0),
(29, 'B','<code>pre b2 b1 r2 r3 hawk</code>', 0),
(29, 'C','<code>pre b2 b1 r2 r3 hawk r1 r4</code>', 0),
(29, 'D','<code>r1 r4 pre b1 b2 r3 r2 hawk</code>', 1),
(29, 'E','<code>r1 r4 pre b2 b1 r2 r3 hawk</code>', 0),
(29, 'F','<code>pre r1 r4 b1 b2 r3 r2 hawk</code>', 0),
(29, 'G','<code>pre r1 r4 b2 b1 r2 r3 hawk</code>', 0),
(29, 'H','The order of output cannot be predicted', 0),
(29, 'I','Compilation fails', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
30,
3,
'Given:
<code> 3. public class Bridge {
 4.   public enum Suits {
 5.     CLUBS(20), DIAMONDS(20), HEARTS(30), SPADES(30),
 6.     NOTRUMP(40) { public int getValue(int bid) {
                        return ((bid-1)*30)+40; } };
 7.     Suits(int points) { this.points = points; }
 8.     private int points;
 9.     public int getValue(int bid) { return points * bid; }
10.   }
11.   public static void main(String[] args) {
12.     System.out.println(Suits.NOTRUMP.getBidValue(3));
13.     System.out.println(Suits.SPADES + " " + Suits.SPADES.points);
14.     System.out.println(Suits.values());
15.   }
16. }</code>

Which are true? (Choose all that apply.)',
'✔ <b>A</b> and <b>B</b> are correct. The code compiles and runs without exception. The <code>values()</code> method returns an array reference, not the contents of the enum, so DIAMONDS is never printed.
❌ <b>C, D, E, F, G,</b> and <b>H</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(30, 'A','The output could contain <code>30</code>', 1),
(30, 'B','The output could contain <code>@bf73fa</code>', 1),
(30, 'C','The output could contain <code>DIAMONDS</code>', 0),
(30, 'D','Compilation fails due to an error on line 6', 0),
(30, 'E','Compilation fails due to an error on line 7', 0),
(30, 'F','Compilation fails due to an error on line 8', 0),
(30, 'G','Compilation fails due to an error on line 9', 0),
(30, 'H','Compilation fails due to an error within lines 12 to 14', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
31,
3,
'Given:
<code> 3. public class Ouch {
 4.   static int ouch = 7;
 5.   public static void main(String[] args) {
 6.     new Ouch().go(ouch);
 7.     System.out.print(" " + ouch);
 8.   }
 9.   void go(int ouch) {
10.     ouch++;
11.     for(int ouch = 3; ouch &lt; 6; ouch++)
12.       ;
13.     System.out.print(" " + ouch);
14.   }
15. }</code>

What is the result?',
'✔ <b>E</b> is correct. The parameter declared on line 9 is valid (although ugly), but the variable name ouch cannot be declared again on line 11 in the same scope as the declaration on line 9.
❌ <b>A, B, C, D,</b> and <b>F</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(31, 'A','<code>5 7</code>', 0),
(31, 'B','<code>5 8</code>', 0),
(31, 'C','<code>8 7</code>', 0),
(31, 'D','<code>8 8</code>', 0),
(31, 'E','Compilation fails', 1),
(31, 'F','An exception is thrown at runtime', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
32,
3,
'Given:
<code> 3. public class Bertha {
 4.   static String s = "";
 5.   public static void main(String[] args) {
 6.     int x = 4; Boolean y = true; short[] sa = {1,2,3};
 7.     doStuff(x, y);
 8.     doStuff(x);
 9.     doStuff(sa, sa);
10.     System.out.println(s);
11.   }
12.   static void doStuff(Object o) { s += "1"; }
13.   static void doStuff(Object... o) { s += "2"; }
14.   static void doStuff(Integer... i) { s += "3"; }
15.   static void doStuff(Long L) { s += "4"; }
16. }</code>

What is the result?',
'✔ A is correct. It''s legal to autobox and then widen. The first call to <code>doStuff()</code> boxes the int to an Integer then passes two objects. The second call cannot widen and then box (making the <code>Long</code> method unusable), so it boxes the int to an Integer. As always, a var-args method will be chosen only if no non-var-arg method is possible. The third call is passing two objects—they are of type ''short array.''
❌ <b>B, C, D, E, F,</b> and <b>G</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(32, 'A','<code>212</code>', 1),
(32, 'B','<code>232</code>', 0),
(32, 'C','<code>234</code>', 0),
(32, 'D','<code>312</code>', 0),
(32, 'E','<code>332</code>', 0),
(32, 'F','<code>334</code>', 0),
(32, 'G','Compilation fails', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
33,
3,
'Given:
<code> 3. class Dozens {
 4.   int[] dz = {1,2,3,4,5,6,7,8,9,10,11,12};
 5. }
 6. public class Eggs {
 7.   public static void main(String[] args) {
 8.     Dozens [] da = new Dozens[3];
 9.     da[0] = new Dozens();
10.     Dozens d = new Dozens();
11.     da[1] = d;
12.     d = null;
13.     da[1] = null;
14.     // do stuff
15.   }
16. }</code>

Which two are true about the objects created within <code>main()</code>, and eligible for garbage collection when line 14 is reached?',
'✔ C and F are correct. da refers to an object of type "Dozens array," and each Dozens object
   that is created comes with its own "int array" object. When line 14 is reached, only the
   second Dozens object (and its "int array" object) are not reachable.
❌ <b>A, B, D, E,</b> and <b>G</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(33, 'A','Three objects were created', 0),
(33, 'B','Four objects were created', 0),
(33, 'C','Five objects were created', 1),
(33, 'D','Zero objects are eligible for GC', 0),
(33, 'E','One object is eligible for GC', 0),
(33, 'F','Two objects are eligible for GC', 1),
(33, 'G','Three objects are eligible for GC', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
34,
3,
'Given:
<code> 3. class Beta { }
 4. class Alpha {
 5.   static Beta b1;
 6.   Beta b2;
 7. }
 8. public class Tester {
 9.   public static void main(String[] args) {
10.     Beta b1 = new Beta(); Beta b2 = new Beta();
11.     Alpha a1 = new Alpha(); Alpha a2 = new Alpha();
12.     a1.b1 = b1;
13.     a1.b2 = b1;
14.     a2.b2 = b2;
15.     a1 = null; b1 = null; b2 = null;
16.     // do stuff
17.   }
18. }</code>

When line 16 is reached, how many objects will be eligible for garbage collection?',
'✔ <b>B</b> is correct. It should be clear that there is still a reference to the object referred to by <code>a2</code>, and that there is still a reference to the object referred to by <code>a2.b2</code>. What might be less clear is that you can still access the other Beta object through the static variable <code>a2.b1</code>—because it''s static.
❌ <b>A, C, D, E,</b> and <b>F</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(34, 'A','0', 0),
(34, 'B','1', 1),
(34, 'C','2', 0),
(34, 'D','3', 0),
(34, 'E','4', 0),
(34, 'F','5', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
35,
3,
'Given:
<code> 3. class Box {
 4.   int size;
 5.   Box(int s) { size = s; }
 6. }
 7. public class Laser {
 8.   public static void main(String[] args) {
 9.     Box b1 = new Box(5);
10.     Box[] ba = go(b1, new Box(6));
11.     ba[0] = b1;
12.     for(Box b : ba) System.out.print(b.size + " ");
13.   }
14.   static Box[] go(Box b1, Box b2) {
15.     b1.size = 4;
16.     Box[] ma = {b2, b1};
17.     return ma;
18.   }
19. }</code>

What is the result?',
'✔ <b>A</b> is correct. Although <code>main()</code>''s <code>b1</code> is a different reference variable than <code>go()</code>''s b1, they refer to the same Box object.
❌ <b>B, C, D, E,</b> and <b>F</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(35, 'A','<code>4 4</code>', 1),
(35, 'B','<code>5 4</code>', 0),
(35, 'C','<code>6 4</code>', 0),
(35, 'D','<code>4 5</code>', 0),
(35, 'E','<code>5 5</code>', 0),
(35, 'F','Compilation fails', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
36,
3,
'Given:
<code> 3. public class Dark {
 4.   int x = 3;
 5.   public static void main(String[] args) {
 6.     new Dark().go1();
 7.   }
 8.   void go1() {
 9.     int x;
10.     go2(++x);
11.   }
12.   void go2(int y) {
13.     int x = ++y;
14.     System.out.println(x);
15.   }
16. }</code>

What is the result?',
'✔ <b>E</b> is correct. In <code>go1()</code> the local variable <code>x</code> is not initialized.
❌ <b>A, B, C, D,</b> and <b>F</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(36, 'A','2', 0),
(36, 'B','3', 0),
(36, 'C','4', 0),
(36, 'D','5', 0),
(36, 'E','Compilation fails', 1),
(36, 'F','An exception is thrown at runtime', 0);


-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
