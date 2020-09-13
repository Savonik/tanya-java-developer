-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied

-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
120,
10,
'Given:
<code>1. // insert code here
2. class StatTest {
3.   public static void main(String[] args) {
4.     System.out.println(Integer.MAX_VALUE);
5.   }
6. }</code>

Which, inserted independently at line 1, compiles? (Choose all that apply.)',
'✔ <b>C</b> and <b>E</b> are correct syntax for static imports. Line 4 isn''t making use of static imports, so the code will also compile with none of the imports.
❌ <b>A, B, D,</b> and <b>F</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(120, 'A', '<code>import static java.lang;</code>', 0),
(120, 'B', '<code>import static java.lang.Integer;</code>', 0),
(120, 'C', '<code>import static java.lang.Integer.*;</code>', 1),
(120, 'D', '<code>import static java.lang.Integer.*_VALUE;</code>', 0),
(120, 'E', '<code>import static java.lang.Integer.MAX_VALUE;</code>', 1),
(120, 'F', 'None of the above statements are valid import syntax', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
121,
10,
'Given:
<code>import static java.lang.System.*;
class _ {
  static public void main(String... __A_V_) {
    String $ = "";
    for(int x=0; ++x &lt; __A_V_.length; )
      $ += __A_V_[x];
    out.println($);
  }
}</code>

And the command line:
<code>java _ - A .</code>

What is the result?',
'✔ <b>B</b> is correct. This question is using valid (but inappropriate and weird) identifiers, static imports, var-args in <code>main()</code>, and pre-incrementing logic.
❌ <b>A, C, D, E, F,</b> and <b>G</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(121, 'A', '<code>-A</code>', 0),
(121, 'B', '<code>A.</code>', 1),
(121, 'C', '<code>-A.</code>', 0),
(121, 'D', '<code>_A.</code>', 0),
(121, 'E', '<code>_-A.</code>', 0),
(121, 'F', 'Compilation fails', 0),
(121, 'G', 'An exception is thrown at runtime', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
122,
10,
'Given the default classpath:
<code>/foo</code>

And this directory structure:
<code>foo
  |
  test
     |
     xcom
        |--A.class
        |--B.java</code>

And these two files:
<code>package xcom;
public class A { }</code>

<code>package xcom;
public class B extends A { }</code>

Which allows B.java to compile? (Choose all that apply.)',
'✔ <b>C</b> is correct. In order for <code>B.java</code> to compile, the compiler first needs to be able to find <code>B.java</code>. Once it''s found B.java it needs to find A.class. Because A.class is in the <code>xcom</code> package the compiler won''t find <code>A.class</code> if it''s invoked from the <code>xcom</code> directory. Remember that the <code>-classpath</code> isn''t looking for <code>B.java</code>, it''s looking for whatever classes <code>B.java</code> needs (in this case <code>A.class</code>).
❌ <b>A, B,</b> and <b>D</b> are incorrect based on the above. <b>E</b> is incorrect because the compiler can''t find <code>B.java</code>.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(122, 'A', 'Set the current directory to xcom then invoke
<code>javac B.java</code>', 0),
(122, 'B', 'Set the current directory to xcom then invoke
<code>javac -classpath . B.java</code>', 0),
(122, 'C', 'Set the current directory to test then invoke
<code>javac -classpath . xcom/B.java</code>', 1),
(122, 'D', 'Set the current directory to test then invoke
<code>javac -classpath xcom B.java</code>', 0),
(122, 'E', 'Set the current directory to test then invoke
<code>javac -classpath xcom:. B.java</code>', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
123,
10,
'Given two files:
<code>a=b.java
c_d.class</code>

Are in the current directory, which command-line invocation(s) could complete without error? (Choose all that apply.)',
'✔ <b>A</b> is correct. The <code>-D</code> flag is NOT a compiler flag, and the name=value pair that is associated with the <code>-D</code> must follow the <code>-D</code> with no spaces.
❌ <b>B, C,</b> and <b>D</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(123, 'A', '<code>java -Da=b c_d</code>', 1),
(123, 'B', '<code>java -D a=b c_d</code>', 0),
(123, 'C', '<code>java -D a=b c_d</code>', 0),
(123, 'D', '<code>java -D a=b c_d</code>', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
124,
10,
'If three versions of MyClass.class exist on a file system:
<code>Version 1 is in /foo/bar
Version 2 is in /foo/bar/baz
Version 3 is in /foo/bar/baz/bing</code>

And the system''s classpath includes
<code>/foo/bar/baz</code>

And this command line is invoked from /foo
<code>java -classpath /foo/bar/baz/bing:/foo/bar MyClass</code>

Which version will be used by java?',
'✔ <b>D</b> is correct. A -classpath included with a <code>java</code> invocation overrides a system classpath. When <code>java</code> is using any classpath, it reads the classpath from left to right, and uses the first match it finds.
❌ <b>A, B, C,</b> and <b>E</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(124, 'A', '<code>/foo/MyClass.class</code>', 0),
(124, 'B', '<code>/foo/bar/MyClass.class</code>', 0),
(124, 'C', '<code>/foo/bar/baz/MyClass.class</code>', 0),
(124, 'D', '<code>/foo/bar/baz/bing/MyClass.class</code>', 1),
(124, 'E', 'The result is not predictable.', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
125,
10,
'Given:
<code> 1. package pkgA;
 2. public class Foo {
 3.   int a = 5;
 4.   protected int b = 6;
 5. }

 1. package pkgB;
 2. import pkgA.*;
 3. public class Fiz extends Foo {
 4.   public static void main(String[] args) {
 5.     Foo f = new Foo();
 6.     System.out.print(" " + f.a);
 7.     System.out.print(" " + f.b);
 8.     System.out.print(" " + new Fiz().a);
 9.     System.out.println(" " + new Fiz().b);
10.   }
11. }</code>

What is the result? (Choose all that apply.)',
'✔ <b>C, D,</b> and <b>E</b> are correct. Variable a (default access) cannot be accessed from outside the package. Since variable b is protected, it can be accessed only through inheritance.
❌ <b>A, B,</b> and <b>F</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(125, 'A', '<code>5 6 5 6</code>', 0),
(125, 'B', '<code>5 6</code> followed by an exception', 0),
(125, 'C', 'Compilation fails with an error on line 6', 1),
(125, 'D', 'Compilation fails with an error on line 7', 1),
(125, 'E', 'Compilation fails with an error on line 8', 1),
(125, 'F', 'Compilation fails with an error on line 9', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
126,
10,
'Given:
<code> 3. import java.util.*;
 4. public class Antique {
 5.   public static void main(String[] args) {
 6.     List&lt;String&gt; myList = new ArrayList&lt;String&gt;();
 7.     assert (args.length &gt; 0);
 8.     System.out.println("still static");
 9.   }
10. }</code>

Which sets of commands (javac followed by java) will compile and run without exception or error? (Choose all that apply.)',
'✔ <b>A</b> and <b>C</b> are correct. If assertions (which were first available in Java 1.4) are enabled, an AssertionError will be thrown at line 7.
❌ <b>D</b> is incorrect because the code uses generics, and generics weren''t introduced until Java 5. <b>B</b> and <b>E</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(126, 'A', '<code>javac Antique.java
   java Antique</code>', 1),
(126, 'B', '<code>javac Antique.java
   java -ea Antique</code>', 0),
(126, 'C', '<code>javac -source 6 Antique.java
   java Antique</code>', 1),
(126, 'D', '<code>javac -source 1.4 Antique.java
   java Antique</code>', 0),
(126, 'E', '<code>javac -source 1.6 Antique.java
   java -ea Antique</code>', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
127,
10,
'Given:
<code> 3. import java.util.*;
 4. public class Values {
 5.   public static void main(String[] args) {
 6.     Properties p = System.getProperties();
 7.     p.setProperty("myProp", "myValue");
 8.     System.out.print(p.getProperty("cmdProp") + " ");
 9.     System.out.print(p.getProperty("myProp") + " ");
10.     System.out.print(p.getProperty("noProp") + " ");
11.     p.setProperty("cmdProp", "newValue");
12.     System.out.println(p.getProperty("cmdProp"));
13.   }
14. }</code>

And given the command line invocation:
<code>java -DcmdProp=cmdValue Values</code>

What is the result?',
'✔ <b>E</b> is correct. System properties can be set at the command line, as indicated correctly in the example. System properties can also be set and overridden programmatically.
❌ <b>A, B, C, D,</b> and <b>F</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(127, 'A', '<code>null myValue null null</code>', 0),
(127, 'B', '<code>cmdValue null null cmdValue</code>', 0),
(127, 'C', '<code>cmdValue null null newValue</code>', 0),
(127, 'D', '<code>cmdValue myValue null cmdValue</code>', 0),
(127, 'E', '<code>cmdValue myValue null newValue</code>', 1),
(127, 'F', 'An exception is thrown at runtime', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
128,
10,
'Given the following directory structure:
<code>x-|
  |- FindBaz.class
  |
  |- test-|
          |- Baz.class
          |
          |- myApp-|
                   |- Baz.class</code>

And given the contents of the related .java files:
<code>1. public class FindBaz {
2.   public static void main(String[] args) { new Baz(); }
3. }</code>

In the test directory:
<code>1. public class Baz {
2.   static { System.out.println("test/Baz"); }
3. }</code>

In the myApp directory:
<code>1. public class Baz {
2.   static { System.out.println("myApp/Baz"); }
3. }</code>

If the current directory is x, which invocations will produce the output "test/Baz"? (Choose all that apply.)',
'✔ <b>C</b> and <b>F</b> are correct. The <code>java</code> command must find both <code>FindBaz</code> and the version of <code>Baz</code> located in the test directory. The "." finds <code>FindBaz</code>, and "<code>test</code>" must come before "<code>test/myApp</code>" or <code>java</code> will find the other version of <code>Baz</code>. Remember the real exam will default to using the Unix path separator.
❌ <b>A, B, D, E,</b> and <b>G</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(128, 'A', '<code>java FindBaz</code>', 0),
(128, 'B', '<code>java -classpath test FindBaz</code>', 0),
(128, 'C', '<code>java -classpath .:test FindBaz</code>', 1),
(128, 'D', '<code>java -classpath .:test/myApp FindBaz</code>', 0),
(128, 'E', '<code>java -classpath test:test/myApp FindBaz</code>', 0),
(128, 'F', '<code>java -classpath test:test/myApp:. FindBaz</code>', 1),
(128, 'G', '<code>java -classpath test/myApp:test:. FindBaz</code>', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
129,
10,
'Given the following directory structure:
<code>test-|
     |- Test.java
     |
     |- myApp-|
              |- Foo.java
              |
              |- myAppSub-|
                          |- Bar.java</code>

If the current directory is test, and you create a .jar file by invoking this,
<code>jar -cf MyJar.jar myApp</code>
then which path names will find a file in the .jar file? (Choose all that apply.)',
'✔ <b>C</b> and <b>G</b> are correct. The files in a .jar file will exist within the same exact directory tree structure in which they existed when the .jar was created. Although a .jar file will contain a META-INF directory, none of your files will be in it. Finally, if any files exist in the directory from which the jar command was invoked, they won’t be included in the .jar file by default.
❌ <b>A, B, D, E,</b> and <b>F</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(129, 'A', '<code>Foo.java</code>', 0),
(129, 'B', '<code>Test.java</code>', 0),
(129, 'C', '<code>myApp/Foo.java</code>', 1),
(129, 'D', '<code>myApp/Bar.java</code>', 0),
(129, 'E', '<code>META-INF/Foo.java</code>', 0),
(129, 'F', '<code>META-INF/myApp/Foo.java</code>', 0),
(129, 'G', '<code>myApp/myAppSub/Bar.java</code>', 1);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
130,
10,
'Given the following directory structure:
<code>test-|
     |- GetJar.java
     |
     |- myApp-|
              |-Foo.java</code>

And given the contents of GetJar.java and Foo.java:
<code>3. public class GetJar {
4.   public static void main(String[] args) {
5.     System.out.println(myApp.Foo.d);
6.   }
7. }</code>

<code>3. package myApp;
4. public class Foo { public static int d = 8; }</code>

If the current directory is "test", and myApp/Foo.class is placed in a JAR file called MyJar.jar located in test, which set(s) of commands will compile GetJar.java and produce the output 8? (Choose all that apply.)',
'✔ <b>A</b> is correct. Given the current directory and where the necessary files are located, these are the correct command line statements.
❌ <b>B</b> and <b>D</b> are wrong because javac MyJar.jar GetJar.java is incorrect syntax. <b>C</b> is wrong because the -classpath MyJar.java in the java invocation does not include the test directory.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(130, 'A', '<code>javac -classpath MyJar.jar GetJar.java
   java GetJar</code>', 1),
(130, 'B', '<code>javac MyJar.jar GetJar.java
   java GetJar</code>', 0),
(130, 'C', '<code>javac -classpath MyJar.jar GetJar.java
   java -classpath MyJar.jar GetJar</code>', 0),
(130, 'D', '<code>javac MyJar.jar GetJar.java
   java -classpath MyJar.jar GetJar</code>', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
131,
10,
'Given the following directory structure:
<code>x-|
  |- GoDeep.class
  |
  |- test-|
          |- MyJar.jar
          |
          |- myApp-|
                   |-Foo.java
                   |-Foo.class</code>

And given the contents of GoDeep.java and Foo.java:
<code>3. public class GoDeep {
4.   public static void main(String[] args) {
5.     System.out.println(myApp.Foo.d);
6.   }
7. }</code>

<code>3. package myApp;
4. public class Foo { public static int d = 8; }</code>

And MyJar.jar contains the following entry:
<code>myApp/Foo.class</code>

If the current directory is x, which commands will successfully execute GoDeep.class and produce the output 8? (Choose all that apply.)',
'✔ <b>F</b> and <b>G</b> are correct. The java command must find both <code>GoDeep</code> and <code>Foo</code>, and the <code>-classpath</code> option must come before the class name. Note, the current directory (.), in the <code>classpath</code> can be searched first or last.
❌ <b>A, B, C, D,</b> and <b>E</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(131, 'A', '<code>java GoDeep</code>', 0),
(131, 'B', '<code>java -classpath . GoDeep</code>', 0),
(131, 'C', '<code>java -classpath test/MyJar.jar GoDeep</code>', 0),
(131, 'D', '<code>java GoDeep -classpath test/MyJar.jar</code>', 0),
(131, 'E', '<code>java GoDeep -classpath test/MyJar.jar:.</code>', 0),
(131, 'F', '<code>java -classpath .:test/MyJar.jar GoDeep</code>', 1),
(131, 'G', '<code>java -classpath test/MyJar.jar:. GoDeep</code>', 1);


-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back


