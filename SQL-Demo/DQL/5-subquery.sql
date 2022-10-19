/*
Subquery 

A subquery is a query nested within another query 
such as SELECT, INSERT, UPDATE or DELETE. 

A subquery must be closed in parentheses.

A subquery is called an inner query while the query 
that contains the subquery is called an outer query. 

*/


USE COMPANY;

-- Find the employee(s) who has the highest salary
SELECT concat(Fname, ' ', Lname), Salary
FROM EMPLOYEE
WHERE Salary = (
    SELECT max(Salary)
    FROM EMPLOYEE
    );
/*
 The inner query runs first, and only once.
 The outer query is executed with result from inner query.
 */


-- Find those whose salary is higher than company's average
SELECT concat(Fname, ' ', Lname), Salary
FROM EMPLOYEE
WHERE Salary > (
    SELECT avg(Salary)
    FROM EMPLOYEE
    );


-- Exercise
-- Find those whose salary is higher than department number 5's average

SELECT concat(Fname, ' ', Lname), Salary
FROM EMPLOYEE
WHERE Salary > (
    SELECT avg(Salary)
    FROM EMPLOYEE
    WHERE Dno = 5
    );


-- Find whose whose salary is higher than
-- their department average
SELECT concat(Fname, ' ', Lname), Salary, E1.Dno
FROM EMPLOYEE E1
WHERE Salary > (
    SELECT avg(Salary)
    FROM EMPLOYEE E2
    WHERE E1.Dno = E2.Dno
    );
-- This is also called a Correlated Query because
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


# Exercise
-- Find those who have the highest salary in each department
SELECT concat(Fname, ' ', Lname), Dno, Salary
FROM EMPLOYEE E1
WHERE Salary = (
    SELECT max(E2.Salary)
    FROM EMPLOYEE E2
    WHERE E1.Dno = E2.Dno
    );
-- How about this solution?
SELECT concat(Fname, ' ', Lname), Dno, Salary
FROM EMPLOYEE
WHERE Salary IN (
    SELECT max(Salary)
    FROM EMPLOYEE
    GROUP BY Dno
    );


-- Find the SSN of those who work the longest hours in each project
SELECT DISTINCT Essn
FROM WORKS_ON
WHERE Hours IN (
    SELECT max(Hours)
    FROM WORKS_ON
    GROUP BY Pno
    );

-- Find the longest working hours in each project
SELECT max(Hours)
FROM WORKS_ON
GROUP BY Pno;

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
-- A subquery can be nested within another subquery.


# Exercise
-- Which department has the most employees?
SELECT Dno, count(*) AS "Num. of Employees"
FROM EMPLOYEE
GROUP BY Dno
ORDER BY `Num. of Employees` DESC
LIMIT 1;
-- Subquery approach
SELECT Dno, count(*) AS "Num. of Employees"
FROM EMPLOYEE
GROUP BY Dno
HAVING count(*) = (
    SELECT MAX(number_of_emps)
    FROM (
        SELECT count(Ssn) AS number_of_emps
        FROM EMPLOYEE
        GROUP BY Dno
        ) AS NE
    );
# Note that every derived table must have its own alias.

-- Subquery in (Order By) clause
-- Display employees ordered by their department name
SELECT Dno, concat(Fname, ' ', Lname), Salary
FROM EMPLOYEE E
ORDER BY (
    SELECT Dname
    FROM DEPARTMENT D
    WHERE E.Dno = D.Dnumber
    );


SELECT Dnumber, Dname
FROM DEPARTMENT;



