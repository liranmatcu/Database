-- SQL aggregate functions: Count(), Sum(), Avg(), Min(), Max()
-- SQL aggregate keywords: Group by, Having

USE COMPANY;
SELECT * FROM EMPLOYEE;

# COUNT()
SELECT COUNT(*) FROM EMPLOYEE;
SELECT COUNT(1) FROM EMPLOYEE;

SELECT COUNT(Ssn) FROM EMPLOYEE;
SELECT COUNT(Super_ssn) FROM EMPLOYEE;


# Avg(), Min(), Max()
SELECT AVG(Salary) FROM EMPLOYEE;

SELECT MIN(Salary) AS "Minimum Salary" FROM EMPLOYEE;

SELECT MAX(Salary) "Maximum Salary" FROM EMPLOYEE;

# Group By and Having
-- Get the average salary by supervisor
SELECT AVG(Salary), Super_ssn "Supervisor SSN" 
FROM EMPLOYEE
GROUP BY Super_ssn;

-- How to eliminate those without a supervisor?
SELECT AVG(Salary), Super_ssn "Supervisor SSN" 
FROM EMPLOYEE
GROUP BY Super_ssn
HAVING COUNT(*) > 1;
-- or
SELECT AVG(Salary), Super_ssn "Supervisor SSN" 
FROM EMPLOYEE
GROUP BY Super_ssn
HAVING COUNT(1) > 1;


SELECT AVG(Salary), Super_ssn "Supervisor SSN" 
FROM EMPLOYEE
GROUP BY Super_ssn
HAVING COUNT(Ssn) > 1
ORDER BY AVG(Salary);    

# Exercise

-- Find the highest salary in each department
SELECT max(Salary)
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