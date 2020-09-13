-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied

-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
75,
7,
'Given:
<code>public static void main(String[] args) {
  // INSERT DECLARATION HERE
  for (int i = 0; i &lt;= 10; i++) {
    List&lt;Integer&gt; row = new ArrayList&lt;Integer&gt;();
    for (int j = 0; j &lt;= 10; j++)
      row.add(i * j);
    table.add(row);
  }
  for (List&lt;Integer&gt; row : table)
    System.out.println(row);
  }</code>

Which statements could be inserted at <code>// INSERT DECLARATION HERE</code> to allow this code to compile and run? (Choose all that apply.)',
'✔ <b>B</b> is correct.
❌ <b>A</b> is incorrect because List is an interface, so you can''t say new <code>List()</code> regardless of any generic types. <b>D, E,</b> and <b>F</b> are incorrect because List only takes one type parameter (a Map would take two, not a List). <b>C</b> is tempting, but incorrect. The type argument <code><List&lt;Integer&gt;></code> must be the same for both sides of the assignment, even though the constructor <code>new ArrayList()</code> on the right side is a subtype of the declared type List on the left.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(75, 'A', '<code>List&lt;List&lt;Integer&gt;&gt; table = new List&lt;List&lt;Integer&gt;&gt;();</code>', 0),
(75, 'B', '<code>List&lt;List&lt;Integer&gt;&gt; table = new ArrayList&lt;List&lt;Integer&gt;&gt;();</code>', 1),
(75, 'C', '<code>List&lt;List&lt;Integer&gt;&gt; table = new ArrayList&lt;ArrayList&lt;Integer&gt;&gt;();</code>', 0),
(75, 'D', '<code>List&lt;List, Integer&gt; table = new List&lt;List, Integer&gt;();</code>', 0),
(75, 'E', '<code>List&lt;List, Integer&gt; table = new ArrayList&lt;List, Integer&gt;();</code>', 0),
(75, 'F', '<code>List&lt;List, Integer&gt; table = new ArrayList&lt;ArrayList, Integer&gt;();</code>', 0),
(75, 'G', 'None of the above', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
76,
7,
'Which statements are true about comparing two instances of the same class, given that the <code>equals()</code> and <code>hashCode()</code> methods have been properly overridden? (Choose all that apply.)',
'✔ <b>B</b> and <b>D</b>. <b>B</b> is true because often two dissimilar objects can return the same hashcode value. <b>D</b> is true because if the <code>hashCode()</code> comparison returns ==, the two objects might or might not be equal.
❌ <b>A, C,</b> and <b>E</b> are incorrect. <b>C</b> is incorrect because the <code>hashCode()</code> method is very flexible in its return values, and often two dissimilar objects can return the same hash code value. <b>A</b> and <b>E</b> are a negation of the <code>hashCode()</code> and <code>equals()</code> contract.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(76, 'A', 'If the <code>equals()</code> method returns true, the <code>hashCode()</code> comparison == might return false', 0),
(76, 'B', 'If the <code>equals()</code> method returns false, the hashCode() comparison == might return true', 1),
(76, 'C', 'If the <code>hashCode()</code> comparison == returns true, the <code>equals()</code> method must return true', 0),
(76, 'D', 'If the <code>hashCode()</code> comparison == returns true, the <code>equals()</code> method might return true', 1),
(76, 'E', 'If the <code>hashCode()</code> comparison != returns true, the <code>equals()</code> method might return true', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
77,
7,
'Given:
<code>public static void before() {
  Set set = new TreeSet();
  set.add("2");
  set.add(3);
  set.add("1");
  Iterator it = set.iterator();
    while (it.hasNext())
  System.out.print(it.next() + " ");
}</code>

Which statements are true?',
'✔ <b>E</b> is correct. You can''t put both Strings and ints into the same TreeSet. Without generics, the compiler has no way of knowing what type is appropriate for this TreeSet, so it allows everything to compile. At runtime, the TreeSet will try to sort the elements as they''re added, and when it tries to compare an Integer with a String it will throw a ClassCastException. Note that although the <code>before()</code> method does not use generics, it does use autoboxing. Watch out for code that uses some new features and some old features mixed together.
❌ <b>A, B, C,</b> and <b>D</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(77, 'A', 'The <code>before()</code> method will print <code>1 2</code>', 0),
(77, 'B', 'The <code>before()</code> method will print <code>1 2 3</code>', 0),
(77, 'C', 'The <code>before()</code> method will print three numbers, but the order cannot be determined', 0),
(77, 'D', 'The <code>before()</code> method will not compile', 0),
(77, 'E', 'The <code>before()</code> method will throw an exception at runtime', 1);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
78,
7,
'Given:
<code>import java.util.*;
class MapEQ {
  public static void main(String[] args) {
    Map&lt;ToDos, String&gt; m = new HashMap&lt;ToDos, String&gt;();
    ToDos t1 = new ToDos("Monday");
    ToDos t2 = new ToDos("Monday");
    ToDos t3 = new ToDos("Tuesday");
    m.put(t1, "doLaundry");
    m.put(t2, "payBills");
    m.put(t3, "cleanAttic");
    System.out.println(m.size());
} }
class ToDos{
  String day;
  ToDos(String d) { day = d; }
  public boolean equals(Object o) {
    return ((ToDos)o).day == this.day;
  }
  // public int hashCode() { return 9; }
}</code>

Which is correct? (Choose all that apply.)',
'✔ <b>C</b> and <b>D</b> are correct. If <code>hashCode()</code> is not overridden then every entry will go into its own bucket, and the overridden <code>equals()</code> method will have no effect on determining equivalency. If <code>hashCode()</code> is overridden, then the overridden <code>equals()</code> method will view <code>t1</code> and <code>t2</code> as duplicates.
❌ <b>A, B, E,</b> and <b>F</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(78, 'A', 'As the code stands it will not compile', 0),
(78, 'B', 'As the code stands the output will be 2', 0),
(78, 'C', 'As the code stands the output will be 3', 1),
(78, 'D', 'If the hashCode() method is uncommented the output will be 2', 1),
(78, 'E', 'If the hashCode() method is uncommented the output will be 3', 0),
(78, 'F', 'If the hashCode() method is uncommented the code will not compile', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
79,
7,
'Given:
<code>12. public class AccountManager {
13.   private Map accountTotals = new HashMap();
14.   private int retirementFund;
15.
16.   public int getBalance(String accountName) {
17.     Integer total = (Integer) accountTotals.get(accountName);
18.     if (total == null)
19.       total = Integer.valueOf(0);
20.     return total.intValue();
21.   }
23.   public void setBalance(String accountName, int amount) {
24.     accountTotals.put(accountName, Integer.valueOf(amount));
25. } }</code>

This class is to be updated to make use of appropriate generic types, with no changes in behavior (for better or worse). Which of these steps could be performed? (Choose three.)',
'✔ <b>B, E,</b> and <b>G</b> are correct.
❌ <b>A</b> is wrong because you can''t use a primitive type as a type parameter. <b>C</b> is wrong because a Map takes two type parameters separated by a comma. <b>D</b> is wrong because an int can''t autobox to a null, and <b>F</b> is wrong because a null can''t unbox to 0. <b>H</b> is wrong because you can''t autobox a primitive just by trying to invoke a method with it.');
-- +goose StatementEnd

-- +goose StatementBegin
INSERT INTO answer (question_id, letter, answer, valid) VALUES
(79, 'A', 'Replace line 13 with
<code>private Map&lt;String, int&gt; accountTotals = new HashMap&lt;String, int&gt;();</code>', 0),
(79, 'B', 'Replace line 13 with
<code>private Map&lt;String, Integer&gt; accountTotals = new HashMap&lt;String, Integer&gt;();</code>', 1),
(79, 'C', 'Replace line 13 with
<code>private Map&lt;String&lt;Integer&gt;&gt; accountTotals = new HashMap&lt;String&lt;Integer&gt;&gt;();</code>', 0),
(79, 'D', 'Replace lines 17–20 with
<code>int total = accountTotals.get(accountName);
if (total == null) total = 0;
return total;</code>', 0),
(79, 'E', 'Replace lines 17–20 with
<code>Integer total = accountTotals.get(accountName);
if (total == null) total = 0;
return total;</code>', 1),
(79, 'F', 'Replace lines 17–20 with
<code>return accountTotals.get(accountName);</code>', 0),
(79, 'G', 'Replace line 24 with
<code>accountTotals.put(accountName, amount);</code>', 1),
(79, 'H', 'Replace line 24 with
<code>accountTotals.put(accountName, amount.intValue());</code>', 0);
-- +goose StatementEnd

-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
80,
7,
'Given:
<code>interface Hungry&lt;E&gt; { void munch(E x); }
interface Carnivore&lt;E extends Animal&gt; extends Hungry&lt;E&gt; {}
interface Herbivore&lt;E extends Plant&gt; extends Hungry&lt;E&gt; {}
abstract class Plant {}
class Grass extends Plant {}
abstract class Animal {}
class Sheep extends Animal implements Herbivore&lt;Sheep&gt; {
  public void munch(Sheep x) {}
}
class Wolf extends Animal implements Carnivore&lt;Sheep&gt; {
  public void munch(Sheep x) {}
}</code>

Which of the following changes (taken separately) would allow this code to compile? (Choose all that apply.)',
'✔ <b>B</b> is correct. The problem with the original code is that Sheep tries to implement <code>Herbivore&lt;Sheep&gt;</code> and Herbivore declares that its type parameter E can be any type that extends Plant. Since a Sheep is not a Plant, <code>Herbivore&lt;Sheep&gt;</code> makes no sense — the type Sheep is outside the allowed range of Herbivore''s parameter E. Only solutions that either alter the definition of a Sheep or alter the definition of Herbivore will be able to fix this. So <b>A, E,</b> and <b>F</b> are eliminated. <b>B</b> works, changing the definition of an Herbivore to allow it to eat Sheep solves the problem. <b>C</b> doesn''t work because an <code>Herbivore&lt;Plant&gt;</code> must have a <code>munch(Plant)</code> method, not <code>munch(Grass)</code>. And D doesn''t work, because in <b>D</b> we made Sheep extend Plant, now the Wolf class breaks because its munch(Sheep) method no longer fulfills the contract of Carnivore.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(80, 'A', 'Change the Carnivore interface to
<code>interface Carnivore&lt;E extends Plant&gt; extends Hungry&lt;E&gt; {}</code>', 0),
(80, 'B', 'Change the Herbivore interface to
<code>interface Herbivore&lt;E extends Animal&gt; extends Hungry&lt;E&gt; {}</code>', 1),
(80, 'C', 'Change the Sheep class to
<code>class Sheep extends Animal implements Herbivore&lt;Plant&gt; {
  public void munch(Grass x) {}
}</code>', 0),
(80, 'D', 'Change the Sheep class to
<code>class Sheep extends Plant implements Carnivore&lt;Wolf&gt; {
  public void munch(Wolf x) {}
}</code>', 0),
(80, 'E', 'Change the Wolf class to
<code>class Wolf extends Animal implements Herbivore&lt;Grass&gt; {
  public void munch(Grass x) {}
}</code>', 0),
(80, 'F', 'No changes are necessary', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
81,
7,
'Which collection class(es) allows you to grow or shrink its size and provides indexed access to its elements, but whose methods are not synchronized? (Choose all that apply.)',
'✔ <b>D</b> is correct. All of the collection classes allow you to grow or shrink the size of your collection.
<code>ArrayList</code> provides an index to its elements. The newer collection classes tend not to have synchronized methods. Vector is an older implementation of <code>ArrayList</code> functionality and has synchronized methods; it is slower than <code>ArrayList</code>.
❌ <b>A, B, C, E,</b> and <b>F</b> are incorrect based on the logic described above; Notes: <b>C</b>, <code>List</code> is an interface, and <b>F</b>, <code>PriorityQueue</code> does not offer access by index.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(81, 'A', '<code>java.util.HashSet</code>', 0),
(81, 'B', '<code>java.util.LinkedHashSet</code>', 0),
(81, 'C', '<code>java.util.List</code>', 0),
(81, 'D', '<code>java.util.ArrayList</code>', 1),
(81, 'E', '<code>java.util.Vector</code>', 0),
(81, 'F', '<code>java.util.PriorityQueue</code>', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
82,
7,
'Given a method declared as
<code>public static &lt;E extends Number&gt; List&lt;E&gt; process(List&lt;E&gt; nums)</code>
A programmer wants to use this method like this
<code>// INSERT DECLARATIONS HERE
output = process(input);</code>

Which pairs of declarations could be placed at <code>// INSERT DECLARATIONS HERE</code> to allow the code to compile? (Choose all that apply.)',
'✔ <b>B, E,</b> and <b>F</b> are correct.
❌ The return type of process is definitely declared as a <code>List</code>, not an <code>ArrayList</code>, so <b>A</b> and <b>D</b> are wrong. <b>C</b> is wrong because the return type evaluates to <code>List&lt;Integer&gt;</code>, and that can''t be assigned to a variable of type <code>List&lt;Number></code>. Of course all these would probably cause a <code>NullPointerException</code> since the variables are still null—but the question only asked us to get the code to compile.');
-- +goose StatementEnd

-- +goose StatementBegin
INSERT INTO answer (question_id, letter, answer, valid) VALUES
(82, 'A', '<code>ArrayList&lt;Integer&gt; input = null;
ArrayList&lt;Integer&gt; output = null;</code>', 0),
(82, 'B', '<code>ArrayList&lt;Integer&gt; input = null;
List&lt;Integer&gt; output = null;</code>', 1),
(82, 'C', '<code>ArrayList&lt;Integer&gt; input = null;
List&lt;Number> output = null;</code>', 0),
(82, 'D', '<code>List&lt;Number&gt; input = null;
ArrayList&lt;Integer&gt; output = null;</code>', 0),
(82, 'E', '<code>List&lt;Number&gt; input = null;
List&lt;Number> output = null;</code>', 1),
(82, 'F', '<code>List&lt;Integer&gt; input = null;
List&lt;Integer&gt; output = null;</code>', 1),
(82, 'G', 'None of the above', 1);
-- +goose StatementEnd


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
83,
7,
'Given the proper import statement(s), and
<code>13. PriorityQueue&lt;String&gt; pq = new PriorityQueue&lt;String&gt;();
14. pq.add("2");
15. pq.add("4");
16. System.out.print(pq.peek() + " ");
17. pq.offer("1");
18. pq.add("3");
19. pq.remove("1");
20. System.out.print(pq.poll() + " ");
21. if(pq.remove("2")) System.out.print(pq.poll() + " ");
22. System.out.println(pq.poll() + " " + pq.peek());</code>

What is the result?',
'✔ <b>B</b> is correct. For the sake of the exam, <code>add()</code> and <code>offer()</code> both add to (in this case), naturally sorted queues. The calls to <code>poll()</code> both return and then remove the first item from the queue, so the if test fails.
❌ <b>A, C, D, E, F, G,</b> and <b>H</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(83, 'A', '2 2 3 3', 0),
(83, 'B', '2 2 3 4', 1),
(83, 'C', '4 3 3 4', 0),
(83, 'D', '2 2 3 3 3', 0),
(83, 'E', '4 3 3 3 3', 0),
(83, 'F', '2 2 3 3 4', 0),
(83, 'G', 'Compilation fails', 0),
(83, 'H', 'An exception is thrown at runtime', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
84,
7,
'Given:
<code> 3. import java.util.*;
 4. public class Mixup {
 5.   public static void main(String[] args) {
 6.     Object o = new Object();
 7.     // insert code here
 8.     s.add("o");
 9.     s.add(o);
10.   }
11. }</code>

And these three fragments:
<code>I.   Set s = new HashSet();
II.  TreeSet s = new TreeSet();
III. LinkedHashSet s = new LinkedHashSet();</code>

When fragments I, II, or III are inserted, independently, at line 7, which are true? (Choose all that apply.)',
'✔ <b>A, B, C, D,</b> and <b>F</b> are all correct.
❌ Only <b>E</b> is incorrect. Elements of a <code>TreeSet</code> must in some way implement <code>Comparable</code>.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(84, 'A', 'Fragment I compiles', 1),
(84, 'B', 'Fragment II compiles', 1),
(84, 'C', 'Fragment III compiles', 1),
(84, 'D', 'Fragment I executes without exception', 1),
(84, 'E', 'Fragment II executes without exception', 0),
(84, 'F', 'Fragment III executes without exception', 1);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
85,
7,
'Given:
<code> 3. import java.util.*;
 4. class Turtle {
 5.   int size;
 6.   public Turtle(int s) { size = s; }
 7.   public boolean equals(Object o) { return (this.size == ((Turtle)o).size); }
 8.   // insert code here
 9. }
10. public class TurtleTest {
11.   public static void main(String[] args) {
12.     LinkedHashSet&lt;Turtle&gt; t = new LinkedHashSet&lt;Turtle&gt;();
13.     t.add(new Turtle(1)); t.add(new Turtle(2)); t.add(new Turtle(1));
14.     System.out.println(t.size());
15.   }
16. }</code>

And these two fragments:
<code>I.  public int hashCode() { return size/5; }
II. // no hashCode method declared</code>

If fragment I or II is inserted, independently, at line 8, which are true? (Choose all that apply.)',
'✔ <b>A</b> and <b>D</b> are correct. While fragment II wouldn''t fulfill the <code>hashCode()</code> contract (as you can see by the results), it is legal Java. For the purpose of the exam, if you don’t override <code>hashCode()</code>, every object will have a unique hashcode.
❌ <b>B, C, E,</b> and <b>F</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(85, 'A', 'If fragment I is inserted, the output is 2', 1),
(85, 'B', 'If fragment I is inserted, the output is 3', 0),
(85, 'C', 'If fragment II is inserted, the output is 2', 0),
(85, 'D', 'If fragment II is inserted, the output is 3', 1),
(85, 'E', 'If fragment I is inserted, compilation fails', 0),
(85, 'F', 'If fragment II is inserted, compilation fails', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
86,
7,
'Given the proper import statement(s), and:
<code>13. TreeSet&lt;String&gt; s = new TreeSet&lt;String&gt;();
14. TreeSet&lt;String&gt; subs = new TreeSet&lt;String&gt;();
15. s.add("a"); s.add("b"); s.add("c"); s.add("d"); s.add("e");
16.
17. subs = (TreeSet)s.subSet("b", true, "d", true);
18. s.add("g");
19. s.pollFirst();
20. s.pollFirst();
21. s.add("c2");
22. System.out.println(s.size() +" "+ subs.size());</code>

Which are true? (Choose all that apply.)',
'✔ <b>B</b> and <b>F</b> are correct. After "g" is added, TreeSet s contains six elements and TreeSet subs contains three (b, c, d), because "g" is out of the range of subs. The first <code>pollFirst()</code> finds and removes only the "a". The second <code>pollFirst()</code> finds and removes the "b" from both TreeSets (remember they are backed). The final add() is in range of both TreeSets. The final contents are [c,c2,d,e,g] and [c,c2,d].
❌ <b>A, C, D, E, G,</b> and <b>H</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(86, 'A', 'The size of s is 4', 0),
(86, 'B', 'The size of s is 5', 1),
(86, 'C', 'The size of s is 7', 0),
(86, 'D', 'The size of subs is 1', 0),
(86, 'E', 'The size of subs is 2', 0),
(86, 'F', 'The size of subs is 3', 1),
(86, 'G', 'The size of subs is 4', 0),
(86, 'H', 'An exception is thrown at runtime', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
87,
7,
'Given:
<code> 3. import java.util.*;
 4. public class Magellan {
 5.   public static void main(String[] args) {
 6.     TreeMap&lt;String, String&gt; myMap = new TreeMap&lt;String, String&gt;();
 7.     myMap.put("a", "apple"); myMap.put("d", "date");
 8.     myMap.put("f", "fig"); myMap.put("p", "pear");
 9.     System.out.println("1st after mango: " + // sop 1
10.       myMap.higherKey("f"));
11.     System.out.println("1st after mango: " + // sop 2
12.       myMap.ceilingKey("f"));
13.     System.out.println("1st after mango: " + // sop 3
14.       myMap.floorKey("f"));
15.     SortedMap&lt;String, String&gt; sub = new TreeMap&lt;String, String&gt;();
16.     sub = myMap.tailMap("f");
17.     System.out.println("1st after mango: " + // sop 4
18.       sub.firstKey());
19.   }
20. }</code>

Which of the System.out.println statements will produce the output <code>1st after mango: p?</code> (Choose all that apply.)',
'✔ <b>A</b> is correct. The <code>ceilingKey()</code> method''s argument is inclusive. The <code>floorKey()</code> method would be used to find keys before the specified key. The <code>firstKey()</code> method''s argument is also inclusive.
❌ <b>B, C, D, E,</b> and <b>F</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(87, 'A', '<code>sop 1</code>', 1),
(87, 'B', '<code>sop 2</code>', 0),
(87, 'C', '<code>sop 3</code>', 0),
(87, 'D', '<code>sop 4</code>', 0),
(87, 'E', 'None; compilation fails', 0),
(87, 'F', 'None; an exception is thrown at runtime', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
88,
7,
'Given:
<code> 3. import java.util.*;
 4. class Business { }
 5. class Hotel extends Business { }
 6. class Inn extends Hotel { }
 7. public class Travel {
 8.   ArrayList&lt;Hotel&gt; go() {
 9.     // insert code here
10.   }
11. }</code>

Which, inserted independently at line 9, will compile? (Choose all that apply.)',
'✔ <b>B</b> is correct.
❌ <b>A</b> is incorrect because polymorphic assignments don''t apply to generic type parameters. <b>C</b> and <b>D</b> are incorrect because they don''t follow basic polymorphism rules.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(88, 'A', '<code>return new ArrayList&lt;Inn&gt;();</code>', 0),
(88, 'B', '<code>return new ArrayList&lt;Hotel&gt;();</code>', 1),
(88, 'C', '<code>return new ArrayList&lt;Object&gt;();</code>', 0),
(88, 'D', '<code>return new ArrayList&lt;Business&gt;();</code>', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
89,
7,
'Given:
<code> 3. import java.util.*;
 4. class Dog { int size; Dog(int s) { size = s; } }
 5. public class FirstGrade {
 6.   public static void main(String[] args) {
 7.     TreeSet&lt;Integer&gt; i = new TreeSet&lt;Integer&gt;();
 8.     TreeSet&lt;Dog&gt; d = new TreeSet&lt;Dog&gt;();
 9.
10.     d.add(new Dog(1)); d.add(new Dog(2)); d.add(new Dog(1));
11.     i.add(1); i.add(2); i.add(1);
12.     System.out.println(d.size() + " " + i.size());
13.   }
14. }</code>

What is the result?',
'✔ <b>G</b> is correct. Class <code>Dog</code> needs to implement <code>Comparable</code> in order for a <code>TreeSet</code> (which keeps its elements sorted) to be able to contain <code>Dog</code> objects.
❌ <b>A, B, C, D, E,</b> and <b>F</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(89, 'A', '1 2', 0),
(89, 'B', '2 2', 0),
(89, 'C', '2 3', 0),
(89, 'D', '3 2', 0),
(89, 'E', '3 3', 0),
(89, 'F', 'Compilation fails', 0),
(89, 'G', 'An exception is thrown at runtime', 1);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
90,
7,
'Given:
<code> 3. import java.util.*;
 4. public class GeoCache {
 5.   public static void main(String[] args) {
 6.     String[] s = {"map", "pen", "marble", "key"};
 7.     Othello o = new Othello();
 8.     Arrays.sort(s,o);
 9.     for(String s2: s) System.out.print(s2 + " ");
10.     System.out.println(Arrays.binarySearch(s, "map"));
11.   }
12.   static class Othello implements Comparator&lt;String&gt; {
13.     public int compare(String a, String b) { return b.compareTo(a); }
14.   }
15. }</code>

Which are true? (Choose all that apply.)',
'✔ <b>D</b> and <b>G</b> are correct. First, the <code>compareTo()</code> method will reverse the normal sort. Second, the <code>sort()</code> is valid. Third, the binarySearch() gives –1 because it needs to be invoked using the same <code>Comparator (o)</code>, as was used to sort the array. Note that when the <code>binarySearch()</code> returns an "undefined result" it doesn''t officially have to be a -1, but it usually is, so if you selected only G, you get full credit!
❌ <b>A, B, C, E,</b> and <b>F</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(90, 'A', 'Compilation fails', 0),
(90, 'B', 'The output will contain a 1', 0),
(90, 'C', 'The output will contain a 2', 0),
(90, 'D', 'The output will contain a -1', 1),
(90, 'E', 'An exception is thrown at runtime', 0),
(90, 'F', 'The output will contain "<code>key map marble pen</code>"', 0),
(90, 'G', 'The output will contain "<code>pen marble map key</code>"', 1);

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back


