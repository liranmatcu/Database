CREATE DATABASE IF NOT EXISTS demo;
USE demo;

DROP TABLE IF EXISTS t1;
CREATE TABLE IF NOT EXISTS t1(
    c1 INT
);

-- Add a column
ALTER TABLE t1
    ADD COLUMN c2 VARCHAR(10);

DESC t1;

-- Drop a column
ALTER TABLE t1
    DROP COLUMN c1;

ALTER TABLE t1
    ADD COLUMN c1 VARCHAR(20);

ALTER TABLE t1
    DROP COLUMN c1;

-- Add a column at the first position
ALTER TABLE t1
    ADD COLUMN c1 VARCHAR(20) FIRST;

-- Add a column after another column
ALTER TABLE t1
    ADD COLUMN c4 int;
ALTER TABLE t1
    ADD COLUMN c3 int AFTER c2;

-- Add a primary key
ALTER TABLE t1
    ADD PRIMARY KEY (c1);

SHOW CREATE TABLE t1;

-- Can you add a column as a part of the primary key?
ALTER TABLE t1
    ADD COLUMN c3 INT,
    ADD PRIMARY KEY (c3);

-- Drop primary key
ALTER TABLE t1
    DROP PRIMARY KEY;

ALTER TABLE t1
    ADD COLUMN c3 INT,
    DROP PRIMARY KEY,
    ADD PRIMARY KEY (c1, c3);

# Exercise
-- Add a column named c5, and make c1 and c5 the PK
ALTER TABLE t1
    ADD COLUMN c5 INT,
    DROP PRIMARY KEY,
    ADD PRIMARY KEY (c1, c5);

DESC t1;

-- Make only c1 the PK
ALTER TABLE t1
    DROP PRIMARY KEY,
    ADD PRIMARY KEY (c1);

-- Modify a column's attributes
ALTER TABLE t1
    MODIFY COLUMN c1 VARCHAR(30) PRIMARY KEY ;
ALTER TABLE t1
    MODIFY COLUMN c2 VARCHAR(30) NOT NULL ;
DESC t1;

-- Change column name and its attributes
ALTER TABLE t1
	CHANGE c2 GPA DECIMAL(3.2);
DESC t1;



-- Add/Drop a foreign key constraint
CREATE TABLE t2(
    fc1 VARCHAR(30)
);

ALTER TABLE t2
    ADD CONSTRAINT FKtt1
    FOREIGN KEY (fc1) REFERENCES t1(c1);
DESC t2;

SHOW COLUMNS FROM t2;
SHOW CREATE TABLE t2;

ALTER TABLE t2 DROP CONSTRAINT FKtt1;


-- Rename a table
RENAME TABLE t2
    TO t3;

DESC t3;
SHOW TABLES;
DROP TABLE t3;

-- Equivalent
ALTER TABLE t2
    RENAME TO t3;


DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
DROP TABLE IF EXISTS t3;

# DROP vs. TRUNCATE