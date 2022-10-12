-- SELECT Basics

USE COMPANY;

-- Basic syntax SELECT ... FROM ...;

-- Select all tuples (*) with all columns/attributes
SELECT * FROM EMPLOYEE;

-- Select all tuples with certain columns/attributes
SELECT Fname, Lname FROM EMPLOYEE;
 

-- Column aliasing
SELECT Fname AS "First Name", Lname AS "Last Name" 
FROM EMPLOYEE;

SELECT Fname "First Name", Lname "Last Name" 
FROM EMPLOYEE;

SELECT Fname FirstName, Lname LastName 
FROM EMPLOYEE;


-- Column concatenation
SELECT CONCAT(Fname, ' ', Lname) AS "Full Name" 
FROM EMPLOYEE;

SELECT CONCAT(Fname, ' ', Lname) AS "Full Name", Salary/12 AS "Monthly Salary" 
FROM EMPLOYEE;


-- Remove duplicates with DISTINCT
SELECT Super_ssn FROM EMPLOYEE;

SELECT DISTINCT Super_ssn FROM EMPLOYEE;

-- Can we do these queries with DISTINCT?
SELECT Dno, DISTINCT Super_ssn FROM EMPLOYEE;

SELECT DISTINCT Super_ssn, Dno FROM EMPLOYEE;

SELECT Super_ssn, Dno FROM EMPLOYEE;


-- Count the number of matching tuples 
SELECT DISTINCT Super_ssn FROM EMPLOYEE;
SELECT COUNT(DISTINCT Super_ssn) FROM EMPLOYEE;
-- Does NULL count? 
-- NULL is not equal to '', ' ', 'NULL', or 0 

SELECT COUNT(DISTINCT ifnull(Super_ssn, 1)) 
FROM EMPLOYEE;



-- Purposes of ``, back-tick, in case of name conflicts
SELECT DISTINCT Super_ssn FROM `EMPLOYEE`;


-- Will the following query generate results? 
SELECT 'The DB Company of Year', '2022', Ssn, Super_ssn, Dno 
FROM EMPLOYEE;

-- Exercise: Get each employee's monthly salary
SELECT Salary AS "Annual Salary" FROM EMPLOYEE;


# SELECT Salary/12 AS "Monthly Salary" FROM EMPLOYEE;


-- Limit
SELECT Salary AS "Annual Salary" FROM EMPLOYEE
LIMIT 0,3;