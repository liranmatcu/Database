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

# Example:
-- Create a trigger before insertion to employee table;
-- terminate insertion if the newly inserted employee's salary
-- is higher than his/her manager's salary

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

/*
 Benefits of triggers:
 - allow basic auditing and validation on insert or update data
 - make sure certain events always happen when data is inserted, updated or deleted
 - implement referential integrity across tables (e.g., like ON DELETE SET NULL)
 */


#  Exercise:
-- Create a trigger that, after inserting a new record to employee table,
-- inserts the same record into the table named employee_backup

# Create an empty table for backup
DROP TABLE IF EXISTS employee_backup;
CREATE TABLE IF NOT EXISTS employee_backup
AS
SELECT employee_id, salary, manager_id
FROM testcompany.employee
WHERE 1 = 2;

DROP TRIGGER IF EXISTS emp_insertion_backup;

DELIMITER //
CREATE TRIGGER emp_insertion_backup
AFTER INSERT ON  employee
FOR EACH ROW
BEGIN
    INSERT INTO employee_backup
        VALUES (NEW.employee_id, NEW.salary, NEW.manager_id);
END //
DELIMITER ;

INSERT INTO employee
VALUES (401, 5000, 205);
-- Verify results
SELECT * FROM employee_backup;

-- Exercise Extension: before deleting a row from the employee table,
-- insert the to-be-deleted row into another backup table (say emp_backup2)
-- Hint: the keyword that represents the deleted tuple would be OLD instead of NEW

DROP TABLE IF EXISTS emp_backup2;
CREATE TABLE IF NOT EXISTS emp_backup2
AS
SELECT employee_id, salary, manager_id
FROM testcompany.employee
WHERE 1 = 2;

DROP TRIGGER IF EXISTS emp_deletion_backup;
DELIMITER //
CREATE TRIGGER emp_deletion_backup
BEFORE DELETE ON employee
FOR EACH ROW
BEGIN
    INSERT INTO emp_backup2
        VALUES (OLD.employee_id, OLD.salary, OLD.manager_id);
END //
DELIMITER ;

-- Test
DELETE FROM employee
WHERE employee_id = 102;
-- Verify
SELECT * FROM emp_backup2;

-- What happens if
DELETE FROM employee;



#  Exercise:
-- Create a trigger that,