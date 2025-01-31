
--OneToOne

DROP TABLE Passport;
DROP TABLE Man;

-- родительская таблица.. чел без паспорта может существовать
CREATE TABLE Man
(
    man_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY ,
    name       VARCHAR(50) NOT NULL ,
    age        INT CHECK ( age > 0 )
);

--дочерняя таблица .. паспорт без чела не может существовать
CREATE TABLE Passport
(
    man_id INT PRIMARY KEY REFERENCES Man (man_id),
    number  INT NOT NULL UNIQUE

);

INSERT INTO Man (name, age) VALUES ('Petrov',25);
INSERT INTO Man (name, age) VALUES ('Sidorov',45);
INSERT INTO Man (name, age) VALUES ('Ivanov',2);
INSERT INTO Man (name, age) VALUES ('Pupkin',90);

INSERT INTO Passport (man_id, number) VALUES (1,12);
INSERT INTO Passport (man_id, number) VALUES (2,124);
INSERT INTO Passport (man_id, number) VALUES (3,145);

SELECT *FROM Passport;
SELECT *FROM Man;


SELECT *FROM Man JOIN Passport on Man.man_id = Passport.man_id;

SELECT *FROM  Man LEFT JOIN Passport  on Man.man_id = Passport.man_id;

SELECT Man.man_id, name, age, number FROM Man LEFT JOIN Passport  on Man.man_id = Passport.man_id