/*
Subquery 

A MySQL subquery is a query nested within another query 
such as SELECT, INSERT, UPDATE or DELETE. 

Also, a subquery can be nested within another subquery.

A MySQL subquery is called an inner query while the query 
that contains the subquery is called an outer query. 

A subquery can be used anywhere that expression is used and must be closed in parentheses.

The Outer query is known as Main Query, 
and Inner query is known as Subquery.

*/


USE COMPANY;



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
    WHERE E.Dno = D.Dnumber
    );
-- Nested query in Order By clause
SELECT Dnumber, Dname
FROM DEPARTMENT;