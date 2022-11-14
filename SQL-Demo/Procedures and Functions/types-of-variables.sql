/*
	Types of Variables:
	1. System variables; identified by @@
		* Global 
		* Session

	2. Local/User-defined variables
		* User-defined (session) variables; identified by @
		* Local (declared) variables (Only used as parameters 
		  for stored procedures/functions; within BEGIN and END)
*/

-- System: Global variables
SHOW GLOBAL VARIABLES;
SHOW GLOBAL VARIABLES LIKE 'auto%';
SELECT @@global.autocommit;

-- System: Session variables
SHOW SESSION VARIABLES;
SHOW SESSION VARIABLES LIKE 'auto%';
SELECT @@session.autocommit;

-- Default selection is session
SELECT @@autocommit; 


-- SET changes variable value
SELECT @@global.MAX_CONNECTIONS;
SET GLOBAL MAX_CONNECTIONS = 152;
SET @@global.MAX_CONNECTIONS = 151;

SET SESSION autocommit = 0;
-- or
SET @@session.autocommit = 1;


# User-defined variable
-- Various ways of defining (and assigning) a user-defined variable
SET @myname = 'Super Frog';
-- or
SET @myschool := 'TCU'; -- Better than = 
-- or 
SELECT @myskill := 'SQL';
-- or
SELECT count(*) INTO @empcount1
FROM EMPLOYEE;
-- or
SET @empcount2 := (SELECT count(*)
                   FROM EMPLOYEE);

-- Show the values of user-defined variables
SELECT @myname, @myschool, @myskill, @empcount1, @empcount2;

-- Exercise: what is the output of the following statements?
SET @m1 = 1;
SET @m2 := 2;
SET @sum := @m1 +@m2;
SELECT @sum;



# Local (declared) variable; typically not identified by @
-- Defined by keyword DECLARE immediately after BEGIN
-- It has a data type; default value is NULL
DROP PROCEDURE IF EXISTS plv;
CREATE PROCEDURE plv()
BEGIN
    DECLARE emp_count INT; -- declare a variable

    SELECT count(*)
    INTO emp_count         -- assign value to the variable
    FROM EMPLOYEE;

    SELECT emp_count;
END;
CALL plv();
-- or
DROP PROCEDURE IF EXISTS plv;
CREATE PROCEDURE plv()
BEGIN
    DECLARE emp_count INT DEFAULT 0;

    SET emp_count := (SELECT count(*)
                   FROM EMPLOYEE);

    SELECT emp_count;
END;
CALL plv();

-- What would the following statement return?
SELECT @emp_count;


-- Exercise, show last name and salary of an employee using first name
-- Need to use declared variables in a procedure
DROP PROCEDURE IF EXISTS get_emp_first_salary;
DELIMITER  //
CREATE PROCEDURE get_emp_first_salary(IN e_f_name VARCHAR(15))
BEGIN
    DECLARE last_name VARCHAR(15);
    DECLARE sal DOUBLE;

    SELECT Lname, Salary INTO last_name, sal
    FROM EMPLOYEE
    WHERE Fname = e_f_name;

    SELECT last_name, sal;
END //
DELIMITER ;

CALL get_emp_first_salary('John');


-- Exercise: replace the following user-defined (session) statements
-- with local variables in a procedure
SET @m1 = 1;
SET @m2 := 2;
SET @sum := @m1 +@m2;
SELECT @sum;
-- Solution
DROP PROCEDURE IF EXISTS sum_of_2;
DELIMITER  //
CREATE PROCEDURE sum_of_2()
BEGIN
    DECLARE m1 INT DEFAULT 1;
    DECLARE m2 INT;
    DECLARE the_sum INT DEFAULT 0;

    SET m2 := 2;
    SET the_sum := m1 + m2;

    SELECT the_sum;
END //
DELIMITER ;
CALL sum_of_2();
-- or a shorter solution
DROP PROCEDURE IF EXISTS sum_of_2;
DELIMITER  //
CREATE PROCEDURE sum_of_2()
BEGIN
    DECLARE m1 INT DEFAULT 1;
    DECLARE m2 INT DEFAULT 2;
    SELECT m1 + m2;
END //
DELIMITER ;
CALL sum_of_2();

