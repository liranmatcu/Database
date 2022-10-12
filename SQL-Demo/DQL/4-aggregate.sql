-- SQL aggregate functions: Count(), Sum(), Avg(), Min(), Max()

USE COMPANY;
SELECT * FROM EMPLOYEE;

# COUNT()
SELECT COUNT(*) FROM EMPLOYEE;
SELECT COUNT(1) FROM EMPLOYEE;

SELECT COUNT(Ssn) FROM EMPLOYEE;
SELECT COUNT(Super_ssn) FROM EMPLOYEE;


# AVG()
SELECT AVG(Salary) FROM EMPLOYEE;

SELECT MIN(Salary) AS "Minimum Salary" FROM EMPLOYEE;

SELECT MAX(Salary) "Maximum Salary" FROM EMPLOYEE;

# Get the average salary by supervisor
SELECT AVG(Salary), Super_ssn "Supervisor SSN" 
FROM EMPLOYEE
GROUP BY Super_ssn;

# How to eliminate those without a supervisor?
SELECT AVG(Salary), Super_ssn "Supervisor SSN" 
FROM EMPLOYEE
GROUP BY Super_ssn
HAVING COUNT(*) > 1;

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