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
 The GROUP BY statement groups rows that
 have the same values into summary rows.
 The GROUP BY clause returns one row for each group.
 */
SELECT Dno
FROM EMPLOYEE
GROUP BY Dno;
-- similar to distinct
SELECT DISTINCT Dno
FROM EMPLOYEE;

SELECT Dno, AVG(Salary)
FROM EMPLOYEE
GROUP BY Dno;

-- What will the following return?
SELECT Dno, Fname
FROM EMPLOYEE
GROUP BY Dno;
-- Non-group function items (columns) in SELECT
-- must appear in GROUP BY

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


-- Find those who have the highest salary in each department
-- Nested query
SELECT concat(Fname, ' ', Lname), Dno, Salary
FROM EMPLOYEE
WHERE Salary IN (
    SELECT max(Salary)
    FROM EMPLOYEE
    GROUP BY Dno
    );

-- Find the longest working hours in each project
SELECT max(Hours)
FROM WORKS_ON
GROUP BY Pno;

-- Find the SSN of those who work the longest hours in each project
SELECT DISTINCT Essn
FROM WORKS_ON
WHERE Hours IN (
    SELECT max(Hours)
    FROM WORKS_ON
    GROUP BY Pno
    );

-- And also the names ...
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

SELECT Dno, count(*) AS "Num. of Employees"
FROM EMPLOYEE
GROUP BY Dno
ORDER BY `Num. of Employees` DESC
LIMIT 1;
-- Another approach
SELECT Dno
FROM EMPLOYEE
GROUP BY Dno
HAVING count(*) = (
    SELECT MAX(num_of_emps)
    FROM (SELECT count(Ssn) AS num_of_emps
        FROM EMPLOYEE
        GROUP BY Dno
        ) AS NE
    );



-- And also select the department name
SELECT Dnumber, Dname
FROM DEPARTMENT
WHERE Dnumber = (SELECT Dno
                FROM EMPLOYEE
                GROUP BY Dno
                ORDER BY count(Ssn) DESC
                LIMIT 1);


# Having
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

-- Would the following work?
SELECT Dno, max(Salary)
FROM EMPLOYEE
WHERE max(Salary) > 35000
GROUP BY Dno;

-- Key point: group functions cannot be used in WHERE
-- due to the order of execution "FWGHSOL"

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

/*
Subquery 

When a query is included inside another query, 
the Outer query is known as Main Query, 
and Inner query is known as Subquery.
*/

-- Find whose whose salary is higher than company's average
SELECT concat(Fname, ' ', Lname), Salary
FROM EMPLOYEE
WHERE Salary > avg(Salary);

SELECT concat(Fname, ' ', Lname), Salary
FROM EMPLOYEE
WHERE Salary > (
    SELECT avg(Salary)
    FROM EMPLOYEE
    );
-- This is also called a Nested Query.
/*
 In Nested Query,
 Inner query runs first, and only once.
 Outer query is executed with result from Inner query.
 Hence, Inner query is used in execution of Outer query.
 */

-- Find whose whose salary is higher than the department
-- Number 5's average
SELECT concat(Fname, ' ', Lname), Salary
FROM EMPLOYEE
WHERE Salary > (
    SELECT avg(Salary)
    FROM EMPLOYEE
    WHERE Dno = 5
    );

-- Find whose whose salary is higher than their department
-- average
SELECT concat(Fname, ' ', Lname), Salary, E1.Dno
FROM EMPLOYEE E1
WHERE Salary > (
    SELECT avg(Salary)
    FROM EMPLOYEE E2
    WHERE E1.Dno = E2.Dno
    );
-- This is also called a Correlated Query where
-- Inner query uses values from Outer query.

-- Check out the following solution
SELECT concat(Fname, ' ', Lname), Salary, E1.Dno
FROM EMPLOYEE E1, (
    SELECT Dno, avg(Salary) AS ave_salary
    FROM EMPLOYEE
    GROUP BY Dno
    ) AS t_dept_ave_sal
WHERE E1.Salary > t_dept_ave_sal.ave_salary
AND E1.Dno = t_dept_ave_sal.Dno;



-- Display employees order by their department name
SELECT Dno, concat(Fname, ' ', Lname), Salary
FROM EMPLOYEE E
ORDER BY (
    SELECT Dname
    FROM DEPARTMENT D
    WHERE E.Dno = D.Dname
    );
-- Nested query in Order By clause