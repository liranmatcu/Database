/* 
    SQL aggregate functions: 
    Count(), Sum(), Avg(), Min(), Max()
*/

USE COMPANY;

# Sum() and Avg()
SELECT SUM(Salary) AS "Total Salary" FROM EMPLOYEE;
SELECT AVG(Salary) "Average Salary" FROM EMPLOYEE;

# Min() and Max()
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
                        FROM EMPLOYEE
                     )
FROM EMPLOYEE;


