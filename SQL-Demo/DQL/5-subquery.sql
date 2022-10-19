/*
Subquery 

A subquery is a query nested within another query 
such as SELECT, INSERT, UPDATE or DELETE. 

A subquery must be closed in parentheses.

A subquery is called an inner query while the query 
that contains the subquery is called an outer query. 

Purpose: refine results by recursive filtering
*/


USE COMPANY;

-- Example: Find those whose salary is higher than Wallace's
/*
 Idea:
 First, find find Wallace's salary;
 Then, find those with higher salary
 */
SELECT Salary
FROM EMPLOYEE
WHERE Lname = 'Wallace';

SELECT concat(Fname, ' ', Lname), Salary
FROM EMPLOYEE
WHERE Salary > 43000;

# One-query (subquery) solution
-- Inner query: find find Wallace's salary
-- Outer query: find those with higher salary
SELECT concat(Fname, ' ', Lname), Salary
FROM EMPLOYEE
WHERE Salary > (
    SELECT Salary
    FROM EMPLOYEE
    WHERE Lname = 'Wallace'
    );
/*
 The inner query runs first, and only once (non-correlated).
 The outer query is executed with result from inner query.
 */

# Another solution: self-referencing
SELECT concat(E2.Fname, ' ', E2.Lname), E2.Salary
FROM EMPLOYEE E1, EMPLOYEE E2
WHERE E1.Lname = 'Wallace' AND  E1.Salary < E2.Salary;


-- Example: Find the employee(s) who has the highest salary
SELECT concat(Fname, ' ', Lname), Salary
FROM EMPLOYEE
WHERE Salary = (
    SELECT max(Salary)
    FROM EMPLOYEE
    );


-- Exercise: Find those whose salary is higher than company's average
SELECT concat(Fname, ' ', Lname), Salary
FROM EMPLOYEE
WHERE Salary > (
    SELECT avg(Salary)
    FROM EMPLOYEE
    );

-- Exercise: Find those whose salary is higher than department number 5's average
SELECT concat(Fname, ' ', Lname), Salary
FROM EMPLOYEE
WHERE Salary > (
    SELECT avg(Salary)
    FROM EMPLOYEE
    WHERE Dno = 5
    );


-- Example: Find whose whose salary is higher than their department average
SELECT concat(Fname, ' ', Lname), Salary, E1.Dno
FROM EMPLOYEE E1
WHERE Salary > (
    SELECT avg(Salary)
    FROM EMPLOYEE E2
    WHERE E1.Dno = E2.Dno
    );
-- 
/*
This is also called a "Correlated Subquery" because
the Inner query uses values from Outer query.

A correlated subquery may be executed multiple times, 
precisely once for each row returned by the outer query.
*/

-- Check out the following solution
SELECT concat(Fname, ' ', Lname), Salary, E1.Dno
FROM EMPLOYEE E1, (
    SELECT Dno, avg(Salary) AS ave_salary
    FROM EMPLOYEE
    GROUP BY Dno
    ) AS t_dept_ave_sal
WHERE E1.Salary > t_dept_ave_sal.ave_salary
AND E1.Dno = t_dept_ave_sal.Dno;
# The second table t_dept_ave_sal is a derived table.
# Note that every derived table must have its own alias.


-- Exercise: Find those who have the highest salary in each department
SELECT concat(Fname, ' ', Lname), Dno, Salary
FROM EMPLOYEE E1
WHERE Salary = (
    SELECT max(E2.Salary)
    FROM EMPLOYEE E2
    WHERE E1.Dno = E2.Dno
    );

-- How about the following solution?
SELECT concat(Fname, ' ', Lname), Dno, Salary
FROM EMPLOYEE
WHERE Salary IN (
    SELECT max(Salary)
    FROM EMPLOYEE
    GROUP BY Dno
    );


-- Exercise: Find the SSNs of those who work the longest hours in each project
SELECT Pno, Essn, Hours
FROM WORKS_ON WO1
WHERE Hours = (
    SELECT max(Hours)
    FROM WORKS_ON WO2
    WHERE WO1.Pno = WO2.Pno
    )
ORDER BY Pno;

-- Verify results, check the longest working hours in each project
SELECT Pno, max(Hours)
FROM WORKS_ON
GROUP BY Pno
ORDER BY Pno;


-- Exercise: And also the names of those employees
-- In previous query, we get the SSN not the names.

SELECT Ssn, concat(Fname, ' ', Lname)
FROM EMPLOYEE
WHERE Ssn IN (
                SELECT Essn
                FROM WORKS_ON WO1
                WHERE Hours = (
                    SELECT max(Hours)
                    FROM WORKS_ON WO2
                    WHERE WO1.Pno = WO2.Pno
                    )
    );
-- A subquery can be nested within another subquery.
-- Note that we are sort of connecting two different relations.


-- Exercise: Which department (number) has the most employees?
-- Previous approach using order by and limit
SELECT Dno, count(*) AS "Num. of Employees"
FROM EMPLOYEE
GROUP BY Dno
ORDER BY `Num. of Employees` DESC
LIMIT 1;

-- Need to use the subquery approach
-- Question: how to find the max number of employees by dept number?
-- Answer: Find the number of of employees for each dept, then find max
SELECT count(*)
FROM EMPLOYEE
GROUP BY Dno;

SELECT max(number_of_emps)
FROM (
    SELECT count(*) AS number_of_emps
    FROM EMPLOYEE
    GROUP BY Dno
    ) AS count_table;

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

-- Which department (show its name) has the most employees?
SELECT Dnumber, Dname
FROM DEPARTMENT
WHERE Dnumber = (SELECT Dno
                FROM EMPLOYEE
                GROUP BY Dno
                HAVING count(*) = (
                                    SELECT MAX(number_of_emps)
                                    FROM (
                                        SELECT count(Ssn) AS number_of_emps
                                        FROM EMPLOYEE
                                        GROUP BY Dno
                                        ) AS NE
                                    )
);

SELECT Dnumber, Dname
FROM DEPARTMENT
WHERE Dnumber = (SELECT Dno
                FROM EMPLOYEE
                GROUP BY Dno
                ORDER BY count(Ssn) DESC
                LIMIT 1);



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



