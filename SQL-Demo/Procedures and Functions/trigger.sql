USE demo;

/*
Trigger: A trigger is a stored procedure which automatically 
invokes whenever a special event in the database occurs. 

For example, a trigger can be invoked when a row is inserted 
into a specified table or when certain table columns are being updated. 

Syntax: 
create trigger [trigger_name] 
[before | after]  
{insert | update | delete}  
on [table_name]  
[for each row]  
[trigger_body] 
*/

# Prep work
DROP TABLE IF EXISTS test_trigger;
DROP TABLE IF EXISTS test_trigger_log;

CREATE TABLE IF NOT EXISTS test_trigger (
    tid INT PRIMARY KEY AUTO_INCREMENT,
    t_note VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS test_trigger_log (
    lid INT PRIMARY KEY AUTO_INCREMENT,
    t_log VARCHAR(100)
)

SELECT * FROM test_trigger;
SELECT * FROM test_trigger_log;

# Create a trigger before insertion to test_trigger table
DELIMITER //
CREATE TRIGGER before_insertion_test_trigger
BEFORE INSERT ON  test_trigger
FOR EACH ROW
BEGIN
    INSERT INTO test_trigger_log(t_log)
    VALUES ('Before inserting a new row in test_trigger');
END //
DELIMITER ;

-- View existing triggers
SHOW TRIGGERS;
SHOW CREATE TRIGGER before_insertion_test_trigger;

INSERT INTO test_trigger(t_note)
VALUES ('First record');

SELECT * FROM test_trigger;
SELECT * FROM test_trigger_log;



# Create a trigger after insertion to test_trigger table
DELIMITER //
CREATE TRIGGER after_insertion_test_trigger
AFTER INSERT ON  test_trigger
FOR EACH ROW
BEGIN
    INSERT INTO test_trigger_log(t_log)
    VALUES ('After inserting a new row in test_trigger');
END //
DELIMITER ;

INSERT INTO test_trigger(t_note)
VALUES ('Second record');

SELECT * FROM test_trigger;
SELECT * FROM test_trigger_log;

-- Delete triggers
DROP TRIGGER IF EXISTS before_insertion_test_trigger;
DROP TRIGGER IF EXISTS after_insertion_test_trigger;

-- Exercise/Exercise: Create a trigger before insertion to employee table
-- terminate insertion if the newly inserted employee's salary is higher than his/her manager

CREATE TABLE IF NOT EXISTS employee
AS
SELECT employee_id, salary, manager_id
FROM testcompany.employee;

DROP TRIGGER IF EXISTS before_insertion_employee;

DELIMITER //
CREATE TRIGGER before_insertion_employee
BEFORE INSERT ON  employee
FOR EACH ROW
BEGIN
    DECLARE mgr_salary DOUBLE;

    SELECT salary INTO mgr_salary
    FROM employee WHERE employee_id = NEW.manager_id;

    IF NEW.salary > mgr_salary
        THEN SIGNAL SQLSTATE 'HY000'
        SET MESSAGE_TEXT = 'Salary higher than the manger';
    END IF;
END //
DELIMITER ;

-- Test
INSERT INTO employee
VALUES (301, 15000, 205);







