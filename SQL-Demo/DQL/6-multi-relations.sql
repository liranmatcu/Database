USE COMPANY;

/* The need for query multiple relations.

   Example: Find the names of employees
   who work for the 'Research' department
 */

#  Intuitive approach
SELECT concat(Fname, ' ', Lname)
FROM EMPLOYEE, DEPARTMENT
WHERE Dname = 'Research';
-- Did it work? Why or why not?

-- How you interpret the results?
SELECT *
FROM EMPLOYEE;
SELECT *
FROM DEPARTMENT;
SELECT *
FROM EMPLOYEE, DEPARTMENT;
-- It is called the Cartesian product.

# It is similar to Cross Join
SELECT *
FROM EMPLOYEE
CROSS JOIN DEPARTMENT;

-- How to Fix?
SELECT concat(Fname, ' ', Lname), Dname
FROM EMPLOYEE E, DEPARTMENT D
WHERE Dname = 'Research' AND E.Dno = D.Dnumber;

# Inner Join
SELECT concat(Fname, ' ', Lname), Dname
FROM EMPLOYEE
JOIN DEPARTMENT ON Dnumber = Dno
WHERE Dname = 'Research';
-- or with aliasing
SELECT concat(Fname, ' ', Lname), Dname
FROM EMPLOYEE E
JOIN DEPARTMENT D ON D.Dnumber = E.Dno
WHERE Dname = 'Research';

-- To make sense of the inner join
SELECT *
FROM EMPLOYEE E
JOIN DEPARTMENT D ON D.Dnumber = E.Dno;


# Cross Join
SELECT concat(Fname, ' ', Lname), Dname
FROM EMPLOYEE
CROSS JOIN DEPARTMENT D ON D.Dnumber = EMPLOYEE.Dno
WHERE Dname = 'Research';


# Nested query
SELECT concat(Fname, ' ', Lname)
FROM EMPLOYEE
WHERE Dno = (
            SELECT Dnumber
            FROM DEPARTMENT
            WHERE Dname = 'Research'
            );


# EXISTS Condition
SELECT concat(Fname, ' ', Lname)
FROM EMPLOYEE E
WHERE exists(
    SELECT 1
    FROM DEPARTMENT D
    WHERE D.Dname = 'Research' AND E.Dno = D.Dnumber
    );

/*
 SQL statements that use the EXISTS Condition in MySQL can
 be inefficient since the sub-query is RE-RUN for EVERY row
 in the outer query's table.
 */


SELECT concat(Fname, ' ', Lname), Dname
FROM EMPLOYEE E
JOIN DEPARTMENT D ON D.Dnumber = E.Dno
WHERE Dname = 'Research' AND Lname = 'Wong';


/*
   Task: Show each Employee's name and the
   department name.
 */
-- Erroneous solutions
SELECT concat(Fname, ' ', Lname), Dname
FROM EMPLOYEE, DEPARTMENT;
-- Like a cross join
SELECT concat(Fname, ' ', Lname), Dname
FROM EMPLOYEE
CROSS JOIN DEPARTMENT;

-- How to get the correct results?
SELECT concat(Fname, ' ', Lname), Dname
FROM EMPLOYEE, DEPARTMENT
WHERE EMPLOYEE.Dno = DEPARTMENT.Dnumber;
-- or
SELECT concat(Fname, ' ', Lname), Dname
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.Dno = D.Dnumber;
-- or
SELECT concat(Fname, ' ', Lname), Dname
FROM EMPLOYEE E
CROSS JOIN DEPARTMENT D ON D.Dnumber = E.Dno;

-- Oder the results by Department name
SELECT concat(Fname, ' ', Lname), Dname
FROM EMPLOYEE E
CROSS JOIN DEPARTMENT D ON D.Dnumber = E.Dno
ORDER BY Dname DESC ;

-- and show page by page, with each page of 5 records
SELECT concat(Fname, ' ', Lname), Dname
FROM EMPLOYEE E
CROSS JOIN DEPARTMENT D ON D.Dnumber = E.Dno
ORDER BY Dname DESC
LIMIT 5;

/*
 However, cross join is not a preferred approach.
 */
# Preferred approach: join
SELECT concat(Fname, ' ', Lname), Dname
FROM EMPLOYEE E
JOIN DEPARTMENT D ON D.Dnumber = E.Dno;
# This is inner join


-- Would the following exist solution work?
SELECT concat(Fname, ' ', Lname), Dname
FROM EMPLOYEE
WHERE exists(
    SELECT 1
    FROM DEPARTMENT D
    WHERE D.Dnumber = EMPLOYEE.Dno);




/*
Example:
Retrieve the name of each employee who works on
all the projects controlled by department number 4
*/
SELECT DISTINCT E.Fname, E.Lname, Dno
FROM EMPLOYEE E
JOIN WORKS_ON WO ON E.Ssn = WO.Essn
# JOIN PROJECT P ON P.Pnumber = WO.Pno
WHERE NOT exists(
    SELECT 1
    FROM PROJECT P
    WHERE P.Dnum <> 5 AND P.Pnumber = WO.Pno
    );

-- show those who worked on projects
-- that are managed by dept 4
SELECT Essn, Pno, Dnum
FROM WORKS_ON
JOIN PROJECT P ON P.Pnumber = WORKS_ON.Pno
WHERE Pno IN (
    SELECT P2.Pnumber
    FROM PROJECT P2
    WHERE P2.Dnum = 4
    )
ORDER BY Essn;

-- Find the total number of projects
SELECT count(DISTINCT Pno)
FROM WORKS_ON
JOIN PROJECT P ON P.Pnumber = WORKS_ON.Pno
WHERE Pno IN (
    SELECT P2.Pnumber
    FROM PROJECT P2
    WHERE P2.Dnum = 4
    );

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

-- Exists based solution
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


/*
 P. 27
 Find the ssn of all employees
 who works on project 61/20 and project 62/30 simultaneously.
 */

SELECT L.Essn
FROM (SELECT Essn FROM WORKS_ON WHERE Pno = 20) AS L
JOIN (SELECT Essn FROM WORKS_ON WHERE Pno = 30) AS R
WHERE L.Essn = R.Essn;

SELECT Ssn FROM EMPLOYEE E
JOIN WORKS_ON WO ON E.Ssn = WO.Essn
WHERE Pno = 20 or Pno = 30
-- WHERE Pno = 10 or Pno = 30
GROUP BY (Ssn)
HAVING count(Ssn) >= 2;

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





