-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied

CREATE TABLE IF NOT EXISTS chapter(
    id INTEGER PRIMARY KEY,
    chapter TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS question(
    id INTEGER primary key,
    chapter_id INTEGER NOT NULL,
    text TEXT NOT NULL,
    explanation TEXT
);

CREATE TABLE IF NOT EXISTS answer(
    question_id INTEGER NOT NULL,
    letter text NOT NULL,
    answer TEXT NOT NULL,
    valid INTEGER,
    UNIQUE(question_id, letter)
);

INSERT INTO chapter (id, chapter) VALUES
(1, 'Declarations and Access Control'),
(2, 'Object Orientation'),
(3, 'Assignments'),
(4, 'Operators'),
(5, 'Flow Control, Exceptions, and Assertions'),
(6, 'Strings, I/O, Formatting, and Parsing'),
(7, 'Generics and Collections'),
(8, 'Inner Classes'),
(9, 'Threads'),
(10, 'Development');


-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back

DROP TABLE question;
DROP TABLE answer;
DROP TABLE chapter;
