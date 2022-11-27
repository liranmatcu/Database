USE COMPANY;

# Stored Procedure
/*
    A stored procedure is a prepared SQL code that you can save, 
    so the code can be reused over and over again.
    
    So if you have an SQL query that you write over and over again, 
    save it as a stored procedure, and then just call it to execute it.
    
    You can also pass parameters to a stored procedure, 
    so that the stored procedure can act based on the parameter value(s) 
    that is passed.
*/


-- Stored Procedure Creation
/*
	CREATE PROCEDURE procedure_name (IN|OUT|INOUT parameters)
	BEGIN
	SQL statements;
	END;
*/
-- Create a procedure without any parameters
-- Example: retrieve the total number of employees
CREATE PROCEDURE p1()
BEGIN
    SELECT count(*)
    FROM EMPLOYEE;
END;
-- Or with a modified delimiter (especially for terminals)
DELIMITER  //
CREATE PROCEDURE p1()
BEGIN
    SELECT count(*)
    FROM EMPLOYEE;
END //
DELIMITER ;


-- Execute a Stored Procedure
/*
	CALL procedure_name;
*/
CALL p1();


-- View p1
SHOW CREATE PROCEDURE p1;
-- or
SHOW PROCEDURE STATUS LIKE 'p1';
-- or 
SELECT *
FROM information_schema.ROUTINES
WHERE ROUTINE_NAME = 'p1';

-- View all existing Stored Procedures
SELECT *
FROM information_schema.ROUTINES
WHERE ROUTINE_SCHEMA = 'COMPANY';


-- Drop a Stored Procedure
/*
	DROP PROCEDURE procedure_name;
*/
DROP PROCEDURE p1;
-- or
DROP PROCEDURE IF EXISTS p1;


# Stored procedure with parameter(s)
/*
Three types/modes of parameters: IN | OUT | INOUT

1. IN is the default mode. When you define an IN parameter in a stored procedure, 
the calling program has to pass an argument to the stored procedure.
A variable passed as mode IN is always read-only. 

2. The value of an OUT parameter can be changed inside 
the stored procedure and its new value is passed back to the calling program.
It is a write-only variable and has no value until the block assigns it a value. 

3. An INOUT parameter is a combination of IN and OUT parameters. 
It means that the calling program may pass the argument, 
and the stored procedure can modify the INOUT parameter, 
and pass the new value back to the calling program.
*/

# IN
-- Create a stored procedure with IN parameters
-- Example: lookup someone's salary by SSN
DROP PROCEDURE IF EXISTS p2;
DELIMITER  //
CREATE PROCEDURE p2(IN emp_ssn CHAR(9))
BEGIN
    SELECT Salary
    FROM EMPLOYEE
    WHERE Ssn = emp_ssn;
END //
DELIMITER ;

-- Call method 1:
CALL p2('453453453');

-- Call method 2: with a user-define variable
SET @essn = '453453453';
CALL p2(@essn);


-- Exercise: create a procedure that 
-- lookup an employee's salary by First Name.
DROP PROCEDURE IF EXISTS get_emp_salary;
DELIMITER  //
CREATE PROCEDURE  get_emp_salary(IN f_name VARCHAR(15))
BEGIN
    SELECT Salary
    FROM EMPLOYEE
    WHERE Fname = f_name;
END //
DELIMITER ;
CALL get_emp_salary('John');


# OUT
-- Create a stored procedure with OUT parameters
DROP PROCEDURE IF EXISTS get_min_salary;
DELIMITER  //
CREATE PROCEDURE  get_min_salary(OUT min_sal DECIMAL(10,2))
BEGIN
    SELECT min(Salary) INTO min_sal
    FROM EMPLOYEE;
END //
DELIMITER ;

CALL get_min_salary(@min_sal);
SELECT @min_sal;

-- Application example
SELECT * FROM EMPLOYEE
WHERE Salary = (SELECT @min_sal);


-- Exercise: create a procedure with IN and OUT that 
-- lookup an employee's salary (OUT) by First Name (IN).
DROP PROCEDURE IF EXISTS get_emp_salary;
DELIMITER  //
CREATE PROCEDURE  get_emp_salary(IN e_f_name VARCHAR(15), OUT sal DOUBLE)
BEGIN
    SELECT Salary INTO sal
    FROM EMPLOYEE
    WHERE Fname = e_f_name;
