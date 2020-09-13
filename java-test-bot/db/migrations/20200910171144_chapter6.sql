-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied

-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
62,
6,
'Given:
<code>import java.util.regex.*;
class Regex2 {
  public static void main(String[] args) {
    Pattern p = Pattern.compile(args[0]);
    Matcher m = p.matcher(args[1]);
    boolean b = false;
    while(b = m.find()) {
      System.out.print(m.start() + m.group());
    }
  }
}</code>

And the command line:
<code>java Regex2 "\d*" ab34ef</code>

What is the result?',
'✔ <b>E</b> is correct. The <code>\d</code> is looking for digits. The * is a quantifier that looks for 0 to many occurrences of the pattern that precedes it. Because we specified *, the <code>group()</code> method returns empty Strings until consecutive digits are found, so the only time <code>group()</code> returns a value is when it returns 34 when the matcher finds digits starting in position 2. The <code>start()</code> method returns the starting position of the previous match because, again, we said find 0 to many occurrences.
❌ <b>A, B, C, D, F,</b> and <b>G</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(62, 'A', '<code>234</code>', 0),
(62, 'B', '<code>334</code>', 0),
(62, 'C', '<code>2334</code>', 0),
(62, 'D', '<code>0123456</code>', 0),
(62, 'E', '<code>01234456</code>', 1),
(62, 'F', '<code>12334567</code>', 0),
(62, 'G', 'Compilation fails', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
63,
6,
'Given:
<code>import java.io.*;
class Player {
  Player() { System.out.print("p"); }
}
class CardPlayer extends Player implements Serializable {
  CardPlayer() { System.out.print("c"); }
  public static void main(String[] args) {
    CardPlayer c1 = new CardPlayer();
    try {
      FileOutputStream fos = new FileOutputStream("play.txt");
      ObjectOutputStream os = new ObjectOutputStream(fos);
      os.writeObject(c1);
      os.close();
      FileInputStream fis = new FileInputStream("play.txt");
      ObjectInputStream is = new ObjectInputStream(fis);
      CardPlayer c2 = (CardPlayer) is.readObject();
      is.close();
    } catch (Exception x ) { }
  }
}</code>

What is the result?',
'✔ <b>C</b> is correct. It''s okay for a class to implement Serializable even if its superclass doesn''t. However, when you deserialize such an object, the non-serializable superclass must run its constructor. Remember, constructors don''t run on deserialized classes that implement Serializable.
❌ <b>A, B, D, E,</b> and <b>F</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(63, 'A', '<code>pc</code>', 0),
(63, 'B', '<code>pcc</code>', 0),
(63, 'C', '<code>pcp</code>', 1),
(63, 'D', '<code>pcpc</code>', 0),
(63, 'E', 'Compilation fails', 0),
(63, 'F', 'An exception is thrown at runtime', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
64,
6,
'Given:
<code>class TKO {
  public static void main(String[] args) {
    String s = "-";
    Integer x = 343;
    long L343 = 343L;
    if(x.equals(L343)) s += ".e1 ";
    if(x.equals(343)) s += ".e2 ";
    Short s1 = (short)((new Short((short)343)) / (new Short((short)49)));
    if(s1 == 7) s += "=s ";
    if(s1 &lt; new Integer(7+1)) s += "fly ";
    System.out.println(s);
} }</code>

Which of the following will be included in the output String s? (Choose all that apply.)',
'✔ <b>B</b>, <b>C</b>, and <b>D</b> are correct. Remember, that the <code>equals()</code> method for the integer wrappers will only return true if the two primitive types and the two values are equal. With <b>C</b>, it''s okay to unbox and use ==. For <b>D</b>, it''s okay to create a wrapper object with an expression, and unbox it for comparison with a primitive.
❌ <b>A, E, F,</b> and <b>G</b> are incorrect based on the above. (Remember that <b>A</b> is using the <code>equals()</code> method to try to compare two different types.)');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(64, 'A', '<code>.e1</code>', 0),
(64, 'B', '<code>.e2</code>', 1),
(64, 'C', '<code>=s</code>', 1),
(64, 'D', '<code>fly</code>', 1),
(64, 'E', 'None of the above', 0),
(64, 'F', 'Compilation fails', 0),
(64, 'G', 'An exception is thrown at runtime', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
65,
6,
'Given:
<code>import java.io.*;

class Keyboard { }
public class Computer implements Serializable {
  private Keyboard k = new Keyboard();
  public static void main(String[] args) {
    Computer c = new Computer();
    c.storeIt(c);
  }
  void storeIt(Computer c) {
    try {
      ObjectOutputStream os = new ObjectOutputStream(
        new FileOutputStream("myFile"));
      os.writeObject(c);
      os.close();
      System.out.println("done");
    } catch (Exception x) {System.out.println("exc"); }
  }
}</code>

What is the result? (Choose all that apply.)',
'✔ <b>A</b> is correct. An instance of type Computer Has-a Keyboard. Because Keyboard doesn''t implement Serializable, any attempt to serialize an instance of Computer will cause an exception to be thrown.
❌ <b>B, C, D,</b> and <b>E</b> are incorrect based on the above. If Keyboard did implement Serializable then two objects would have been serialized.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(65, 'A', '<code>exc</code>', 1),
(65, 'B', '<code>done</code>', 0),
(65, 'C', 'Compilation fails', 0),
(65, 'D', 'Exactly one object is serialized', 0),
(65, 'E', 'Exactly two objects are serialized', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
66,
6,
'Given:
<code>import java.io.*;
class Directories {
  static String [] dirs = {"dir1", "dir2"};
  public static void main(String [] args) {
    for (String d : dirs) {
      // insert code 1 here
      File file = new File(path, args[0]);
      // insert code 2 here
    }
  }
}</code>

and that the invocation

<code>java Directories file2.txt</code>

is issued from a directory that has two subdirectories, "<code>dir1</code>" and "<code>dir2</code>", and that "<code>dir1</code>" has a file "<code>file1.txt</code>" and "<code>dir2</code>" has a file "<code>file2.txt</code>", and the output is "<code>false true</code>", which set(s) of code fragments must be inserted? (Choose all that apply.)

What is the result?',
'✔ <b>A</b> and <b>B</b> are correct. Because you are invoking the program from the directory whose direct subdirectories are to be searched, you don''t start your path with a <code>File.separator</code> character. The <code>exists()</code> method tests for either files or directories; the <code>isFile()</code> method tests only for files. Since we''re looking for a file, both methods work.
❌ <b>C</b> and <b>D</b> are incorrect based on the above.');
-- +goose StatementEnd

-- +goose StatementBegin
INSERT INTO answer (question_id, letter, answer, valid) VALUES
(66, 'A',
'<code>String path = d;
System.out.print(file.exists() + " ");</code>', 1),
(66, 'B',
'<code>String path = d;
System.out.print(file.isFile() + " ");</code>', 1),
(66, 'C',
'<code>String path = File.separator + d;
System.out.print(file.exists() + " ");</code>', 0),
(66, 'D',
'<code>String path = File.separator + d;
System.out.print(file.isFile() + " ");</code>', 0);
-- +goose StatementEnd


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
67,
6,
'Given:
<code>import java.io.*;

public class TestSer {
  public static void main(String[] args) {
    SpecialSerial s = new SpecialSerial();
    try {
      ObjectOutputStream os = new ObjectOutputStream(
        new FileOutputStream("myFile"));
      os.writeObject(s); os.close();
      System.out.print(++s.z + " ");

      ObjectInputStream is = new ObjectInputStream(
        new FileInputStream("myFile"));
      SpecialSerial s2 = (SpecialSerial)is.readObject();
      is.close();
      System.out.println(s2.y + " " + s2.z);
    } catch (Exception x) {System.out.println("exc"); }
  }
}
class SpecialSerial implements Serializable {
  transient int y = 7;
  static int z = 9;
}</code>

Which are true? (Choose all that apply.)',
'✔ <b>C</b> and <b>F</b> are correct. <b>C</b> is correct because static and transient variables are not serialized when an object is serialized. <b>F</b> is a valid statement.
❌ <b>A, B, D,</b> and <b>E</b> are incorrect based on the above. G is incorrect because you don''t implement the <code>defaultReadObject()</code> method, you call it from within the <code>readObject()</code> method, along with any custom read operations your class needs.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(67, 'A', 'Compilation fails', 0),
(67, 'B', 'The output is <code>10 0 9</code>', 0),
(67, 'C', 'The output is <code>10 0 10</code>', 1),
(67, 'D', 'The output is <code>10 7 9</code>', 0),
(67, 'E', 'The output is <code>10 7 10</code>', 0),
(67, 'F', 'In order to alter the standard deserialization process you would implement the <code>readObject()</code> method in <code>SpecialSerial</code>', 1),
(67, 'G', 'In order to alter the standard deserialization process you would implement the <code>defaultReadObject()</code> method in <code>SpecialSerial</code>', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
68,
6,
'Given:
<code> 3. public class Theory {
 4.   public static void main(String[] args) {
 5.     String s1 = "abc";
 6.     String s2 = s1;
 7.     s1 += "d";
 8.     System.out.println(s1 + " " + s2 + " " + (s1==s2));
 9.
10.     StringBuffer sb1 = new StringBuffer("abc");
11.     StringBuffer sb2 = sb1;
12.     sb1.append("d");
13.     System.out.println(sb1 + " " + sb2 + " " + (sb1==sb2));
14.   }
15. }</code>

Which are true? (Choose all that apply.)',
'✔ <b>D</b> and <b>F</b> are correct. While String objects are immutable, references to Strings are mutable. The code <code>s1 += "d";</code> creates a new String object. StringBuffer objects are mutable, so the <code>append()</code> is changing the single StringBuffer object to which both StringBuffer references refer.
❌ <b>A, B, C, E,</b> and <b>G</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(68, 'A', 'Compilation fails', 0),
(68, 'B', 'The first line of output is <code>abc abc true</code>', 0),
(68, 'C', 'The first line of output is <code>abc abc false</code>', 0),
(68, 'D', 'The first line of output is <code>abcd abc false</code>', 1),
(68, 'E', 'The first line of output is <code>abcd abc false</code>', 0),
(68, 'F', 'The first line of output is <code>abcd abcd true</code>', 1),
(68, 'G', 'The first line of output is <code>abcd abcd false</code>', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
69,
6,
'Given:
<code> 3. import java.io.*;
 4. public class ReadingFor {
 5.   public static void main(String[] args) {
 6.     String s;
 7.     try {
 8.       FileReader fr = new FileReader("myfile.txt");
 9.       BufferedReader br = new BufferedReader(fr);
10.       while((s = br.readLine()) != null)
11.         System.out.println(s);
12.       br.flush();
13.     } catch (IOException e) { System.out.println("io error"); }
16.   }
17. }
</code>

And given that myfile.txt contains the following two lines of data:
<code>ab
cd</code>

What is the result?',
'✔ <b>E</b> is correct. You need to call <code>flush()</code> only when you''re writing data. Readers don''t have <code>flush()</code> methods. If not for the call to <code>flush()</code>, answer C would be correct.
❌ <b>A, B, C,</b> and <b>D</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(69, 'A', '<code>ab</code>', 0),
(69, 'B', '<code>abcd</code>', 0),
(69, 'C',
'<code>ab
   cd</code>', 0),
(69, 'D',
'<code>a
   b
   c
   d</code>', 0),
(69, 'E', 'Compilation fails', 1);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
70,
6,
'Given:
<code> 3. import java.io.*;
 4. public class Talker {
 5.   public static void main(String[] args) {
 6.     Console c = System.console();
 7.     String u = c.readLine("%s", "username: ");
 8.     System.out.println("hello " + u);
 9.     String pw;
10.     if(c != null && (pw = c.readPassword("%s", "password: ")) != null)
11.       // check for valid password
12.   }
13. }</code>

If line 6 creates a valid Console object, and if the user enters <i>fred</i> as a username and <i>1234</i> as a password, what is the result? (Choose all that apply.)',
'✔ <b>D</b> is correct. The <code>readPassword()</code> method returns a <code>char[]</code>. If a <code>char[]</code> were used, answer B would be correct.
❌ <b>A, B, C,</b> and <b>E</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(70, 'A',
'<code>username:
   password:</code>', 0),
(70, 'B',
'<code>username: fred
   password:</code>', 0),
(70, 'C',
'<code>username: fred
   password: 1234</code>', 0),
(70, 'D', 'Compilation fails', 1),
(70, 'E', 'An exception is thrown at runtime', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
71,
6,
'Given:
<code> 3. import java.io.*;
 4. class Vehicle { }
 5. class Wheels { }
 6. class Car extends Vehicle implements Serializable { }
 7. class Ford extends Car { }
 8. class Dodge extends Car {
 9.   Wheels w = new Wheels();
10. }</code>

Instances of which class(es) can be serialized? (Choose all that apply.)',
'✔ <b>A</b> and <b>B</b> are correct. Dodge instances cannot be serialized because they "have" an instance of Wheels, which is not serializable. Vehicle instances cannot be serialized even though the subclass Car can be.
❌ <b>C, D,</b> and <b>E</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(71, 'A', 'Car', 1),
(71, 'B', 'Ford', 1),
(71, 'C', 'Dodge', 0),
(71, 'D', 'Wheels', 0),
(71, 'E', 'Vehicle', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
72,
6,
'Given:
<code> 3. import java.text.*;
 4. public class Slice {
 5.   public static void main(String[] args) {
 6.     String s = "987.123456";
 7.     double d = 987.123456d;
 8.     NumberFormat nf = NumberFormat.getInstance();
 9.     nf.setMaximumFractionDigits(5);
10.     System.out.println(nf.format(d) + " ");
11.     try {
12.       System.out.println(nf.parse(s));
13.     } catch (Exception e) { System.out.println("got exc"); }
14.   }
15. }</code>

Which are true? (Choose all that apply.)',
'✔ <b>D, F,</b> and <b>G</b> are correct. The <code>setMaximumFractionDigits()</code> applies to the formatting but not the parsing. The try/catch block is placed appropriately. This one might scare you into thinking that you''ll need to memorize more than you really do. If you can remember that you''re formatting the number and parsing the string you should be fine for the exam.
❌ <b>A, B, C,</b> and <b>E</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(72, 'A', 'The output is <code>987.12345 987.12345</code>', 0),
(72, 'B', 'The output is <code>987.12346 987.12345</code>', 0),
(72, 'C', 'The output is <code>987.12345 987.123456</code>', 0),
(72, 'D', 'The output is <code>987.12346 987.123456</code>', 1),
(72, 'E', 'The try/catch block is unnecessary', 0),
(72, 'F', 'The code compiles and runs without exception', 1),
(72, 'G', 'The invocation of <code>parse()</code> must be placed within a try/catch block', 1);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
73,
6,
'Given:
<code> 3. import java.util.regex.*;
 4. public class Archie {
 5.   public static void main(String[] args) {
 6.     Pattern p = Pattern.compile(args[0]);
 7.     Matcher m = p.matcher(args[1]);
 8.     int count = 0;
 9.     while(m.find())
10.       count++;
11.     System.out.print(count);
12.   }
13. }</code>

And given the command line invocation:
<code>java Archie "\d+" ab2c4d67</code>

What is the result?',
'✔ <b>B</b> is correct. The "<code>\d</code>" metacharacter looks for digits, and the + quantifier says look for "one or more" occurrences. The <code>find()</code> method will find three sets of one or more consecutive digits: 2, 4, and 67.
❌ <b>A, C, D, E,</b> and <b>F</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(73, 'A', '0', 0),
(73, 'B', '3', 1),
(73, 'C', '4', 0),
(73, 'D', '8', 0),
(73, 'E', '9', 0),
(73, 'F', 'Compilation fails', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
74,
6,
'Given:
<code> 3. import java.util.*;
 4. public class Looking {
 5.   public static void main(String[] args) {
 6.     String input = "1 2 a 3 45 6";
 7.     Scanner sc = new Scanner(input);
 8.     int x = 0;
 9.     do {
10.       x = sc.nextInt();
11.       System.out.print(x + " ");
12.     } while (x!=0);
13.   }
14. }</code>

What is the result?',
'✔ <b>F</b> is correct. The <code>nextXxx()</code> methods are typically invoked after a call to a <code>hasNextXxx()</code>, which determines whether the next token is of the correct type.
❌ <b>A, B, C, D,</b> and <b>E</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(74, 'A', '<code>1 2</code>', 0),
(74, 'B', '<code>1 2 3 45 6</code>', 0),
(74, 'C', '<code>1 2 3 4 5 6</code>', 0),
(74, 'D', '<code>1 2 a 3 45 6</code>', 0),
(74, 'E', 'Compilation fails', 0),
(74, 'F', '<code>1 2</code> followed by an exception', 1);


-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
