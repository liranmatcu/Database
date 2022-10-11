CREATE DATABASE IF NOT EXISTS demo;
USE demo;
DROP TABLE IF EXISTS data_type_demo;

CREATE TABLE data_type_demo (
	age INT UNSIGNED COMMENT 'INT type uses 4 bytes to store value, 
	Maximum value unsigned is 4294967295; Maximum value signed is 2147483647',
	-- TINYINT (1 byte), SMALLINT (2 bytes), MEDIUMINT (3 bytes), BIGINT (8 bytes)
    
    gpa FLOAT COMMENT 'Floating-Point Types (Approximate Value). 
    FLOAT uses 4 bytes to represent value.
    No longer need precision and scale',
    -- gpa FLOAT(3,2)
    -- DOUBLE uses 8 bytes to represent value
    
    tuition DECIMAL(6,2) COMMENT 'Fixed-Point Types (Exact Value). 
    Use it when you care about exact precision like money. In the 
    example 6 is precision and 2 is scale',
    
    us_phone_number CHAR(10),
    -- The length can be any value from 0 to 255.
    
    full_name VARCHAR(50),
    -- The length can be specified as a value from 0 to 65,535.
    
    date_of_birth DATE COMMENT 'MySQL retrieves and displays 
    DATE VALUES in YYYY-MM-DD format',
    -- DATETIME YYYY-MM-DD HH:MM:SS
    -- TIME HH:MM:SS
    -- TIMESTAMP has a range of '1970-01-01 00:00:01' UTC to '2038-01-09 03:14:07' UTC.
    
    registered BOOL COMMENT 'It is a TINYINT'
);  
-- DESC data_type_demo;

TRUNCATE TABLE data_type_demo;

INSERT INTO data_type_demo
	VALUES(18, 3.475, 1102.3453, '1234567890', 'John M. Doe', '2000-01-31', True);

INSERT INTO data_type_demo
	VALUES(18, 3.5248, 1102.344, '1234567891', 'H. T.', '1980-01-31', FALSE);

SELECT * FROM data_type_demo;

-- Exceed CHAR(10) length 
INSERT INTO data_type_demo
	VALUES(18, 3.52, 1102.34, '12345678901', 'Annie L. Doe', '2000-01-31', FALSE);

-- Wrong DATE format 
INSERT INTO data_type_demo
	VALUES(18, 3.52, 1102.34, '1234567890', 'Jane Ayers', '01-30-1980', FALSE);
    
INSERT INTO data_type_demo
	VALUES(18, 3.52, 1102.34, '1234567890', 'John Steward', STR_TO_DATE('01-30-1980', '%m-%d-%Y'), FALSE);

-- Year can be fewer than 4 digits 
INSERT INTO data_type_demo
	VALUES(18, 3.52, 1102.34, '1234567890', 'Mike Payne', '18-01-31', FALSE);

INSERT INTO data_type_demo
	VALUES(18, 3.52, 1102.34, '1234567890', 'Mike Payne', '182-01-31', FALSE);

SELECT * FROM data_type_demo;

TRUNCATE TABLE data_type_demo;

-- BOOL takes integer values 
INSERT INTO data_type_demo
	VALUES(18, 3.475, 1102.34, '1234567890', 'John M. Doe', '2000-01-31', 123);


TRUNCATE TABLE data_type_demo;
ALTER TABLE data_type_demo
	MODIFY COLUMN registered BIT;
/* A type of BIT(M) enables storage of M-bit VALUES. M can range from 1 to 64.
if the value M is not specified, the BIT value is defaulted to ‘1’ bit. */

INSERT INTO data_type_demo
	VALUES(18, 3.475, 1102.34, '1234567890', 'John M. Doe', '2000-01-31', 123);
    
INSERT INTO data_type_demo
	VALUES(18, 3.475, 1102.34, '1234567890', 'John M. Doe', '2000-01-31', 0);

INSERT INTO data_type_demo
	VALUES(18, 3.475, 1102.34, '1234567890', 'John M. Doe', '2000-01-31', True);
    
SELECT * FROM data_type_demo;