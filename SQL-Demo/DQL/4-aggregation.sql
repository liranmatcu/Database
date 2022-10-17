-- SQL aggregate functions: Count(), Sum(), Avg(), Min(), Max()
-- SQL aggregate keywords: Group by, Having

USE COMPANY;

# Sum() and Avg()
SELECT SUM(Salary) AS "Total Salary" FROM EMPLOYEE;
SELECT AVG(Salary) "Average Salary" FROM EMPLOYEE;

# Min(), Max()
SELECT MIN(Salary) AS "Minimum Salary",
       MAX(Salary) "Maximum Salary"
FROM EMPLOYEE;

SELECT max(Lname), min(Fname)
FROM EMPLOYEE;


# COUNT(): count the number of occurrence
SELECT COUNT(Ssn)
FROM EMPLOYEE;

SELECT count(Salary), count(2*Salary)
FROM EMPLOYEE;

SELECT COUNT(*)
FROM EMPLOYEE;

SELECT COUNT(1)
FROM EMPLOYEE;
-- * and 1 return the same results

-- Would 2 change anything?
SELECT COUNT(2)
FROM EMPLOYEE;

-- Does each column return the same result in counting?
SELECT COUNT(Super_ssn)
FROM EMPLOYEE;

-- NULL does not count!

-- What does the following do?
SELECT avg(Salary), sum(Salary)/count(Salary)
FROM EMPLOYEE;

SELECT AVG(Salary) * (
    SELECT count(1)
    FROM EMPLOYEE)
FROM EMPLOYEE;


# Group By and Having
/*
 The GROUP BY clause groups a set of rows
 into a set of summary rows by values of columns or expressions.
 The GROUP BY clause returns one row for each group.
 */
SELECT Dno
FROM EMPLOYEE
GROUP BY Dno;
-- similar to distinct
SELECT DISTINCT Dno
FROM EMPLOYEE;

-- What will return?
SELECT Fname
FROM EMPLOYEE
GROUP BY Dno;

-- Get the average salary by supervisor
SELECT Super_ssn "Supervisor SSN", AVG(Salary)
FROM EMPLOYEE
GROUP BY Super_ssn;

-- How to eliminate those without a supervisor?
SELECT Super_ssn "Supervisor SSN", AVG(Salary)
FROM EMPLOYEE
WHERE Super_ssn IS NOT NULL
GROUP BY Super_ssn;
-- or
SELECT Super_ssn "Supervisor SSN", AVG(Salary)
FROM EMPLOYEE
GROUP BY Super_ssn
HAVING COUNT(*) > 1;


-- Group by multiple columns
-- Get the average salary by supervisor and department
SELECT Dno, Super_ssn "Supervisor SSN", AVG(Salary)
FROM EMPLOYEE
GROUP BY Dno, Super_ssn;
-- Are the the following the same?
SELECT Dno, Super_ssn "Supervisor SSN", AVG(Salary)
FROM EMPLOYEE
GROUP BY Super_ssn, Dno;



# Exercise
-- Find the average salary by department


SELECT Dno, avg(Salary)
FROM EMPLOYEE
GROUP BY Dno;

-- Find the highest salary by department

SELECT Dno, max(Salary)
FROM EMPLOYEE
GROUP BY Dno;

-- Find those who have the highest salary in each department
SELECT concat(Fname, ' ', Lname), Dno, Salary
FROM EMPLOYEE
WHERE Salary IN (
    SELECT max(Salary)
    FROM EMPLOYEE
    GROUP BY Dno
    );

-- Find the longest hours in each project
SELECT max(Hours)
FROM WORKS_ON
GROUP BY Pno;

-- Find those who work the longest hours in each project
SELECT max(Hours)
FROM WORKS_ON
GROUP BY Pno;

SELECT DISTINCT Essn
FROM WORKS_ON
WHERE Hours IN (
    SELECT max(Hours)
    FROM WORKS_ON
    GROUP BY Pno
    );

SELECT concat(Fname, ' ', Lname)
FROM EMPLOYEE
WHERE Ssn IN (
                SELECT DISTINCT Essn
                FROM WORKS_ON
                WHERE Hours IN (
                    SELECT max(Hours)
                    FROM WORKS_ON
                    GROUP BY Pno
                    )
    );



-- Which department has the most employees?
SELECT Dno, count(*) AS "counter"
FROM EMPLOYEE
GROUP BY Dno
ORDER BY counter DESC
LIMIT 1;

SELECT Dno
FROM EMPLOYEE
GROUP BY Dno
ORDER BY count(Dno) DESC
LIMIT 1;

SELECT Dname
FROM DEPARTMENT
WHERE Dnumber = (SELECT Dno
                FROM EMPLOYEE
                GROUP BY Dno
                ORDER BY count(Dno) DESC
                LIMIT 1);