END //
DELIMITER ;

CALL get_emp_salary('John', @sal);
SELECT @sal;


-- Create a stored procedure with INOUT parameters
-- Show the manager's first name of an employee (by first name)
DROP PROCEDURE IF EXISTS show_mgr_name;
DELIMITER  //
CREATE PROCEDURE  show_mgr_name(INOUT e_f_name VARCHAR(15))
BEGIN
    SELECT Fname INTO e_f_name
    FROM EMPLOYEE
    WHERE Ssn = (
        SELECT Super_ssn FROM EMPLOYEE
        WHERE Fname = e_f_name
        LIMIT 1
        );
END //
DELIMITER ;

-- Call the procedure
SET @emp_first_name := 'John';
CALL show_mgr_name(@emp_first_name);
SELECT @emp_first_name;



# Stored Function
-- Stored Procedure vs. Function
/*
Stored Procedure (SP)                   Function (UDF - User Defined)
SP can return zero, single              Function must return a single value 
or multiple values.                     (which may be a scalar or a table).

Can use transaction in SP.              Cannot use transaction in UDF.

SP can have input/output parameter.     Only input parameter.

Can call function from SP.              Cannot call SP from function.

Cannot use SP in SELECT/ WHERE/         Can use UDF in SELECT/WHERE/HAVING statement.
HAVING statement.
*/

-- Example: replace the above procedure with a stored function.
DROP FUNCTION IF EXISTS fun_show_mgr_name;
DELIMITER  //
CREATE FUNCTION fun_show_mgr_name(e_f_name VARCHAR(15))
RETURNS VARCHAR(15)
    DETERMINISTIC CONTAINS SQL READS SQL DATA
BEGIN
    RETURN(
        SELECT Fname FROM EMPLOYEE
        WHERE Ssn = (
            SELECT Super_ssn FROM EMPLOYEE
            WHERE Fname = e_f_name
            LIMIT 1
            )
        );
END //
DELIMITER ;
-- Call function via select
SELECT fun_show_mgr_name('John');


-- Use a local declared variable in function
DROP FUNCTION IF EXISTS fun_show_mgr_name2;
DELIMITER  //
CREATE FUNCTION fun_show_mgr_name2(e_f_name VARCHAR(15))
RETURNS VARCHAR(15)
    DETERMINISTIC CONTAINS SQL READS SQL DATA
BEGIN
    DECLARE mgr_name VARCHAR(15);

    SELECT Fname INTO mgr_name
    FROM EMPLOYEE WHERE Ssn = (
            SELECT Super_ssn FROM EMPLOYEE
            WHERE Fname = e_f_name
            LIMIT 1
            );

    RETURN mgr_name;
END //
DELIMITER ;
-- Call function via select
SELECT fun_show_mgr_name2('John');


-- Exercise, replace the following procedure with a functions
DELIMITER  //
CREATE PROCEDURE get_min_salary(OUT min_sal DECIMAL(10,2))
BEGIN
    SELECT min(Salary) INTO min_sal
    FROM EMPLOYEE;
END //
DELIMITER ;
-- Function Solution
DELIMITER  //
CREATE FUNCTION fun_get_min_salary()
    RETURNS DOUBLE
    DETERMINISTIC CONTAINS SQL READS SQL DATA
BEGIN
    RETURN (SELECT min(Salary) FROM EMPLOYEE);
END //
DELIMITER ;
SELECT fun_get_min_salary();



# Summary: Stored Procedure vs. View
/*
A Stored Procedure:
    Accepts parameters
    Can NOT be used as building block in a larger query
    Can contain several statements, loops, IF ELSE, etc.
    Can perform modifications to one or several tables
    Can NOT be used as the target of an INSERT, UPDATE or DELETE statement.
    
A View:
    Does NOT accept parameters
    Can be used as building block in a larger query
    Can contain only one single SELECT query
    Can NOT perform modifications to any table
    But can (sometimes) be used as the target of an INSERT, UPDATE or DELETE statement.
*/

# It is hard to debug procedure when it contains complex SQL queries

