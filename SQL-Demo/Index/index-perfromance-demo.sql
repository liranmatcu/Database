CREATE DATABASE idx_demo_db;
USE idx_demo_db;

# Create the student table
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
        VALUES (rand_num(10000,10100), rand_string(6));
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


# Can the procedures
CALL insert_course(100);
CALL insert_stu(1000000);

SELECT count(*) FROM student_info;

# Query before indexing
SELECT * FROM student_info
WHERE student_id = 123456;

ALTER TABLE student_info
ADD INDEX idx_stu_id(student_id);

# Query after indexing
SELECT * FROM student_info
WHERE student_id = 123456;

DROP INDEX idx_stu_id ON student_info;
