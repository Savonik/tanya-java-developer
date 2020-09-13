-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied

-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
103,
9,
'The following block of code creates a Thread using a Runnable target:
<code>Runnable target = new MyRunnable();
Thread myThread = new Thread(target);</code>

Which of the following classes can be used to create the target, so that the preceding code
compiles correctly?',
'✔ <b>C</b> is correct. The class implements the Runnable interface with a legal <code>run()</code> method.
❌ <b>A</b> is incorrect because interfaces are implemented, not extended. <b>B</b> is incorrect because even though the class has a valid <code>public void run()</code> method, it does not implement the Runnable interface. <b>D</b> is incorrect because the <code>run()</code> method must be <code>public</code>. E is incorrect because the method to implement is <code>run()</code>, not <code>start()</code>.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(103, 'A', '<code>public class MyRunnable extends Runnable{public void run(){}}</code>', 0),
(103, 'B', '<code>public class MyRunnable extends Object{public void run(){}}</code>', 0),
(103, 'C', '<code>public class MyRunnable implements Runnable{public void run(){}}</code>', 1),
(103, 'D', '<code>public class MyRunnable implements Runnable{void run(){}}</code>', 0),
(103, 'E', '<code>public class MyRunnable implements Runnable{public void start(){}}</code>', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
104,
9,
'Given:
<code> 3. class MyThread extends Thread {
 4.   public static void main(String [] args) {
 5.     MyThread t = new MyThread();
 6.     Thread x = new Thread(t);
 7.     x.start();
 8.   }
 9.   public void run() {
10.     for(int i=0;i&lt;3;++i) {
11.       System.out.print(i + "..");
12. } } }</code>

What is the result of this code?',
'✔ <b>D</b> is correct. The thread MyThread will start and loop three times (from 0 to 2).
❌ <b>A</b> is incorrect because the Thread class implements the Runnable interface; therefore, in line 5, Thread can take an object of type Thread as an argument in the constructor (this is NOT recommended). <b>B</b> and <b>C</b> are incorrect because the variable i in the for loop starts with a value of 0 and ends with a value of 2. <b>E</b> is incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(104, 'A', 'Compilation fails', 0),
(104, 'B', '1..2..3..', 0),
(104, 'C', '0..1..2..3..', 0),
(104, 'D', '0..1..2..', 1),
(104, 'E', 'An exception occurs at runtime', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
105,
9,
'Given:
<code> 3. class Test {
 4.   public static void main(String [] args) {
 5.     printAll(args);
 6.   }
 7.   public static void printAll(String[] lines) {
 8.     for(int i=0;i&lt;lines.length;i++){
 9.       System.out.println(lines[i]);
10.       Thread.currentThread().sleep(1000);
11. } } }</code>

The <code>static</code> method <code>Thread.currentThread()</code> returns a reference to the currently executing Thread object. What is the result of this code?',
'✔ <b>D</b> is correct. The <code>sleep()</code> method must be enclosed in a <code>try/catch</code> block, or the method <code>printAll()</code> must declare it throws the <code>InterruptedException</code>.
❌ <b>E</b> is incorrect, but it would be correct if the <code>InterruptedException</code> was dealt with (<b>A</b> is too precise). <b>B</b> is incorrect (even if the <code>InterruptedException</code> was dealt with) because all Java code, including the <code>main()</code> method, runs in threads. <b>C</b> is incorrect. The <code>sleep()</code> method is <code>static</code>, it always affects the currently executing thread.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(105, 'A', 'Each String in the array <code>lines</code> will print, with exactly a 1-second pause between lines', 0),
(105, 'B', 'Each String in the array <code>lines</code> will print, with no pause in between because this method is not executed in a Thread', 0),
(105, 'C', 'Each String in the array <code>lines</code> will print, and there is no guarantee there will be a pause because <code>currentThread()</code> may not retrieve this thread', 0),
(105, 'D', 'This code will not compile', 1),
(105, 'E', 'Each String in the <code>lines</code> array will print, with at least a one-second pause between lines', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
106,
9,
'Assume you have a class that holds two <code>private</code> variables: a and b. Which of the following pairs can prevent concurrent access problems in that class? (Choose all that apply.)',
'✔ <b>B</b> and <b>F</b> are correct. By marking the methods as <code>synchronized</code>, the threads will get the lock of the <code>this</code> object before proceeding. Only one thread will be setting or reading at any given moment, thereby assuring that <code>read()</code> always returns the addition of a valid pair.
❌ <b>A</b> is incorrect because it is not synchronized; therefore, there is no guarantee that the values added by the <code>read()</code> method belong to the same pair. <b>C</b> and <b>D</b> are incorrect; only objects can be used to synchronize on. <b>E</b> fails —it is not possible to select other objects (even <code>this</code>) to synchronize on when declaring a method as <code>synchronized</code>.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(106, 'A',
'<code>public int read(){return a+b;}
   public void set(int a, int b){this.a=a;this.b=b;}</code>', 0),
(106, 'B',
'<code>public synchronized int read(){return a+b;}
   public synchronized void set(int a, int b){this.a=a;this.b=b;}</code>', 1),
(106, 'C',
'<code>public int read(){synchronized(a){return a+b;}}
   public void set(int a, int b){synchronized(a){this.a=a;this.b=b;}}</code>', 0),
(106, 'D',
'<code>public int read(){synchronized(a){return a+b;}}
   public void set(int a, int b){synchronized(b){this.a=a;this.b=b;}}</code>', 0),
(106, 'E',
'<code>public synchronized(this) int read(){return a+b;}
   public synchronized(this) void set(int a, int b){this.a=a;this.b=b;}</code>', 0),
(106, 'F',
'<code>public int read(){synchronized(this){return a+b;}}
   public void set(int a, int b){synchronized(this){this.a=a;this.b=b;}}</code>', 1);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
107,
9,
'Given:
<code> 1. public class WaitTest {
 2.   public static void main(String [] args) {
 3.     System.out.print("1 ");
 4.     synchronized(args){
 5.       System.out.print("2 ");
 6.       try {
 7.         args.wait();
 8.       }
 9.       catch(InterruptedException e){}
10.     }
11.     System.out.print("3 ");
12. } }</code>

What is the result of trying to compile and run this program?',
'✔ <b>D</b> is correct. 1 and 2 will be printed, but there will be no return from the <code>wait</code> call because no other thread will notify the main thread, so 3 will never be printed. It''s frozen at line 7.
❌ <b>A</b> is incorrect; <code>IllegalMonitorStateException</code> is an unchecked exception. <b>B</b> and <b>C</b> are incorrect; 3 will never be printed, since this program will wait forever. <b>E</b> is incorrect because <code>IllegalMonitorStateException</code> will never be thrown because the <code>wait()</code> is done on args within a block of code synchronized on <code>args</code>. <b>F</b> is incorrect because any object can be used to synchronize on and <code>this</code> and <code>static</code> don''t mix.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(107, 'A', 'It fails to compile because the <code>IllegalMonitorStateException</code> of <code>wait()</code> is not dealt with in line 7', 0),
(107, 'B', '<code>1 2 3</code>', 0),
(107, 'C', '<code>1 3</code>', 0),
(107, 'D', '<code>1 2</code>', 1),
(107, 'E', 'At runtime, it throws an <code>IllegalMonitorStateException</code> when trying to wait', 0),
(107, 'F', 'It will fail to compile because it has to be synchronized on the <code>this</code> object', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
108,
9,
'Assume the following method is properly synchronized and called from a thread A on an object B:
<code>wait(2000);</code>

After calling this method, when will the thread A become a candidate to get another turn at the CPU?',
'✔ <b>A</b> is correct. Either of the two events will make the thread a candidate for running again.
❌ <b>B</b> is incorrect because a waiting thread will not return to runnable when the lock is released, unless a notification occurs. <b>C</b> is incorrect because the thread will become a candidate immediately after notification. <b>D</b> is also incorrect because a thread will not come out of a waiting pool just because a lock has been released.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(108, 'A', 'After object B is notified, or after two seconds', 1),
(108, 'B', 'After the lock on B is released, or after two seconds', 0),
(108, 'C', 'Two seconds after object B is notified', 0),
(108, 'D', 'Two seconds after lock B is released', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
109,
9,
'Which are true? (Choose all that apply.)',
'✔ <b>A</b> is correct because <code>notifyAll()</code> (and <code>wait()</code> and <code>notify()</code>) must be called from within a synchronized context. <b>D</b> is a correct statement.
❌ <b>B</b> is incorrect because to call <code>wait()</code>, the thread must own the lock on the object that <code>wait()</code> is being invoked on, not the other way around. <b>C</b> is wrong because <code>notify()</code> is defined in <code>java.lang.Object</code>. <b>E</b> is wrong because <code>notify()</code> will not cause a thread to release its locks. The thread can only release its locks by exiting the synchronized code. <b>F</b> is wrong because <code>notifyAll()</code> notifies all the threads waiting on a particular locked object, not all threads waiting on <i>any</i> object.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(109, 'A', 'The <code>notifyAll()</code> method must be called from a synchronized context', 1),
(109, 'B', 'To call <code>wait()</code>, an object must own the lock on the thread', 0),
(109, 'C', 'The <code>notify()</code> method is defined in class <code>java.lang.Thread</code>', 0),
(109, 'D', 'When a thread is waiting as a result of <code>wait()</code>, it releases its lock', 1),
(109, 'E', 'The <code>notify()</code> method causes a thread to immediately release its lock', 0),
(109, 'F', 'The difference between <code>notify()</code> and <code>notifyAll()</code> is that <code>notifyAll()</code> notifies all waiting threads, regardless of the object they''re waiting on', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
110,
9,
'Given the scenario: This class is intended to allow users to write a series of messages, so that each message is identified with a timestamp and the name of the thread that wrote the message:
<code>public class Logger {
  private StringBuilder contents = new StringBuilder();
  public void log(String message) {
    contents.append(System.currentTimeMillis());
    contents.append(": ");
    contents.append(Thread.currentThread().getName());
    contents.append(message);
    contents.append("\n");
  }
  public String getContents() { return contents.toString(); }
}</code>

How can we ensure that instances of this class can be safely used by multiple threads?',
'✔ <b>E</b> is correct. Synchronizing the <code>public</code> methods is sufficient to make this safe, so <b>F</b> is false. This class is not thread-safe unless some sort of synchronization protects the changing data.
❌ <b>B</b> is not correct because although a <code>StringBuffer</code> is synchonized internally, we call <code>append()</code> multiple times, and nothing would prevent two simultaneous <code>log()</code> calls from mixing up their messages. C and D are not correct because if one method remains unsynchronized, it can run while the other is executing, which could result in reading the contents while one of the messages is incomplete, or worse. (You don''t want to call <code>getString()</code> on the <code>StringBuffer</code> as it''s resizing its internal character array.)');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(110, 'A', 'This class is already thread-safe', 0),
(110, 'B', 'Replacing <code>StringBuilder</code> with <code>StringBuffer</code> will make this class thread-safe', 0),
(110, 'C', 'Synchronize the <code>log()</code> method only', 0),
(110, 'D', 'Synchronize the <code>getContents()</code> method only', 0),
(110, 'E', 'Synchronize both <code>log()</code> and <code>getContents()</code>', 1),
(110, 'F', 'This class cannot be made thread-safe', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
111,
9,
'Given:
<code>public static synchronized void main(String[] args) throws InterruptedException {
  Thread t = new Thread();
  t.start();
  System.out.print("X");
  t.wait(10000);
  System.out.print("Y");
}</code>

What is the result of this code?',
'✔ <b>G</b> is correct. The code does not acquire a lock on <code>t</code> before calling <code>t.wait()</code>, so it throws an <code>IllegalMonitorStateException</code>. The method is synchronized, but it''s not synchronized on t so the exception will be thrown. If the wait were placed inside a <code>synchronized(t)</code> block, then the answer would have been <b>D</b>.
❌ <b>A, B, C, D, E,</b> and <b>F</b> are incorrect based the logic described above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(111, 'A', 'It prints X and exits', 0),
(111, 'B', 'It prints X and never exits', 0),
(111, 'C', 'It prints XY and exits almost immeditately', 0),
(111, 'D', 'It prints XY with a 10-second delay between X and Y', 0),
(111, 'E', 'It prints XY with a 10000-second delay between X and Y', 0),
(111, 'F', 'The code does not compile', 0),
(111, 'G', 'An exception is thrown at runtime', 1);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
112,
9,
'Given:
<code>class MyThread extends Thread {
  MyThread() {
    System.out.print(" MyThread");
  }
  public void run() { System.out.print(" bar"); }
  public void run(String s) { System.out.print(" baz"); }
}
public class TestThreads {
  public static void main (String [] args) {
    Thread t = new MyThread() {
    public void run() { System.out.print(" foo"); }
  };
  t.start();
} }</code>

What is the result?',
'✔ <b>B</b> is correct. The first line of main we''re constructing an instance of an anonymous inner class extending from <code>MyThread</code>. So the <code>MyThread</code> constructor runs and prints MyThread. Next, <code>main()</code> invokes <code>start()</code> on the new thread instance, which causes the overridden <code>run()</code> method (the <code>run()</code> method in the anonymous inner class) to be invoked.
❌ <b>A, C, D, E, F, G,</b> and <b>H</b> are incorrect based on the logic described above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(112, 'A', '<code>foo</code>', 0),
(112, 'B', '<code>MyThread foo</code>', 1),
(112, 'C', '<code>MyThread bar</code>', 0),
(112, 'D', '<code>foo bar</code>', 0),
(112, 'E', '<code>foo bar baz</code>', 0),
(112, 'F', '<code>bar foo</code>', 0),
(112, 'G', 'Compilation fails', 0),
(112, 'H', 'An exception is thrown at runtime', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
113,
9,
'Given:
<code>public class ThreadDemo {
  synchronized void a() { actBusy(); }
  static synchronized void b() { actBusy(); }
  static void actBusy() {
    try { Thread.sleep(1000); }
    catch (InterruptedException e) {}
  }
  public static void main(String[] args) {
    final ThreadDemo x = new ThreadDemo();
    final ThreadDemo y = new ThreadDemo();
    Runnable runnable = new Runnable() {
      public void run() {
        int option = (int) (Math.random() * 4);
        switch (option) {
          case 0: x.a(); break;
          case 1: x.b(); break;
          case 2: y.a(); break;
          case 3: y.b(); break;
      } }
    };
    Thread thread1 = new Thread(runnable);
    Thread thread2 = new Thread(runnable);
    thread1.start();
    thread2.start();
 } }</code>

Which of the following pairs of method invocations could NEVER be executing at the same time? (Choose all that apply.)',
'✔ <b>A, F,</b> and <b>H</b>. A is a right answer because when <code>synchronized</code> instance methods are called on the same <i>instance</i>, they block each other. <b>F</b> and <b>H</b> can''t happen because <code>synchronized static</code> methods in the same class block each other, regardless of which instance was used to call the methods. (An instance is not required to call <code>static</code> methods; only the class.)
❌ <b>C</b> could happen because <code>synchronized</code> instance methods called on different instances do not block each other. <b>B, D, E,</b> and <b>G</b> could all happen because instance methods and <code>static</code> methods lock on different objects, and do not block each other.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(113, 'A', '<code>x.a() in thread1,</code> and <code>x.a() in thread2</code>', 1),
(113, 'B', '<code>x.a() in thread1,</code> and <code>x.b() in thread2</code>', 0),
(113, 'C', '<code>x.a() in thread1,</code> and <code>y.a() in thread2</code>', 0),
(113, 'D', '<code>x.a() in thread1,</code> and <code>y.b() in thread2</code>', 0),
(113, 'E', '<code>x.b() in thread1,</code> and <code>x.a() in thread2</code>', 0),
(113, 'F', '<code>x.b() in thread1,</code> and <code>x.b() in thread2</code>', 1),
(113, 'G', '<code>x.b() in thread1,</code> and <code>y.a() in thread2</code>', 0),
(113, 'H', '<code>x.b() in thread1,</code> and <code>y.b() in thread2</code>', 1);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
114,
9,
'Given:
<code>public class TwoThreads {
  static Thread laurel, hardy;
  public static void main(String[] args) {
    laurel = new Thread() {
      public void run() {
        System.out.println("A");
        try {
          hardy.sleep(1000);
        } catch (Exception e) {
          System.out.println("B");
        }
        System.out.println("C");
      }
    };
    hardy = new Thread() {
      public void run() {
        System.out.println("D");
        try {
          laurel.wait();
        } catch (Exception e) {
          System.out.println("E");
        }
        System.out.println("F");
      }
    };
    laurel.start();
    hardy.start();
  }
}</code>

Which letters will eventually appear somewhere in the output? (Choose all that apply.)',
'✔ <b>A, C, D, E,<b/> and <b>F</b> are correct. This may look like <code>laurel</code> and hardy are battling to cause the other to <code>sleep()</code> or <code>wait()</code> — but that''s not the case. Since <code>sleep()</code> is a <code>static</code> method, it affects the current thread, which is <code>laurel</code> (even though the method is invoked using a reference to <code>hardy</code>). That''s misleading but perfectly legal, and the Thread <code>laurel</code> is able to sleep with no exception, printing A and C (after at least a 1-second delay). Meanwhile hardy tries to call <code>laurel.wait()</code> — but hardy has not <code>synchronized</code> on <code>laurel</code>, so calling <code>laurel.wait()</code> immediately causes an <code>IllegalMonitorStateException</code>, and so hardy prints <code>D, E,</code> and <code>F</code>. Although the <i>order</i> of the output is somewhat indeterminate (we have no way of knowing whether <code>A</code> is printed before <code>D</code>, for example) it is guaranteed that <code>A, C, D, E,</code> and <code>F</code> will all be printed in some order, eventually—so <b>G</b> is incorrect.
❌ <b>B, G,</b> and <b>H</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(114, 'A', '<code>A</code>', 1),
(114, 'B', '<code>B</code>', 0),
(114, 'C', '<code>C</code>', 1),
(114, 'D', '<code>D</code>', 1),
(114, 'E', '<code>E</code>', 1),
(114, 'F', '<code>F</code>', 1),
(114, 'G', 'The answer cannot be reliably determined', 0),
(114, 'H', 'The code does not compile', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
115,
9,
'Given:
<code> 3. public class Starter implements Runnable {
 4.   void go(long id) {
 5.     System.out.println(id);
 6.   }
 7.   public static void main(String[] args) {
 8.     System.out.print(Thread.currentThread().getId() + " ");
 9.     // insert code here
10.   }
11.   public void run() { go(Thread.currentThread().getId()); }
12. }</code>

And given the following five fragments:
<code>I.   new Starter().run();
II.  new Starter().start();
III. new Thread(new Starter());
IV.  new Thread(new Starter()).run();
V.   new Thread(new Starter()).start();</code>

When the five fragments are inserted, one at a time at line 9, which are true? (Choose all that apply.)',
'✔ <b>C</b> and <b>D</b> are correct. Fragment I doesn''t start a new thread. Fragment II doesn''t compile. Fragment III creates a new thread but doesn''t start it. Fragment IV creates a new thread and invokes <code>run()</code> directly, but it doesn’t start the new thread. Fragment V creates <i>and</i> starts a new thread.
❌ <b>A, B, E, F,</b> and <b>G</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(115, 'A', 'All five will compile', 0),
(115, 'B', 'Only one might produce the output <code>4 4</code>', 0),
(115, 'C', 'Only one might produce the output <code>4 2</code>', 1),
(115, 'D', 'Exactly two might produce the output <code>4 4</code>', 1),
(115, 'E', 'Exactly two might produce the output <code>4 2</code>', 0),
(115, 'F', 'Exactly three might produce the output <code>4 4</code>', 0),
(115, 'G', 'Exactly three might produce the output <code>4 2</code>', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
116,
9,
'Given:
<code> 3. public class Leader implements Runnable {
 4.   public static void main(String[] args) {
 5.     Thread t = new Thread(new Leader());
 6.     t.start();
 7.     System.out.print("m1 ");
 8.     t.join();
 9.     System.out.print("m2 ");
10.   }
11.   public void run() {
12.     System.out.print("r1 ");
13.     System.out.print("r2 ");
14.   }
15. }</code>

Which are true? (Choose all that apply.)',
'✔ <b>A</b> is correct. The <code>join()</code> must be placed in a try/catch block. If it were, answers <b>B</b> and <b>D</b> would be correct. The <code>join()</code> causes the main thread to pause and join the end of the other thread, meaning "m2" must come last.
❌ <b>B, C, D, E,</b> and <b>F</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(116, 'A', 'Compilation fails', 1),
(116, 'B', 'The output could be <code>r1 r2 m1 m2</code>', 0),
(116, 'C', 'The output could be <code>m1 m2 r1 r2</code>', 0),
(116, 'D', 'The output could be <code>m1 r1 r2 m2</code>', 0),
(116, 'E', 'The output could be <code>m1 r1 m2 r2</code>', 0),
(116, 'F', 'An exception is thrown at runtime', 0);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
117,
9,
'Given:
<code> 3. class Dudes {
 4.   static long flag = 0;
 5.   // insert code here
 6.     if(flag == 0) flag = id;
 7.     for(int x = 1; x &lt; 3; x++) {
 8.       if(flag == id) System.out.print("yo ");
 9.       else System.out.print("dude ");
10.     }
11.   }
12. }
13. public class DudesChat implements Runnable {
14.   static Dudes d;
15.   public static void main(String[] args) {
16.     new DudesChat().go();
17.   }
18.   void go() {
19.     d = new Dudes();
20.     new Thread(new DudesChat()).start();
21.     new Thread(new DudesChat()).start();
22.   }
23.   public void run() {
24.     d.chat(Thread.currentThread().getId());
25.   }
26. }</code>

And given these two fragments:
<code>I.  synchronized void chat(long id) {
II. void chat(long id) {</code>

When fragment I or fragment II is inserted at line 5, which are true? (Choose all that apply.)',
'✔ <b>F</b> is correct. With fragment I, the <code>chat</code> method is synchronized, so the two threads can''t swap back and forth. With either fragment, the first output must be <code>yo</code>.
❌ <b>A, B, C, D,</b> and <b>E</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(117, 'A', 'An exception is thrown at runtime', 0),
(117, 'B', 'With fragment I, compilation fails', 0),
(117, 'C', 'With fragment II, compilation fails', 0),
(117, 'D', 'With fragment I, the output could be <code>yo dude dude yo</code>', 0),
(117, 'E', 'With fragment I, the output could be <code>dude dude yo yo</code>', 0),
(117, 'F', 'With fragment II, the output could be <code>yo dude dude yo</code>', 1);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
118,
9,
'Given:
<code> 3. class Chicks {
 4.   synchronized void yack(long id) {
 5.     for(int x = 1; x &lt; 3; x++) {
 6.       System.out.print(id + " ");
 7.       Thread.yield();
 8.     }
 9.   }
10. }
11. public class ChicksYack implements Runnable {
12.   Chicks c;
13.   public static void main(String[] args) {
14.     new ChicksYack().go();
15.   }
16.   void go() {
17.     c = new Chicks();
18.     new Thread(new ChicksYack()).start();
19.     new Thread(new ChicksYack()).start();
20.   }
21.   public void run() {
22.     c.yack(Thread.currentThread().getId());
23.   }
24. }</code>

Which are true? (Choose all that apply.)',
'✔ <b>F</b> is correct. When <code>run()</code> is invoked, it is with a new instance of <code>ChicksYack</code> and <code>c</code> has
   not been assigned to an object. If <code>c</code> were static, then because <code>yack</code> is synchronized, answers
   <b>C</b> and <b>E</b> would have been correct.
❌ <b>A, B, C, D,</b> and <b>E</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(118, 'A', 'Compilation fails', 0),
(118, 'B', 'The output could be <code>4 4 2 3</code>', 0),
(118, 'C', 'The output could be <code>4 4 2 2</code>', 0),
(118, 'D', 'The output could be <code>4 4 4 2</code>', 0),
(118, 'E', 'The output could be <code>2 2 4 4</code>', 0),
(118, 'F', 'An exception is thrown at runtime', 1);


-- +goose StatementBegin
INSERT INTO question (id, chapter_id, text, explanation) VALUES (
119,
9,
'Given:
<code>3. public class Chess implements Runnable {
4.   public void run() {
5.     move(Thread.currentThread().getId());
6.   }
7.   // insert code here
8.     System.out.print(id + " ");
9.     System.out.print(id + " ");
10.   }
11.   public static void main(String[] args) {
12.     Chess ch = new Chess();
13.     new Thread(ch).start();
14.     new Thread(new Chess()).start();
15.   }
16. }</code>

And given these two fragments:
<code>I.  synchronized void move(long id) {
II. void move(long id) {</code>

When either fragment I or fragment II is inserted at line 7, which are true? (Choose all that apply.)',
'✔ <b>C</b> and <b>E</b> are correct. <b>E</b> should be obvious. <b>C</b> is correct because even though <code>move()</code> is synchronized, it''s being invoked on two different objects.
❌ <b>A, B,</b> and <b>D</b> are incorrect based on the above.');
-- +goose StatementEnd

INSERT INTO answer (question_id, letter, answer, valid) VALUES
(119, 'A', 'Compilation fails', 0),
(119, 'B', 'With fragment I, an exception is thrown', 0),
(119, 'C', 'With fragment I, the output could be <code>4 2 4 2</code>', 1),
(119, 'D', 'With fragment I, the output could be <code>4 4 2 3</code>', 0),
(119, 'E', 'With fragment II, the output could be <code>2 4 2 4</code>', 1);

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back


