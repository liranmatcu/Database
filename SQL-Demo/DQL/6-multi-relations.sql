USE COMPANY;

/* The need for query multiple relations.

   Example: Find the names of employees
   who work for the 'Research' department
 */

#  Intuitive approach
SELECT concat(Fname, ' ', Lname)
FROM EMPLOYEE, DEPARTMENT
WHERE Dname = 'Research';
-- Did the results make sense?

-- How to interpret the results?
SELECT *
FROM EMPLOYEE;

SELECT *
FROM DEPARTMENT;

SELECT *
FROM EMPLOYEE, DEPARTMENT;
-- It is called the Cartesian product,
-- which is similar to a Cross Join
SELECT *
FROM EMPLOYEE
CROSS JOIN DEPARTMENT;

-- How to fix the problem?
-- Solution 1: implicit join
SELECT concat(Fname, ' ', Lname), Dname
FROM EMPLOYEE E, DEPARTMENT D
WHERE Dname = 'Research' AND E.Dno = D.Dnumber;
/*
 Implicit Join: simply lists the tables for joining
 (in the FROM clause of the SELECT statement),
 using commas to separate them
 and WHERE clause to apply to join predicates.

 It performs a CROSS JOIN.
 It can be difficult to understand and more prone to errors.
 */
# Cross Join
SELECT concat(Fname, ' ', Lname), Dname
FROM EMPLOYEE
CROSS JOIN DEPARTMENT D ON D.Dnumber = EMPLOYEE.Dno
WHERE Dname = 'Research';


# Solution 2: Inner Join
SELECT concat(Fname, ' ', Lname), Dname
FROM EMPLOYEE
JOIN DEPARTMENT ON Dnumber = Dno
WHERE Dname = 'Research';

-- Inner Join or with aliasing
SELECT concat(Fname, ' ', Lname), Dname
FROM EMPLOYEE E
JOIN DEPARTMENT D ON D.Dnumber = E.Dno
WHERE Dname = 'Research';
-- Alias leads to less ambiguity, and better optimization
-- Once introduced, original name no longer can be used.

-- To make sense of the inner join
SELECT *
FROM EMPLOYEE E
JOIN DEPARTMENT D ON D.Dnumber = E.Dno;


# Solution 3: Nested query
SELECT concat(Fname, ' ', Lname)
FROM EMPLOYEE
WHERE Dno = (
            SELECT Dnumber
            FROM DEPARTMENT
            WHERE Dname = 'Research'
            );

# Solution 4: EXISTS operator in a correlated query
SELECT concat(Fname, ' ', Lname)
FROM EMPLOYEE E
WHERE exists(
    SELECT *
    FROM DEPARTMENT D
    WHERE D.Dname = 'Research'
      AND E.Dno = D.Dnumber
    );
/*
 The EXISTS operator is used to
 test for the existence of any record in a subquery.

 The EXISTS operator returns TRUE
 if the subquery returns one or more records.

 EXISTS is commonly used with correlated subqueries.
 */


/*
   Exercise:
   Show each employee's name and their department name.
 */

-- Implicit Join
SELECT concat(Fname, ' ', Lname), Dname
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.Dno = D.Dnumber;


# Preferred approach: (inner) join
SELECT concat(Fname, ' ', Lname), Dname
FROM EMPLOYEE E
JOIN DEPARTMENT D ON D.Dnumber = E.Dno;
# JOIN is inner join by default


-- Would the following exist-based solution work?
SELECT concat(Fname, ' ', Lname), Dname
FROM EMPLOYEE
WHERE exists(
    SELECT 1
    FROM DEPARTMENT D
    WHERE D.Dnumber = EMPLOYEE.Dno);


/*
 P. 27
 Find the ssn of all employees
 who works on project 20 and project 30 simultaneously.
 */

SELECT L.Essn
FROM (SELECT Essn FROM WORKS_ON WHERE Pno = 20) AS L
JOIN (SELECT Essn FROM WORKS_ON WHERE Pno = 30) AS R
WHERE L.Essn = R.Essn;

SELECT Ssn
FROM EMPLOYEE E
JOIN WORKS_ON WO ON E.Ssn = WO.Essn
WHERE Pno = 20 or Pno = 30
GROUP BY Ssn
HAVING count(*) = 2;

SELECT Pnumber
FROM PROJECT;

SELECT Pno
FROM WORKS_ON
WHERE Essn = 987654321;

SELECT Essn
FROM WORKS_ON
GROUP BY Essn
HAVING count(Essn) = 2;

/*
P.39
 Find the name of employees who work for Department 5
 but do not work on the project named “Project X”
 */

SELECT DISTINCT Fname, Lname FROM EMPLOYEE E
JOIN DEPARTMENT D ON D.Dnumber = E.Dno
JOIN WORKS_ON WO ON E.Ssn = WO.Essn
JOIN PROJECT P ON P.Pnumber = WO.Pno
WHERE E.Dno = 5 AND P.Pname <> 'Project X'
ORDER BY Lname;

SELECT DISTINCT Fname, Lname FROM EMPLOYEE E
WHERE E.Dno = 5 AND NOT exists(
    SELECT 1 FROM WORKS_ON WO
    JOIN PROJECT P ON P.Pnumber = WO.Pno
    WHERE P.Pname = 'Project X' AND WO.Essn = E.Ssn
    );

SELECT DISTINCT Fname, Lname FROM EMPLOYEE E
WHERE E.Dno = 5 AND NOT exists(
    SELECT 1 FROM WORKS_ON
    JOIN PROJECT P ON P.Pnumber = WORKS_ON.Pno
    WHERE P.Pname = 'Project X'
    );




/*
Example:
Retrieve the name of each employee who works on
all the projects controlled by department number 4
*/

-- Solution 1:
-- Step 1: Find the total number of projects
SELECT count(DISTINCT Pno)
FROM WORKS_ON
JOIN PROJECT P ON P.Pnumber = WORKS_ON.Pno
WHERE Pno IN (
    SELECT P2.Pnumber
    FROM PROJECT P2
    WHERE P2.Dnum = 4
    );
-- Step 2:
SELECT Ssn, Fname, Lname
FROM EMPLOYEE
JOIN WORKS_ON WO ON EMPLOYEE.Ssn = WO.Essn
WHERE Pno IN (
    SELECT DISTINCT Pno
    FROM WORKS_ON
    JOIN PROJECT P ON P.Pnumber = WORKS_ON.Pno
    WHERE Pno IN (
        SELECT P2.Pnumber
        FROM PROJECT P2
        WHERE P2.Dnum = 4
        )
    )
GROUP BY Ssn
HAVING count(*) = 2;


-- Solution 2: Exists operator based
SELECT Ssn, Fname, Lname
FROM EMPLOYEE
WHERE NOT exists (
    SELECT *
    FROM WORKS_ON WO
    WHERE (WO.Pno IN (SELECT Pnumber
                     FROM PROJECT
                     WHERE Dnum = 4)
          AND
          NOT exists(
              SELECT *
              FROM WORKS_ON WO2
              WHERE WO2.Essn = Ssn
                AND WO2.Pno = WO.Pno)
         )
    );

