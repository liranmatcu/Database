USE COMPANY;

/* The need for query multiple relations.
   Example: Find the names of employees
   who work for the Research department
 */
SELECT concat(Fname, ' ', Lname)
FROM EMPLOYEE E
JOIN DEPARTMENT D ON D.Dnumber = E.Dno
WHERE Dname = 'Research';

-- Nested query
SELECT concat(Fname, ' ', Lname)
FROM EMPLOYEE
WHERE Dno = (
            SELECT Dnumber
            FROM DEPARTMENT
            WHERE Dname = 'Research'
            );

# EXISTS Condition
SELECT concat(Fname, ' ', Lname)
FROM EMPLOYEE
WHERE exists(
    SELECT 1
    FROM DEPARTMENT
    WHERE Dname = 'Research'
    );

/*
 SQL statements that use the EXISTS Condition in MySQL
 are very inefficient since the sub-query is RE-RUN for EVERY row
 in the outer query's table.
 There are more efficient ways to write most queries,
 that do not use the EXISTS Condition.
 */

/* The need for query multiple relations.
   Example: Select each Employee's name and the
   department name.
 */

SELECT concat(Fname, ' ', Lname), Dname
FROM EMPLOYEE, DEPARTMENT;

# How to make sense of the results?
SELECT count(*)
FROM EMPLOYEE, DEPARTMENT;
SELECT count(*)
FROM EMPLOYEE;
SELECT count(*)
FROM DEPARTMENT;
# This is called Cartesian product

# Like a cross join
SELECT concat(Fname, ' ', Lname), Dname
FROM EMPLOYEE
CROSS JOIN DEPARTMENT;

# How to get the correct results?
SELECT concat(Fname, ' ', Lname), Dname
FROM EMPLOYEE, DEPARTMENT
WHERE EMPLOYEE.Dno = DEPARTMENT.Dnumber;
# or
SELECT concat(Fname, ' ', Lname), Dname
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.Dno = D.Dnumber;
# or
SELECT concat(Fname, ' ', Lname), Dname
FROM EMPLOYEE E
CROSS JOIN DEPARTMENT D ON D.Dnumber = E.Dno;

# Oder the results by Department name
SELECT concat(Fname, ' ', Lname), Dname
FROM EMPLOYEE E
CROSS JOIN DEPARTMENT D ON D.Dnumber = E.Dno
ORDER BY Dname DESC ;

# and show page by page, with each page of 5 records
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


# Other approaches
SELECT concat(Fname, ' ', Lname)
FROM EMPLOYEE
WHERE exists(
    SELECT 1 FROM DEPARTMENT D
             WHERE D.Dnumber = EMPLOYEE.Dno);

/*
 SQL statements that use the EXISTS Condition in MySQL
 are very inefficient since the sub-query is RE-RUN for EVERY row
 in the outer query's table.
 There are more efficient ways to write most queries,
 that do not use the EXISTS Condition.
 */


-- Nested query


/*
 P. 27
 Find the ssn of all employees
 who works on project 61/20 and project 62/30 simultaneously.
 */

SELECT L.Essn
FROM (SELECT Essn FROM WORKS_ON WHERE Pno = 10) AS L
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









#
# USE upcompany;
#
# SELECT last_name, department_name, employee.department_id
# FROM employee, department;
#
# SELECT last_name, department_name, employee.department_id
# FROM employee, department
# WHERE employee.department_id = department.department_id;