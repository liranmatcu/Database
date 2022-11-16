USE demo;

/*
Trigger: A trigger is a stored procedure which automatically 
invokes whenever a special event in the database occurs. 
For example, a trigger can be invoked when a row is inserted 
into a specified table or when certain table columns are being updated. 

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
