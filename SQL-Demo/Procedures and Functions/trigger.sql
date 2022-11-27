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
DROP TABLE IF EXISTS demo_trigger_table;
DROP TABLE IF EXISTS demo_trigger_table_log;

CREATE TABLE IF NOT EXISTS demo_trigger_table (
    tid INT PRIMARY KEY AUTO_INCREMENT,
    t_note VARCHAR(150)
);

CREATE TABLE IF NOT EXISTS demo_trigger_table_log (
    lid INT PRIMARY KEY AUTO_INCREMENT,
    t_log VARCHAR(150)
)

SELECT * FROM demo_trigger_table;
SELECT * FROM demo_trigger_table_log;

# Create a trigger before insertion to demo_trigger_table table
DELIMITER //
CREATE TRIGGER before_insertion_demo_trigger_table
BEFORE INSERT ON  demo_trigger_table
FOR EACH ROW
BEGIN
    INSERT INTO demo_trigger_table_log(t_log)
    VALUES ('Log Event: Before inserting a new row in demo_trigger_table');
END //
DELIMITER ;

-- View existing triggers
SHOW TRIGGERS;
SHOW CREATE TRIGGER before_insertion_demo_trigger_table;

INSERT INTO demo_trigger_table(t_note)
VALUES ('First record in the demo table');

SELECT * FROM demo_trigger_table;
SELECT * FROM demo_trigger_table_log;



# Create a trigger after insertion to demo_trigger_table table
DELIMITER //
CREATE TRIGGER after_insertion_demo_trigger_table
AFTER INSERT ON  demo_trigger_table
FOR EACH ROW
BEGIN
    SELECT count(*)+1 INTO @num_item FROM demo_trigger_table;
    INSERT INTO demo_trigger_table_log(t_log)
    VALUES (concat('Log Event: After inserting the ',
                    @num_item,
                    'th row in demo_trigger_table'));
END //
DELIMITER ;

INSERT INTO demo_trigger_table(t_note)
VALUES ('Second record');

SELECT * FROM demo_trigger_table;
SELECT * FROM demo_trigger_table_log;

-- Delete triggers
DROP TRIGGER IF EXISTS before_insertion_demo_trigger_table;
DROP TRIGGER IF EXISTS after_insertion_demo_trigger_table;

-- Exercise/Example:
-- Create a trigger before insertion to employee table;
-- terminate insertion if the newly inserted employee's salary
-- is higher than his/her manager

DROP TABLE IF EXISTS employee;
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







