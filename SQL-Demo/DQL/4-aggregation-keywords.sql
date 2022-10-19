/*
    SQL aggregate keywords: 
    Group by, Having
*/
-- 

USE COMPANY;


/*
 The GROUP BY statement groups rows that
 have the same values into summary rows.
 The GROUP BY clause returns one row for each group.
 */

SELECT Dno
FROM EMPLOYEE
GROUP BY Dno;
-- In this case, it is similar to distinct
SELECT DISTINCT Dno
FROM EMPLOYEE;

-- Get average salary by department
SELECT Dno, AVG(Salary)
FROM EMPLOYEE
GROUP BY Dno;

-- What will the following return?
SELECT Dno, Fname
FROM EMPLOYEE
GROUP BY Dno;
-- If non-group function items (columns) appear in SELECT
-- they must also appear in GROUP BY; not vice visa

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

SELECT Super_ssn "Supervisor SSN", AVG(Salary) "Average Salary"
FROM EMPLOYEE
WHERE Super_ssn IS NOT NULL
GROUP BY Super_ssn
ORDER BY `Average Salary` DESC;

-- WITH ROLLUP
SELECT Super_ssn "Supervisor SSN", AVG(Salary)
FROM EMPLOYEE
WHERE Super_ssn IS NOT NULL
GROUP BY Super_ssn WITH ROLLUP ;

-- Group by multiple columns
-- Get the average salary by supervisor and department
SELECT Dno, Super_ssn "Supervisor SSN", AVG(Salary)
FROM EMPLOYEE
GROUP BY Dno, Super_ssn;
-- Are the following the same?
SELECT Dno, Super_ssn "Supervisor SSN", AVG(Salary)
FROM EMPLOYEE
GROUP BY Super_ssn, Dno;

-- What are the outputs of the following?
SELECT Dno, Super_ssn "Supervisor SSN", AVG(Salary)
FROM EMPLOYEE
GROUP BY Dno;


# Exercise
-- Find the average salary by department


-- Find the highest salary by department

SELECT Dno,
FROM EMPLOYEE
GROUP BY Dno;


-- Find the total number of employees under
-- each supervisor


SELECT
FROM EMPLOYEE
GROUP BY Super_ssn;

# Super_ssn, count(*)


-- Find the difference between the highest and lowest salary
-- among all employees

SELECT
FROM EMPLOYEE;

# max(Salary) - min(Salary)


-- Find the lowest salary of each supervisor (not null)
-- and the lowest salary needs to be higher than 30000



SELECT
FROM EMPLOYEE
WHERE Super_ssn IS NOT NULL
GROUP BY Super_ssn
HAVING MIN(Salary) > 30000;
# Super_ssn, MIN(Salary)



-- Which department (number) has the most employees?
SELECT Dno, count(*) AS "Num. of Employees"
FROM EMPLOYEE
GROUP BY Dno
ORDER BY `Num. of Employees` DESC
LIMIT 1;


-- Show the highest salary of each department
-- if the highest salary is larger than 35000

-- Would the following work?
SELECT Dno, max(Salary)
FROM EMPLOYEE
WHERE max(Salary) > 35000
GROUP BY Dno;

-- Key point: group functions cannot be used in WHERE
-- due to the order of execution "FWGHSOL"

/*
 The HAVING clause was added to SQL because
 the WHERE keyword cannot be used with aggregate functions.

 HAVING clause enables you to specify conditions that
 filter which group results appear in the results.

 HAVING needs to be used in conjunction with GROUP BY
 */

-- Show the highest salary of each department
-- if the highest salary is larger than 35000
SELECT Dno, max(Salary)
FROM EMPLOYEE
GROUP BY Dno
HAVING max(Salary) > 35000;


-- Further limit on departments: 2~5
SELECT Dno, max(Salary)
FROM EMPLOYEE
WHERE Dno IN (2, 3, 4, 5)
GROUP BY Dno
HAVING max(Salary) > 35000;
-- or
SELECT Dno, max(Salary)
FROM EMPLOYEE
GROUP BY Dno
HAVING max(Salary) > 35000 AND
       Dno IN (2, 3, 4, 5);
-- WHERE is more efficient than HAVING
-- in general due to the order of execution;
-- b/c WHERE filters out results for later processing

-- Exercise

