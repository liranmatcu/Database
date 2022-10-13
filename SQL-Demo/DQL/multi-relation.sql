USE COMPANY;

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

# Preferred approach: join
SELECT concat(Fname, ' ', Lname), Dname
FROM EMPLOYEE E
JOIN DEPARTMENT D ON D.Dnumber = E.Dno;
# This is inner join


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