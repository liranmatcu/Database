CREATE DATABASE HW4;
USE HW4;

CREATE TABLE Publisher(
  NAME VARCHAR(25) PRIMARY KEY,
  phone VARCHAR(10),
  city VARCHAR(20) 
);

CREATE TABLE Book(
ISBN VARCHAR(10) PRIMARY KEY,
title VARCHAR(50),
YEAR INTEGER(4),
published_by VARCHAR(25),
previous_edition VARCHAR(10),
price DECIMAL(10,2),
FOREIGN KEY(published_by) REFERENCES Publisher(NAME),
FOREIGN KEY(previous_edition) REFERENCES Book(ISBN)
);

CREATE TABLE Author(
SSN VARCHAR(9) PRIMARY KEY,
first_name VARCHAR(15),
last_name VARCHAR(15),
address VARCHAR(50),
income DECIMAL(10,2)
);

CREATE TABLE Writes(
aSSN VARCHAR(9),
bISBN VARCHAR(10),
PRIMARY KEY(aSSN, bISBN),
FOREIGN KEY(aSSN) REFERENCES Author(SSN),
FOREIGN KEY(bISBN) REFERENCES Book(ISBN)
);

CREATE TABLE Editor(
SSN VARCHAR(9) PRIMARY KEY,
first_name VARCHAR(15),
last_name VARCHAR(15),
address VARCHAR(50),
salary DECIMAL(10,2),
works_for VARCHAR(25),
book_count INTEGER,
FOREIGN KEY(works_for) REFERENCES Publisher(NAME)
);

CREATE TABLE Edits(
eSSN VARCHAR(9),
bISBN VARCHAR(10),
PRIMARY KEY(eSSN, bISBN),
FOREIGN KEY(eSSN) REFERENCES Editor(SSN),
FOREIGN KEY(bISBN) REFERENCES Book(ISBN)
);

CREATE TABLE Author_Editor(
aeSSN VARCHAR(9) PRIMARY KEY,
hours INTEGER,
FOREIGN KEY(aeSSN) REFERENCES Editor(SSN),
FOREIGN KEY(aeSSN) REFERENCES Author(SSN)
);

INSERT  INTO Publisher(NAME,phone,city) VALUES 
("McGraw Hill", "8175689542", "Fort Worth"),
("Pearson", "8175689666", "OKC"),
("Addison Wesley", "8175689789", "Dallas"),
("O Reiley", "8885961258", "Chicago"),
("Oxford Press", "123456789", "London"),
("ABC", "123456789", "Wichita Falls"),
("Springer", "9852365", "New York");

SELECT * FROM Publisher;

INSERT  INTO Book(ISBN, title, YEAR, published_by, previous_edition, price) VALUES 
("9780073376", "OO Software Engineering", 2014, "McGraw Hill", NULL, 102.5),
("0806666666", "Fundamentals of DB 1", 1992, "ABC", NULL, 82.5),
("0805317481", "Fundamentals of DB 2", 1994, "ABC", "0806666666", 87.5),
("0805317554", "Fundamentals of DB 3", 1999, "ABC", "0805317481", 12.5),
("0321122267", "Fundamentals of DB 4", 2003, "Addison Wesley", "0805317554", 15.5),
("0321369572", "Fundamentals of DB 5", 2008, "Addison Wesley", "0321122267", 162.5),
("0136086209", "Fundamentals of DB 6", 2009, "Pearson", "0321369572", 172.5),
("0133970779", "Fundamentals of DB 7", 2015, "Pearson", "0136086209", 98.3),
("0806666611", "Software Requirements", 2013, "Springer", NULL, 99.5),
("0806666612", "UML Modeling", 2000, "O Reiley", NULL, 89.5),
("0806666614", "Machine Learning 1", 2000, "Addison Wesley", NULL, 109.5),
("0806666613", "Machine Learning 2", 2008, "Addison Wesley", "0806666614", 109.5),
("0806666620", "Big Bang Theory", 1975, "Oxford Press", NULL, 19.5),
("0806666622", "Java Programming", 2008, "Pearson", NULL, 59.5);

INSERT  INTO Author(SSN, first_name, last_name, address, income) VALUES
("123456789", "John", "Smith", "address 1", 20000.5),
("987654321", "Harry", "Potter", "address 2", 25000.5),
("333444555", "Josh", "Doe", "address 3", 20400.5),
("555666888", "Ian", "Goodfellow", "address 4", 70000.5),
("999111555", "Andrew", "Ng", "address 5", 90000.5),
("222333111", "Peter", "Doe", "address 6", 80000.5),
("654987321", "Tom", "Chandler", "address 7", 60000.5);

INSERT INTO Writes(aSSN, bISBN) VALUES
("123456789", "9780073376"),
("123456789", "0133970779"),
("123456789", "0136086209"),
("987654321", "0321369572"),
("333444555", "0321122267"),
("333444555", "0805317554"),
("555666888", "0805317481"),
("555666888", "0806666666"),
("999111555", "0806666611"),
("999111555", "0806666612"),
("999111555", "0806666613"),
("222333111", "0806666614"),
("654987321", "0806666620"),
("654987321", "0806666622"),
("123456789", "0806666622"),
("222333111", "0806666622"),
("987654321", "0806666622"),
("555666888", "0321122267"),
("654987321", "0321122267"),
("999111555", "0321122267"),
("222333111", "0805317554");

INSERT INTO Editor (SSN, first_name, last_name, address, salary, works_for, book_count) VALUES
("913746825", "Ming", "Yao", "address 11", 52369.5, "McGraw Hill", 8),
("520898745", "Tim", "Duncan", "address 11", 52369.5, "Addison Wesley", 9),
("313164649", "Allen", "Iverson", "address 11", 59369.5, "Pearson", 0),
("198503719", "Ray", "Allen", "address 11", 52369.5, "ABC", 1),
("333366996", "Kobe", "Bryant", "address 11", 52369.5, "Oxford Press", 5),
("123456789", "John", "Smith", "address 1", 3000, "McGraw Hill", 1),
("987654321", "Harry", "Potter", "address 2", 3000, "O Reiley", 2),
("555666888", "Ian", "Goodfellow", "address 4", 3000, "Springer", 7),
("222333111", "Peter", "Doe", "address 6", 3000, "Oxford Press", 3),
("999111555", "Andrew", "Ng", "address 5", 3000, "Addison Wesley", 5);

INSERT INTO Edits(eSSN, bISBN) VALUES
("555666888", "9780073376"),
("555666888", "0133970779"),
("555666888", "0136086209"),
("999111555", "0321369572"),
("913746825", "0321122267"),
("520898745", "0805317554"),
("222333111", "0805317481"),
("987654321", "0806666666"),
("999111555", "0806666611"),
("313164649", "0806666612"),
("555666888", "0806666613"),
("123456789", "0806666614"),
("222333111", "0806666620"),
("999111555", "0806666622");

INSERT INTO Author_Editor (aeSSN, hours) VALUES
("123456789", 10),
("987654321", 10),
("555666888", 10),
("999111555", 15),
("222333111", 50);

