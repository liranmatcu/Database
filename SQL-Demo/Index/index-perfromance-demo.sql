CREATE DATABASE idx_demo_db;
USE idx_demo_db;

# Create the student info table
CREATE TABLE `student_info` (
    `id` INT ( 11 ) NOT NULL AUTO_INCREMENT,
    `student_id` INT NOT NULL,
    `name` VARCHAR ( 20 ) DEFAULT NULL,
    `course_id` INT NOT NULL,
    `class_id` INT ( 11 ) DEFAULT NULL,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY ( `id` )
) ENGINE = INNODB AUTO_INCREMENT = 1;

# Create the course table
CREATE TABLE `course` (
    `id` INT ( 11 ) NOT NULL AUTO_INCREMENT,
    `course_id` INT NOT NULL,
    `course_name` VARCHAR ( 40 ) DEFAULT NULL,
    PRIMARY KEY ( `id` )
) ENGINE = INNODB AUTO_INCREMENT = 1;

# To make function creation easier
SELECT @@log_bin_trust_function_creators;
SET GLOBAL log_bin_trust_function_creators = 1;

# A function to create random strings
DELIMITER //
CREATE FUNCTION rand_string ( n INT )
    RETURNS VARCHAR ( 255 )
BEGIN
    DECLARE chars_str VARCHAR ( 100 )
        DEFAULT 'abcdefghijklmnopqrstuvwxyzABCDEFJHIJKLMNOPQRSTUVWXYZ';
    DECLARE return_str VARCHAR ( 255 ) DEFAULT '';
    DECLARE i INT DEFAULT 0;
    WHILE i < n DO
        SET return_str = CONCAT(return_str,
            SUBSTRING( chars_str, FLOOR( 1+RAND ()* 52 ), 1 ));
        SET i = i + 1;
    END WHILE;
    RETURN return_str;
END //
DELIMITER ;


# A function to create random numbers
DELIMITER //
CREATE FUNCTION rand_num ( from_num INT, to_num INT ) RETURNS INT ( 11 )
BEGIN
    DECLARE i INT DEFAULT 0;
    SET i = FLOOR(
        from_num + RAND()*(
            to_num - from_num + 1
        ));
    RETURN i;
END //
DELIMITER ;

# A stored procedure to insert course records
DELIMITER //
CREATE PROCEDURE insert_course (max_num INT)
BEGIN
    DECLARE i INT DEFAULT 0;
    SET autocommit = 0;
    REPEAT
        SET i = i + 1;
        INSERT INTO course (course_id, course_name )
        VALUES (rand_num(10000,10100),
                rand_string(6));
        UNTIL i = max_num
    END REPEAT;
    COMMIT;
END //
DELIMITER ;

# A stored procedure to insert student records
DELIMITER  //
    CREATE PROCEDURE insert_stu ( max_num INT )
    BEGIN
    DECLARE i INT DEFAULT 0;
        SET autocommit = 0;
        REPEAT
            SET i = i + 1;
            INSERT INTO student_info ( course_id, class_id, student_id, NAME )
            VALUES ( rand_num ( 10000, 10100 ),
                    rand_num ( 10000, 10200 ),
                    rand_num ( 1, 200000 ),
                    rand_string ( 6 ));
            UNTIL i = max_num
        END REPEAT;
        COMMIT;
END //
DELIMITER ;


# Call the procedures to populate the two tables
CALL insert_course(100);
CALL insert_stu(1000000);
-- Check how many records inserted
SELECT count(*) FROM student_info;

# Create index on student_id
ALTER TABLE student_info
ADD INDEX idx_stu_id(student_id);
SHOW INDEX FROM student_info;

-- Make the index invisible
ALTER TABLE student_info ALTER INDEX idx_stu_id INVISIBLE ;
SHOW INDEX FROM student_info;

# Query based on student_id without indexing
EXPLAIN SELECT * FROM student_info
WHERE student_id = 123456; # About 763 ms

EXPLAIN SELECT student_id, count(*) FROM student_info
GROUP BY student_id LIMIT 100; # About 3 S 590 ms

EXPLAIN SELECT student_id, count(*) FROM student_info
GROUP BY student_id ORDER BY student_id LIMIT 100; # About 3 S 800 ms

EXPLAIN SELECT DISTINCT(student_id) FROM student_info; # About 350 ms

# Query with indexing on student_id
-- Make the index visible
ALTER TABLE student_info ALTER INDEX idx_stu_id VISIBLE ;
SHOW INDEX FROM student_info;

SELECT * FROM student_info
WHERE student_id = 123456; # About 180 ms

SELECT student_id, count(*) FROM student_info
GROUP BY student_id LIMIT 100; # About 181 ms

SELECT student_id, count(*) FROM student_info
GROUP BY student_id ORDER BY student_id LIMIT 100; # About 180 ms

SELECT DISTINCT(student_id) FROM student_info; # About 180 ms


# More complex scenarios
SELECT student_id, count(*) FROM student_info
GROUP BY student_id
ORDER BY create_time DESC
LIMIT 100; # Should be even longer
-- Need to modify sql_mode to exec the above SQL statement
SELECT @@sql_mode;

-- How to create index?
CREATE INDEX idx_id_time ON student_info(student_id, create_time DESC);
-- Would the following work?
CREATE INDEX idx_time_id ON student_info(create_time DESC, student_id);


# Drop the index
# DROP INDEX idx_stu_id ON student_info;
