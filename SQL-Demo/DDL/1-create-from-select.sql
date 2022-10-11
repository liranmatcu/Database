CREATE DATABASE IF NOT EXISTS demo;
USE demo;

# Create a table from a select statement
DROP TABLE IF EXISTS dept2;

CREATE TABLE dept2 AS
    SELECT * FROM COMPANY.DEPARTMENT;

SHOW CREATE TABLE dept2;
DESC dept2;
SELECT * FROM dept2;


-- Select certain columns
DROP TABLE IF EXISTS emp2;
CREATE TABLE emp2 AS
    SELECT Fname, Lname, Ssn, Dno
    FROM COMPANY.EMPLOYEE;

SHOW CREATE TABLE emp2;
DESC emp2;
SELECT * FROM emp2;


/*
Generated columns (also sometimes called "computed columns")
A generated column is a special column that is always computed from other columns.
 */
DROP TABLE IF EXISTS triangle;
CREATE TABLE IF NOT EXISTS triangle (
  sidea DOUBLE,
  sideb DOUBLE,
  sidec DOUBLE GENERATED ALWAYS AS (SQRT(sidea * sidea + sideb * sideb)) VIRTUAL
);
INSERT INTO triangle (sidea, sideb)
VALUES (1, 2), (3, 4), (6, 8);
SELECT * FROM triangle;

UPDATE triangle
SET sidea = 2
WHERE sideb = 2;

UPDATE triangle
SET sidec = 6
WHERE sidea = 2;
