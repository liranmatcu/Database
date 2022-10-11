CREATE DATABASE IF NOT EXISTS demo;
USE demo;

DROP TABLE IF EXISTS user;
CREATE TABLE user (
    uid INT PRIMARY KEY AUTO_INCREMENT,
    -- Auto-increment allows a unique number to be
    -- generated automatically when a new record is
    -- inserted into a table.

    uname VARCHAR(50) NOT NULL UNIQUE,

    age INT,
    CHECK ( age >= 10 and age <= 150 ),
    -- The CHECK constraint is used to limit
    -- the value range that can be placed in a column.

    reg_status VARCHAR(1) DEFAULT ('0')
    /*
    The DEFAULT constraint is used to set a default value for a column.
    The default value will be added to all new records,
    if no other value is specified.
    */
);
DESC user;
SHOW CREATE TABLE user;

-- uid AUTO_INCREMENT examples
INSERT INTO user (uname, age)
	VALUES('Jay Kay', 26);
    -- What is the default start value for AUTO_INCREMENT?
SELECT * FROM user;
SELECT LAST_INSERT_ID();
# By default, the starting value for AUTO_INCREMENT is 1,
# and it will increment by 1 for each new record.

# Insert with a user-defined ID
INSERT INTO user 
	VALUES(20, 'Bruce Lee', 25, '1');
SELECT * FROM user;

INSERT INTO user (uname, age)
	VALUES('Jack Staples', 25);
	-- Which number would be John's uid?
SELECT * FROM user;


# Change the current AUTO_INCREMENT value
ALTER TABLE user AUTO_INCREMENT = 101;
INSERT INTO user (uname, age)
	VALUES('John Junior', 25);
	-- Which number would be John's uid?
SELECT * FROM user;

-- Can you insert a tuple with a lower but unused uid?
INSERT INTO user (uid, uname, age)
	VALUES(40, 'Super Frog', 20);
SELECT * FROM user;

# Can you set AUTO_INCREMENT to a lower value?
ALTER TABLE user AUTO_INCREMENT = 50;
INSERT INTO user (uname, age)
	VALUES('John II', 20);
SELECT * FROM user;
# For InnoDB you cannot set the auto_increment value
# lower or equal to the highest current index.
# You need to change your engine from InnoDB to MyISAM.

INSERT INTO user 
	VALUES(1000, 'Nell Daisy', 25, '1');
SELECT * FROM user;

INSERT INTO user (uname, age)
	VALUES('John III', 20);
-- Which number would be John's uid?
SELECT * FROM user;


INSERT INTO user (uname, age)
	VALUES('', 25);
SELECT * FROM user;

INSERT INTO user (uname, age)
	VALUES('John IV', 35);
SELECT * FROM user;



-- Age limitation constraint
INSERT INTO user (uname, age)
	VALUES('A very senior person', 225);



-- Not null constraint on name
INSERT INTO user (uname, age)
	VALUES(null, 25);
SELECT * FROM user;

-- Would the following "null" values be allowed
INSERT INTO user (uname, age)
    VALUES('null', 25);
SELECT * FROM user;

INSERT INTO user (uname, age)
	VALUES(' ', 25);
SELECT * FROM user;

INSERT INTO user (uname, age)
	VALUES('', 25);
SELECT * FROM user;


-- Char size limit on reg_status
INSERT INTO user 
	VALUES(30, 'Bruce Lee', 25, '10');
    -- Can this tuple be inserted? 
SELECT * FROM user;


-- What happens to AUTO_INCREMENT after deleting all tuples?
SET SQL_SAFE_UPDATES = 0;
DELETE FROM user
WHERE uid >= 1;

INSERT INTO user (uname, age)
	VALUES('John I', 25);
SELECT * FROM user;
SELECT LAST_INSERT_ID();


-- Truncate the table
TRUNCATE TABLE user;
SELECT * FROM user;

INSERT INTO user (uname, age)
	VALUES('John I', 35);
-- What happens to AUTO_INCREMENT after truncating the table?
SELECT * FROM user;
SELECT LAST_INSERT_ID();

ALTER TABLE user AUTO_INCREMENT = 101;
INSERT INTO user 
	VALUES(10, 'Bruce Lee II', 25, '1');
    -- Can we add a user with id < 101?
SELECT * FROM user;
