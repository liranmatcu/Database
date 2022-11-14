
# IF, ELSEIF, ELSE
/*
IF condition-1 THEN
   {...statements to execute when condition-1 is TRUE...}

[ ELSEIF condition-2 THEN
   {...statements to execute when condition-1 is FALSE and condition-2 is TRUE...} ]

[ ELSE
   {...statements to execute when both condition-1 and condition-2 are FALSE...} ]

END IF;
*/
-- Example: show category by age in a procedure with IN parameter
DROP PROCEDURE IF EXISTS pif;
CREATE PROCEDURE pif(IN age INT)
BEGIN
    IF age < 18
        THEN SELECT 'Minor';
    ELSEIF age < 60
        THEN SELECT 'Adult';
    ELSE
        SELECT 'Senior';
    END IF;
END;
CALL pif(70);
-- or using a declared variable
DROP PROCEDURE IF EXISTS pif;
CREATE PROCEDURE pif()
BEGIN
    DECLARE age INT DEFAULT 18;
    SET age := 60;

    IF age < 18
        THEN SELECT 'Minor';
    ELSEIF age < 60
        THEN SELECT 'Adult';
    ELSE
        SELECT 'Senior';
    END IF;

END;
CALL pif();

-- Exercise: Write a procedure that takes an employee SSN, 
-- if the employee's salary is less than 20000, increase 5000
DROP PROCEDURE IF EXISTS p_inc_sal;
DELIMITER  //
CREATE PROCEDURE p_inc_sal(IN emp_ssn CHAR(9))
BEGIN
    DECLARE emp_salary DECIMAL(10,2);

    SELECT Salary INTO emp_salary
    FROM EMPLOYEE
    WHERE Ssn = emp_ssn;

    IF emp_salary < 20000
        THEN UPDATE EMPLOYEE SET Salary = Salary + 5000
        WHERE Ssn = emp_ssn;
    END IF;
END //
DELIMITER ;

UPDATE EMPLOYEE
SET Salary = 18000
WHERE Ssn = 453453453;

CALL p_inc_sal('453453453');
SELECT Salary FROM EMPLOYEE
WHERE Ssn = '453453453';



# CASE
/*
CASE
    WHEN condition-1 THEN result-1;
    WHEN condition-2 THEN result-2;
    WHEN condition-N THEN result-N;
    ELSE result;
END CASE;
*/
-- Example: rewrite show category by age in a procedure with IN parameter
DROP PROCEDURE IF EXISTS p_case_age;
CREATE PROCEDURE p_case_age(IN age INT)
BEGIN
    CASE
    WHEN age < 18
        THEN SELECT 'Minor';
    WHEN age < 60
        THEN SELECT 'Adult';
    ELSE
        SELECT 'Senior';
    END CASE ;
END;
CALL p_case_age(10);

-- Example: Which bowl game will a school go?
DROP PROCEDURE IF EXISTS p_case_demo;
CREATE PROCEDURE p_case_demo(IN school VARCHAR(15))
BEGIN
    CASE school
        WHEN 'TCU'
            THEN SELECT 'Dr. Pepper Bowl';
        WHEN 'UT'
            THEN SELECT 'No Idea';
    END CASE;
END;

CALL p_case_demo('TCU');
CALL p_case_demo('UT');



# LOOP
/*
[labelname:] LOOP
   statements
END LOOP [labelname]
*/
-- Example: sum from 1 to 100
DROP PROCEDURE IF EXISTS p_loop_demo;
CREATE PROCEDURE p_loop_demo()
BEGIN
    DECLARE sum INT DEFAULT 0;
    DECLARE counter INT DEFAULT 1;

    sum_loop:LOOP
        SET sum := sum + counter;
        SET counter := counter + 1;
        IF counter > 100 
            THEN LEAVE sum_loop;
        END IF;
    END LOOP sum_loop;
    # sum_loop is the label of the loop

    SELECT sum;
END;
CALL p_loop_demo();

# WHILE
/*
[label_name:] WHILE 
condition DO 
  statements_list
END WHILE [label_name]
*/
-- Example: sum from 1 to 100
DROP PROCEDURE IF EXISTS p_while_demo;
CREATE PROCEDURE p_while_demo()
BEGIN
    DECLARE sum INT DEFAULT 0;
    DECLARE counter INT DEFAULT 1;

    sum_while: WHILE counter <= 100 DO
        SET sum := sum + counter;
        SET counter := counter + 1;
    END WHILE sum_while;

    SELECT sum;
END;
CALL p_while_demo();



# REPEAT
/*
[label_name:] REPEAT
    statement
UNTIL search_condition
END REPEAT [label_name]
*/
-- Example: sum from 1 to 100
DELIMITER //
DROP PROCEDURE IF EXISTS p_repeat_demo;
CREATE PROCEDURE p_repeat_demo()
BEGIN
    DECLARE sum INT DEFAULT 0;
    DECLARE counter INT DEFAULT 1;

    REPEAT
        SET sum := sum + counter;
        SET counter := counter + 1;
        UNTIL counter > 100
    END REPEAT;

    SELECT sum;
END //
DELIMITER ;

CALL p_repeat_demo();





