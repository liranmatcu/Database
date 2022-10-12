-- Filter with conditions, WHERE

USE COMPANY;

-- Basic syntax SELECT ... FROM ... WHERE ...;

# MySQL Comparison Operators: =, <=> <, >, <=, >=, <>
SELECT * FROM EMPLOYEE 
	WHERE Lname = 'Wallace';

-- Does the letter case matter?
SELECT * FROM EMPLOYEE 
	WHERE Lname = 'wallace';
    
    
SELECT Fname AS "First Name", Lname "Last Name", Dno FROM EMPLOYEE
	WHERE Dno = 5;

SELECT Fname AS "First Name", Lname "Last Name", Salary FROM EMPLOYEE WHERE	
	Salary >= 10000;

SELECT Fname AS "First Name", Lname "Last Name", Salary FROM EMPLOYEE WHERE	
	Salary <> 30000;

SELECT Fname AS "First Name", Lname "Last Name", Salary FROM EMPLOYEE WHERE
	Salary != 30000;

# Exercise
-- Select all employees whose monthly salary is less than 3000
SELECT Fname AS "First Name", Salary/12 AS Monthly_Salary
FROM EMPLOYEE
WHERE Salary/12 < 3000;
# Would the following work?
# WHERE Monthly_Salary < 3000;
# ORDER BY Monthly_Salary

# Exercise
-- Select all employees who do not have a supervisor
SELECT Fname AS "First Name", Lname "Last Name", Super_ssn FROM EMPLOYEE
WHERE Super_ssn = NULL;
# WHERE Super_ssn != NULL;
# WHERE Super_ssn <=> NULL;
# WHERE Super_ssn IS NULL ;
# WHERE NOT Super_ssn <=> NULL;
# WHERE Super_ssn IS NOT NULL ;


-- MySQL Logical Operators: AND, OR, NOT, BETWEEN, IN, XOR

-- Range selection 
SELECT Fname AS "First Name", Lname "Last Name", Salary FROM EMPLOYEE WHERE
	Salary >= 30000 AND Salary <= 40000;

SELECT Fname AS "First Name", Lname "Last Name", Salary FROM EMPLOYEE WHERE
	Salary BETWEEN 30000 AND 40000;

SELECT Fname AS "First Name", Lname "Last Name", Salary FROM EMPLOYEE WHERE
	Salary < 30000 OR Salary > 40000;
SELECT Fname AS "First Name", Lname "Last Name", Salary FROM EMPLOYEE WHERE
	Salary NOT BETWEEN 30000 AND 40000;

# Exercise
-- Select the name and salary of those whose
-- salary are not in the range of 25000 and 35000
-- ordered by the salary from low to high

# SELECT concat(Fname, ' ', Fname), Salary
# FROM EMPLOYEE
# WHERE Salary NOT BETWEEN 25000 AND 35000
# ORDER BY Salary;



-- Discrete value search: IN (set), NOT IN (set)
SELECT Fname AS "First Name", Lname "Last Name", Salary FROM EMPLOYEE WHERE
	Salary IN (25000, 30000, 40000); -- in the set specified


# Exercise:
-- Select the first name, last name, and department id of
-- those whose department id is either 1 or 5


SELECT Fname AS "First Name", Lname "Last Name", Dno FROM EMPLOYEE WHERE
	Dno IN (1, 5);
# Would the following work?
SELECT Fname AS "First Name", Lname "Last Name", Dno FROM EMPLOYEE WHERE
	Dno = 1 OR 5;
# How to fix it?

-- those whose department id ranges from 1 to 4
SELECT Fname AS "First Name", Lname "Last Name", Dno FROM EMPLOYEE WHERE
	Dno BETWEEN 1 AND 4;


SELECT DISTINCT (Dno)
FROM EMPLOYEE
ORDER BY Dno;


    
-- XOR
SELECT Fname AS "First Name", Dno, Salary FROM EMPLOYEE WHERE
	Dno = 5 XOR Salary > 30000;
SELECT Fname AS "First Name", Dno, Salary FROM EMPLOYEE WHERE
	Dno = 5 OR Salary > 30000;
SELECT Fname AS "First Name", Dno, Salary FROM EMPLOYEE WHERE
	Dno = 5 AND Salary > 30000;


-- Wild card search: LIKE % _ 
SELECT Fname AS "First Name", Lname "Last Name" FROM EMPLOYEE WHERE
	Fname LIKE "Jo%";

SELECT Fname AS "First Name", Lname "Last Name" FROM EMPLOYEE WHERE
	Fname LIKE "%a%";

# Exercise
-- Select those whose first name contains letter a or m
SELECT Fname AS "First Name", Lname "Last Name" FROM EMPLOYEE WHERE
	Fname LIKE "%a%" AND Fname LIKE "%m%";
-- Would the following work?
SELECT Fname AS "First Name", Lname "Last Name" FROM EMPLOYEE WHERE
	Fname LIKE "%a%m%";
-- If not, how to make it work?
SELECT Fname AS "First Name", Lname "Last Name" FROM EMPLOYEE WHERE
	Fname LIKE "%a%m%" OR Fname LIKE "%m%a%";

 SELECT Fname AS "First Name", Lname "Last Name" FROM EMPLOYEE WHERE
	Fname LIKE "Jo__";   

# Exercise
-- What does the following statement do?
 SELECT Fname AS "First Name", Lname "Last Name" FROM EMPLOYEE WHERE
	Fname LIKE "J___";  

# Exercise
-- Show first name that contains `a` at the third place
SELECT Fname AS "First Name", Lname "Last Name" FROM EMPLOYEE WHERE
	Fname LIKE "__a%";

# Exercise
-- What does the following statement do?
SELECT Fname AS "First Name", Lname "Last Name" FROM EMPLOYEE WHERE
	Lname LIKE "%\_%";


-- Regular expression
SELECT Fname FROM EMPLOYEE
WHERE Fname REGEXP "^R" ;

SELECT Fname FROM EMPLOYEE
WHERE Fname REGEXP "e$" ;

SELECT Fname FROM EMPLOYEE
WHERE Fname REGEXP "[a-z]" ;

# Exercise
-- Select those first name ends with a or s.
#
SELECT Fname
FROM EMPLOYEE
WHERE Fname REGEXP "[as]$";

# . and *

