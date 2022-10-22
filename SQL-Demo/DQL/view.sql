/*
View:

A view is a virtual table based on the result-set of an SQL statement.

A view contains rows and columns, just like a real table. 
The fields in a view are fields from one or more real tables in the database.

You can add SQL statements and functions to a view and 
present the data as if the data were coming from one single table.

A view is created with the CREATE VIEW statement. 

CREATE VIEW view_name AS
SELECT column-1, column-2, ...
FROM table_name
WHERE condition;

*/

USE COMPANY;


-- Example: create a view from a single table
CREATE VIEW view_emp_1
    AS
SELECT Ssn, Lname, Salary
FROM EMPLOYEE
WHERE Dno = 5;
-- Query from the view
SELECT *
FROM view_emp_1;

-- Example: create a view with different column names
CREATE VIEW view_emp_2
    AS
SELECT Ssn "Social Security Number", Lname "Last Name", Salary/12 "Monthly Salary"
FROM EMPLOYEE
WHERE Salary > 30000;

SELECT *
FROM view_emp_2;

-- Delete a view
DROP VIEW view_emp_2;

-- or
CREATE VIEW view_emp_2 (Emp_Ssn, `Last Name`, `Monthly Salary`)
    AS
SELECT Ssn, Lname, Salary/12
FROM EMPLOYEE
WHERE Salary > 30000;

SELECT *
FROM view_emp_2;

-- Create view from derived attributes
CREATE VIEW view_emp_3
    AS
SELECT Dno Dept_Num, avg(Salary) Ave_Sal
FROM EMPLOYEE
GROUP BY Dno;

SELECT *
FROM view_emp_3;

DROP VIEW view_emp_3;

-- Example: create a view from multiple tables
CREATE VIEW view_emp_dept (Emp_Name, Dept_Name)
AS
SELECT concat(Fname, ' ', Lname), Dname
FROM EMPLOYEE
JOIN DEPARTMENT D ON D.Dnumber = EMPLOYEE.Dno;

SELECT *
FROM view_emp_dept;

DROP VIEW view_emp_dept;
-- Use view to format data
CREATE VIEW view_emp_dept
AS
SELECT concat(Fname, ' ', Lname, ' (', Dname, ')') AS "Employee Info"
FROM EMPLOYEE
JOIN DEPARTMENT D ON D.Dnumber = EMPLOYEE.Dno;

-- Example














