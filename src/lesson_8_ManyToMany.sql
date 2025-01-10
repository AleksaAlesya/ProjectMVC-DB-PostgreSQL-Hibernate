--ManyToMany

DROP TABLE Student_lesson;
DROP TABLE Student;
DROP TABLE Lesson;

CREATE TABLE Student
(
    student_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name       VARCHAR(50) NOT NULL UNIQUE,
    age        INT CHECK ( age > 15 )
);

CREATE TABLE Lesson
(
    lesson_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    title     VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO Student (name, age)
VALUES ('Piter', 18);
INSERT INTO Student (name, age)
VALUES ('Oled', 20);
INSERT INTO Student (name, age)
VALUES ('Evgeny', 18);
INSERT INTO Student (name, age)
VALUES ('Alex', 19);
INSERT INTO Student (name, age)
VALUES ('Sergey', 18);

INSERT INTO Lesson (title)
VALUES ('English');
INSERT INTO Lesson (title)
VALUES ('Espanol');
INSERT INTO Lesson(title)
VALUES ('Russin');
INSERT INTO Lesson(title)
VALUES ('Economic');

--ManyToMany - для этой связи обязательно нужна связующая таблица, где будет составной PRIMARY KEY
CREATE TABLE Student_lesson
(
    student_id INT REFERENCES Student (student_id) NOT NULL,
    lesson_id  INT REFERENCES Lesson (lesson_id)   NOT NULL,
    PRIMARY KEY (student_id, lesson_id)
);

INSERT INTO Student_lesson (student_id, lesson_id)
VALUES (1, 1);
INSERT INTO Student_lesson (student_id, lesson_id)
VALUES (1, 2);
INSERT INTO Student_lesson (student_id, lesson_id)
VALUES (1, 3);
INSERT INTO Student_lesson (student_id, lesson_id)
VALUES (2, 1);
INSERT INTO Student_lesson (student_id, lesson_id)
VALUES (2, 3);
INSERT INTO Student_lesson (student_id, lesson_id)
VALUES (2, 2);
INSERT INTO Student_lesson (student_id, lesson_id)
VALUES (3, 1);

SELECT *
FROM Student_lesson;

SELECT *
FROM Student;

SELECT Student.name, Lesson.title
FROM student
         JOIN Student_lesson on Student.student_id = Student_lesson.student_id
         JOIN Lesson ON Student_lesson.lesson_id = Lesson.lesson_id;
