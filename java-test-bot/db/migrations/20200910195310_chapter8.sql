-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied

-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
91,
8,
'Which are true about a static nested class? (Choose all that apply.)',
'✔ <b>B</b> and <b>D</b>. B is correct because a static nested class is not tied to an instance of the enclosing class, and thus can''t access the non-static members of the class (just as a <code>static</code> method can''t access non-static members of a class). <b>D</b> uses the correct syntax for instantiating a static nested class.
❌ <b>A</b> is incorrect because static nested classes do not need (and can''t use) a reference to an instance of the enclosing class. <b>C</b> is incorrect because static nested classes can declare and define non-static members. <b>E</b> is wrong because...it just is. There''s no rule that says an inner or nested class has to extend anything.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(91, 'A', 'You must have a reference to an instance of the enclosing class in order to instantiate it', 0),
(91, 'B', 'It does not have access to <code>non-static</code> members of the enclosing class', 1),
(91, 'C', 'Its variables and methods must be <code>static</code>', 0),
(91, 'D', 'If the outer class is named <code>MyOuter</code>, and the nested class is named MyInner, it can be instantiated using <code>new MyOuter.MyInner();</code>', 1),
(91, 'E', 'It must extend the enclosing class', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
92,
8,
'Given:
<code>class Boo {
  Boo(String s) { }
  Boo() { }
}
class Bar extends Boo {
  Bar() { }
  Bar(String s) {super(s);}
  void zoo() {
  // insert code here
  }
}</code>

Which create an anonymous inner class from within class Bar? (Choose all that apply.)',
'✔ <b>B</b> and <b>C</b>. B is correct because anonymous inner classes are no different from any other class when it comes to polymorphism. That means you are always allowed to declare a reference variable of the superclass type and have that reference variable refer to an instance of a subclass type, which in this case is an anonymous subclass of Bar. Since Bar is a subclass of Boo, it all works. <b>C</b> uses correct syntax for creating an instance of Boo.
❌ <b>A</b> is incorrect because it passes an int to the Boo constructor, and there is no matching constructor in the Boo class. <b>D</b> is incorrect because it violates the rules of polymorphism; you cannot refer to a superclass type using a reference variable declared as the subclass type. The superclass doesn''t have everything the subclass has. <b>E</b> uses incorrect syntax.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(92, 'A', '<code>Boo f = new Boo(24) { };</code>', 0),
(92, 'B', '<code>Boo f = new Bar() { };</code>', 1),
(92, 'C', '<code>Boo f = new Boo() {String s; };</code>', 1),
(92, 'D', '<code>Bar f = new Boo(String s) { };</code>', 0),
(92, 'E', '<code>Bar f = new Boo(String s) { };</code>', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
93,
8,
'Which are true about a method-local inner class? (Choose all that apply.)',
'✔ <b>B</b> and <b>E</b>. <b>B</b> is correct because a method-local inner class can be abstract, although it means a subclass of the inner class must be created if the abstract class is to be used (so an abstract method-local inner class is probably not useful). <b>E</b> is correct because a method-local inner class works like any other inner class—it has a special relationship to an instance of the enclosing class, thus it can access all members of the enclosing class.
❌ <b>A</b> is incorrect because a method-local inner class does not have to be declared final (although it is legal to do so). <b>C</b> and <b>D</b> are incorrect because a method-local inner class cannot be made public (remember—local variables can''t be public) or static.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(93, 'A', 'It must be marked <code>final</code>', 0),
(93, 'B', 'It can be marked <code>abstract</code>', 1),
(93, 'C', 'It can be marked <code>public</code>', 0),
(93, 'D', 'It can be marked <code>static</code>', 0),
(93, 'E', 'It can access private members of the enclosing class', 1);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
94,
8,
'Given:
<code> 1. public class TestObj {
 2.   public static void main(String[] args) {
 3.     Object o = new Object() {
 4.       public boolean equals(Object obj) {
 5.         return true;
 6.       }
 7.     }
 8.     System.out.println(o.equals("Fred"));
 9.   }
10. }
</code>

What is the result?',
'✔ <b>G</b>. This code would be legal if line 7 ended with a semicolon. Remember that line 3 is a statement that doesn''t end until line 7, and a statement needs a closing semicolon!
❌ <b>A, B, C, D, E,</b> and <b>F</b> are incorrect based on the program logic described above. If the semicolon were added at line 7, then answer <b>B</b> would be correct—the program would print true, the return from the equals() method overridden by the anonymous subclass of Object.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(94, 'A', 'An exception occurs at runtime', 0),
(94, 'B', '<code>true</code>', 0),
(94, 'C', '<code>fred</code>', 0),
(94, 'D', 'Compilation fails because of an error on line 3', 0),
(94, 'E', 'Compilation fails because of an error on line 4', 0),
(94, 'F', 'Compilation fails because of an error on line 8', 0),
(94, 'G', 'Compilation fails because of an error on a line other than 3, 4, or 8', 1);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
95,
8,
'Given:
<code> 1. public class HorseTest {
 2.   public static void main(String[] args) {
 3.     class Horse {
 4.       public String name;
 5.       public Horse(String s) {
 6.         name = s;
 7.       }
 8.     }
 9.     Object obj = new Horse("Zippo");
10.     System.out.println(obj.name);
11.   }
12. }</code>

What is the result?',
'✔ <b>E</b>. If you use a reference variable of type Object, you can access only those members defined in class <code>Object</code>.
❌ <b>A, B, C,</b> and <b>D</b> are incorrect based on the program logic described above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(95, 'A', 'An exception occurs at runtime at line 10', 0),
(95, 'B', '<code>Zippo</code>', 0),
(95, 'C', 'Compilation fails because of an error on line 3', 0),
(95, 'D', 'Compilation fails because of an error on line 9', 0),
(95, 'E', 'Compilation fails because of an error on line 10', 1);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
96,
8,
'Given:
<code>public abstract class AbstractTest {
  public int getNum() {
    return 45;
  }
  public abstract class Bar {
    public int getNum() {
      return 38;
    }
  }
  public static void main(String[] args) {
    AbstractTest t = new AbstractTest() {
      public int getNum() {
        return 22;
      }
    };
    AbstractTest.Bar f = t.new Bar() {
      public int getNum() {
        return 57;
      }
    };
    System.out.println(f.getNum() + " " + t.getNum());
} }</code>

What is the result?',
'✔ <b>A</b>. You can define an inner class as <code>abstract</code>, which means you can instantiate only concrete subclasses of the abstract inner class. The object referenced by the variable <code>t</code> is an instance of an anonymous subclass of AbstractTest, and the anonymous class overrides the <code>getNum()</code> method to return 22. The variable referenced by f is an instance of an anonymous subclass of Bar, and the anonymous Bar subclass also overrides the <code>getNum()</code> method (to return 57). Remember that to create a <code>Bar</code> instance, we need an instance of the enclosing AbstractTest class to tie to the new <code>Bar</code> inner class instance. AbstractTest can''t be instantiated because it''s <code>abstract</code>, so we created an anonymous subclass (non-<code>abstract</code>) and then used the instance of that anonymous subclass to tie to the new Bar subclass instance.
❌ <b>B, C, D,</b> and <b>E</b> are incorrect based on the program logic described above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(96, 'A', '<code>57 22</code>', 1),
(96, 'B', '<code>45 38</code>', 0),
(96, 'C', '<code>45 57</code>', 0),
(96, 'D', 'An exception occurs at runtime', 0),
(96, 'E', 'Compilation fails', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
97,
8,
'Given:
<code> 3. public class Tour {
 4.   public static void main(String[] args) {
 5.     Cathedral c = new Cathedral();
 6.     // insert code here
 7.     s.go();
 8.   }
 9. }
10. class Cathedral {
11.   class Sanctum {
12.     void go() { System.out.println("spooky"); }
13.   }
14. }</code>

Which, inserted independently at line 6, compile and produce the output "spooky"? (Choose all that apply.)',
'✔ <b>D</b> is correct. It is the only code that uses the correct inner class instantiation syntax.
❌ <b>A, B, C,</b> and <b>E</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(97, 'A', '<code>Sanctum s = c.new Sanctum();</code>', 0),
(97, 'B', '<code>c.Sanctum s = c.new Sanctum();</code>', 0),
(97, 'C', '<code>c.Sanctum s = Cathedral.new Sanctum();</code>', 0),
(97, 'D', '<code>Cathedral.Sanctum s = c.new Sanctum();</code>', 1),
(97, 'E', '<code>Cathedral.Sanctum s = Cathedral.new Sanctum();</code>', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
98,
8,
'Given:
<code> 5. class A { void m() { System.out.println("outer"); } }
 6.
 7. public class TestInners {
 8.   public static void main(String[] args) {
 9.     new TestInners().go();
10.   }
11.   void go() {
12.     new A().m();
13.     class A { void m() { System.out.println("inner"); } }
14.   }
15.   class A { void m() { System.out.println("middle"); } }
16. }</code>

What is the result?',
'✔ <b>C</b> is correct. The "<code>inner</code>" version of <code>class A</code> isn''t used because its declaration comes after the instance of <code>class A</code> is created in the <code>go()</code> method.
❌ <b>A, B, D,</b> and <b>E</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(98, 'A', '<code>inner</code>', 0),
(98, 'B', '<code>outer</code>', 0),
(98, 'C', '<code>middle</code>', 1),
(98, 'D', 'Compilation fails', 0),
(98, 'E', 'An exception is thrown at runtime', 0);

-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
99,
8,
'Given:
<code> 3. public class Car {
 4.   class Engine {
 5.     // insert code here
 6.   }
 7.   public static void main(String[] args) {
 8.     new Car().go();
 9.   }
10.   void go() {
11.     new Engine();
12.   }
13.   void drive() { System.out.println("hi"); }
14. }</code>

Which, inserted independently at line 5, produce the output "hi"? (Choose all that apply.)',
'✔ <b>C</b> and <b>G</b> are correct. <b>C</b> is the correct syntax to access an inner class''s outer instance method from an initialization block, and <b>G</b> is the correct syntax to access it from a constructor.
❌ <b>A, B, D, E,</b> and <b>F</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(99, 'A', '<code>{ Car.drive(); }</code>', 0),
(99, 'B', '<code>{ this.drive(); }</code>', 0),
(99, 'C', '<code>{ Car.this.drive(); }</code>', 1),
(99, 'D', '<code>{ this.Car.this.drive(); }</code>', 0),
(99, 'E', '<code>Engine() { Car.drive(); }</code>', 0),
(99, 'F', '<code>Engine() { this.drive(); }</code>', 0),
(99, 'G', '<code>Engine() { Car.this.drive(); }</code>', 1);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
100,
8,
'Given:
<code> 3. public class City {
 4.   class Manhattan {
 5.     void doStuff() throws Exception { System.out.print("x "); }
 6.   }
 7.   class TimesSquare extends Manhattan {
 8.     void doStuff() throws Exception { }
 9.   }
10.   public static void main(String[] args) throws Exception {
11.     new City().go();
12.   }
13.   void go() throws Exception { new TimesSquare().doStuff(); }
14. }</code>

What is the result?',
'✔ <b>C</b> is correct. The inner classes are valid, and all the methods (including <code>main()</code>), correctly throw an Exception, given that <code>doStuff()</code> throws an Exception. The <code>doStuff()</code> in class <code>TimesSquare</code> overrides class <code>Manhattan''</code>s <code>doStuff()</code> and produces no output.
❌ <b>A, B, D, E, F, G,</b> and <b>H</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(100, 'A', '<code>x</code>', 0),
(100, 'B', '<code>x x</code>', 0),
(100, 'C', 'No output is produced', 1),
(100, 'D', 'Compilation fails due to multiple errors', 0),
(100, 'E', 'Compilation fails due only to an error on line 4', 0),
(100, 'F', 'Compilation fails due only to an error on line 7', 0),
(100, 'G', 'Compilation fails due only to an error on line 10', 0),
(100, 'H', 'Compilation fails due only to an error on line 13', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
101,
8,
'Given:
<code> 3. public class Navel {
 4.   private int size = 7;
 5.   private static int length = 3;
 6.   public static void main(String[] args) {
 7.     new Navel().go();
 8.   }
 9.   void go() {
10.     int size = 5;
11.     System.out.println(new Gazer().adder());
12.   }
13.   class Gazer {
14.     int adder() { return size * length; }
15.   }
16. }</code>

What is the result?',
'✔ <b>B</b> is correct. The inner class Gazer has access to Navel''s private static and private instance variables.
❌ <b>A, C, D, E,</b> and <b>F</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(101, 'A', '<code>15</code>', 0),
(101, 'B', '<code>21</code>', 1),
(101, 'C', 'An exception is thrown at runtime', 0),
(101, 'D', 'Compilation fails due to multiple errors', 0),
(101, 'E', 'Compilation fails due only to an error on line 4', 0),
(101, 'F', 'Compilation fails due only to an error on line 5', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
102,
8,
'Given:
<code> 3. import java.util.*;
 4. public class Pockets {
 5.   public static void main(String[] args) {
 6.     String[] sa = {"nickel", "button", "key", "lint"};
 7.     Sorter s = new Sorter();
 8.     for(String s2: sa) System.out.print(s2 + " ");
 9.     Arrays.sort(sa,s);
10.     System.out.println();
11.     for(String s2: sa) System.out.print(s2 + " ");
12.   }
13.   class Sorter implements Comparator&lt;String&gt; {
14.     public int compare(String a, String b) {
15.       return b.compareTo(a);
16.     }
17.   }
18. }</code>

What is the result?',
'✔ <b>A</b> is correct, the inner class <code>Sorter</code> must be declared <code>static</code> to be called from the <code>static</code> method <code>main()</code>. If <code>Sorter</code> had been <code>static</code>, answer E would be correct.
❌ <b>B, C, D, E,</b> and <b>F</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(102, 'A', 'Compilation fails', 1),
(102, 'B',
'<code>button key lint nickel
   nickel lint key button</code>', 0),
(102, 'C',
'<code>nickel button key lint
   button key lint nickel</code>', 0),
(102, 'D', '<code>nickel button key lint
   nickel button key lint</code>', 0),
(102, 'E', '<code>nickel button key lint
   nickel lint key button</code>', 0),
(102, 'F', 'An exception is thrown at runtime', 0);


-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
