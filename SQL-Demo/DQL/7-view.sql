/*
View:

A view is a virtual table based on the
result-set of an SQL SELECT statement.
A view is created with the CREATE VIEW statement.
    CREATE VIEW view_name
    AS
    SELECT column-1, column-2, ...
    FROM table_name
    WHERE condition;

A view contains rows and columns, just like a table.
But, a view does not store data.

The fields in a view can come from one or more tables;
They are presented as if the data were coming from one single table.
*/

USE COMPANY;


-- Example: create a view from a single table
CREATE VIEW view_emp_1
AS
SELECT Ssn, Lname, Dno, Salary
FROM EMPLOYEE
WHERE Dno = 5;
-- Query from the view
SELECT *
FROM view_emp_1;

-- Delete a view
DROP VIEW IF EXISTS view_emp_1;


-- Example: create a view with different column names
CREATE VIEW view_emp_2
AS
SELECT Ssn "Social Security Number", Lname "Last Name", Salary/12 "Monthly Salary"
FROM EMPLOYEE
WHERE Salary > 30000;

SELECT *
FROM view_emp_2;


-- or
DROP VIEW IF EXISTS view_emp_2;
CREATE VIEW view_emp_2 (Emp_Ssn, `Last Name`, `Monthly Salary`)
AS
SELECT Ssn, Lname, Salary/12
FROM EMPLOYEE
WHERE Salary > 30000;


-- Create view from derived attributes
CREATE VIEW view_emp_3
AS
SELECT Dno Dept_Num, avg(Salary) Ave_Sal
FROM EMPLOYEE
GROUP BY Dno;

SELECT *
FROM view_emp_3;

DROP VIEW IF EXISTS view_emp_3;

-- Example: create a view from multiple tables
CREATE VIEW view_emp_dept (Emp_Name, Dept_Name)
AS
SELECT concat(Fname, ' ', Lname), Dname
FROM EMPLOYEE
JOIN DEPARTMENT D ON D.Dnumber = EMPLOYEE.Dno;

SELECT *
FROM view_emp_dept;


-- Use view to format data
DROP VIEW IF EXISTS view_emp_dept;
CREATE VIEW view_emp_dept
AS
SELECT concat(Fname, ' ', Lname, ' (', Dname, ')') AS "Employee Info"
FROM EMPLOYEE
JOIN DEPARTMENT D ON D.Dnumber = EMPLOYEE.Dno;

-- Example: create view from another view
CREATE VIEW view_emp_4
AS
SELECT view_emp_1.Ssn, view_emp_1.Salary
FROM view_emp_1;

SELECT *
FROM view_emp_4;

-- Example: create view from more than one views
DROP VIEW IF EXISTS view_emp_4;
CREATE VIEW view_emp_4
AS
SELECT view_emp_1.Ssn, view_emp_1.Salary, Ave_Sal
FROM view_emp_1 JOIN view_emp_3 ON Dno = Dept_Num;
# WHERE Salary > view_emp_3.Ave_Sal;

-- Show all the views
SHOW TABLES;
-- Show structure of a view
DESC view_emp_1;
SHOW TABLE STATUS LIKE 'view_emp_1';
SHOW CREATE VIEW view_emp_1;


-- Update a view
SELECT *
FROM view_emp_1;

UPDATE view_emp_1
SET Salary = 30000
WHERE Ssn = 123456789;

-- Does that affect the original table?
SELECT Salary
FROM EMPLOYEE
WHERE Ssn = 123456789;


-- Can we do this?
UPDATE view_emp_3
SET Ave_Sal = 50000
WHERE Dept_Num = 5;

DELETE FROM view_emp_3
WHERE Dept_Num = 5;



/*
 Exercise: P. 27
 Find the ssn of all employees
 who works on project 20 and project 30 simultaneously.

 Design a solution by using views
 */
CREATE VIEW emp_20
AS
SELECT Essn
FROM WORKS_ON
WHERE Pno = 20;

CREATE VIEW emp_30
AS
SELECT Essn
FROM WORKS_ON
WHERE Pno = 30;

SELECT DISTINCT emp_20.Essn
FROM emp_20 JOIN emp_30 e ON emp_20.Essn = e.Essn;


DROP VIEW IF EXISTS emp_20, emp_30;


/*

 Advantages of view:
 1. Query Simplification
 2. Structural Simplicity (e.g., customized presentation)
 3. Security


 Disadvantages of view:
 1. performance degradation
 Because views only create the appearance of a table,
 not a real table, the query processor must translate
 queries against the view into queries against the
 underlying source tables.

 If the view is defined by a complex, multi-table query,
 even simple queries against the view become complicated
 joins that can take a long time to complete.

 2. Update restrictions

 */
