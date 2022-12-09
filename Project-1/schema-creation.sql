DROP DATABASE IF EXISTS bookmanager;

CREATE DATABASE bookmanager;
USE bookmanager;

CREATE TABLE Publisher(  
	name VARCHAR(25) PRIMARY KEY,  
	phone VARCHAR(10), 
	city VARCHAR(20) 
);

CREATE TABLE Book(
	ISBN VARCHAR(10) PRIMARY KEY,
	title VARCHAR(50),
	year INT,
	published_by VARCHAR(25),
	previous_edition VARCHAR(10),
	price FLOAT,
	FOREIGN KEY(published_by) REFERENCES Publisher(name),
	FOREIGN KEY(previous_edition) REFERENCES Book(ISBN)
);

INSERT INTO Publisher(name, phone, city) VALUES 
('McGraw Hill', '8175689542', 'Fort Worth'),
('Pearson', '8175689666', 'OKC'),
('Addison Wesley', '8175689789', 'Dallas'),
('O Reiley', '8885961258', 'Chicago'),
('Oxford Press', '123456789', 'London'),
('ABC', '123456789', 'Wichita Falls'),
('Springer', '9852365', 'New York');

INSERT INTO Book(ISBN, title, year, published_by, previous_edition, price) VALUES 
('9780073376', 'OO Software Engineering', 2014, 'McGraw Hill', NULL, 102.5),
('0806666666', 'Fundamentals of DB 1', 1992, 'ABC', NULL, 82.5),
('0805317481', 'Fundamentals of DB 2', 1994, 'ABC', '0806666666', 87.5),
('0805317554', 'Fundamentals of DB 3', 1999, 'ABC', '0805317481', 12.5),
('0321122267', 'Fundamentals of DB 4', 2003, 'Addison Wesley', '0805317554', 15.5),
('0321369572', 'Fundamentals of DB 5', 2008, 'Addison Wesley', '0321122267', 162.5),
('0136086209', 'Fundamentals of DB 6', 2009, 'Pearson', '0321369572', 172.5),
('0133970779', 'Fundamentals of DB 7', 2015, 'Pearson', '0136086209', 98.3),
('0806666611', 'Software Requirements', 2013, 'Springer', NULL, 99.5),
('0806666612', 'UML Modeling', 2000, 'O Reiley', NULL, 89.5),
('0806666614', 'Machine Learning 1', 2000, 'Addison Wesley', NULL, 109.5),
('0806666613', 'Machine Learning 2', 2008, 'Addison Wesley', '0806666614', 109.5),
('0806666620', 'Big Bang Theory', 1975, 'Oxford Press', NULL, 19.5),
('0806666622', 'Java Programming', 2008, 'Pearson', NULL, 59.5),
('9806667755', 'Java Programming', 2007, 'O Reiley', NULL, 29.5),
('9897756820', 'UML Modeling', 2018, 'ABC', NULL, 289.5);

