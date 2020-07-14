-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied

create TABLE IF NOT EXISTS user_result(user_id INTEGER, question_id INTEGER, passed INTEGER);

create TABLE IF NOT EXISTS chapter(id INTEGER, chapter TEXT unique);
insert into chapter (id, chapter) values 
(1, 'Declarations and Access Control'),
(2, 'Object Orientation'),
(3, 'Assignments');

create TABLE IF NOT EXISTS question(id INTEGER primary key, text TEXT, chapter_id INTEGER, comment text);
insert into question (id, text, chapter_id, comment) values (1, 'Which is true? (Choose all that apply.)', 1,
'Answer: C is correct.
A is incorrect because classes implement interfaces, they don''t extend them. B is incorrect
because interfaces only "inherit from" other interfaces. D is incorrect based on the
preceding rules.');

insert into question (id, text, chapter_id, comment) values (2, 
'Given:
<code>public abstract interface Frobnicate { public void twiddle(String s);}</code> 
Which is a correct class? (Choose all that apply.)', 2,
'B is correct, an abstract class need not implement any or all of an interface’s methods.
E is correct, the class implements the interface method and additionally overloads the
twiddle() method.
A is incorrect because abstract methods have no body. C is incorrect because classes
implement interfaces they don’t extend them. D is incorrect because overloading a
method is not implementing it.');
-- +goose StatementBegin
insert into question (id, text, chapter_id, comment) values (3, 'Given:
<code>class CardBoard {
        Short story = 200
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
        }
    }
</code>
When // doStuff is reached, how many objects are eligible for GC?', 3,
'C is correct. Only one CardBoard object (c1) is eligible, but it has an associated Short
wrapper object that is also eligible.
 A, B, D, E, and F are incorrect based on the above.');
-- +goose StatementEnd

create table IF NOT EXISTS answer(letter text, answer TEXT, question_id integer, valid integer);
insert into answer (letter, answer, question_id, valid)
values 
('A','"X extends Y" is correct if and only if X is a class and Y is an interface', 1, 0),
('B','"X extends Y" is correct if and only if X is an interface and Y is a class', 1, 0),
('C','"X extends Y" is correct if X and Y are either both classes or both interfaces', 1, 1),
('D','"X extends Y" is correct for all combinations of X and Y being classes and/or interfaces', 1, 0);

insert into answer (letter, answer, question_id, valid)
values 
('A','public abstract class Frob implements Frobnicate {
public abstract void twiddle(String s) { }
}', 2, 0),
('B','public abstract class Frob implements Frobnicate { }', 2, 1),
('C','public class Frob extends Frobnicate {
public void twiddle(Integer i) { }
}', 2, 0),
('D','public class Frob implements Frobnicate {
public void twiddle(Integer i) { }
}', 2, 0);

insert into answer (letter, answer, question_id, valid)
values 
('A','0', 3, 0),
('B','1', 3, 0),
('C','2', 3, 1),
('D','Compilation fails', 3, 0),
('E','It is not possible to know', 3, 0),
('F','An exception is thrown at runtime', 3, 0);

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back

drop table user_result;
drop table question;
drop table answer;
drop table chapter;
