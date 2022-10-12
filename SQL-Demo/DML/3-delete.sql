USE demo;

SELECT * FROM iud_demo;

/* DELETE syntax:

   DELETE FROM Table
   [WHERE conditions]
*/

-- DELETE tuples that meet certain conditions
DELETE FROM iud_demo 
WHERE id = 19;
	
SELECT * FROM iud_demo;

-- What happens of there is no WHERE conditions?
DELETE FROM iud_demo;

SELECT * FROM iud_demo;

-- Would this work?
DELETE FROM upcompany.department
WHERE department_id = 80;

# Exercise
DROP TABLE IF EXISTS emp3;
CREATE TABLE IF NOT EXISTS emp3 AS
    SELECT * FROM upcompany.employee;
SELECT * FROM emp3;
-- Delete all tuples whose department id is 80
-- and salary is higher than 8000


# ON DELETE CASCADE vs. SET NULL
DROP TABLE IF EXISTS dept3;
CREATE TABLE IF NOT EXISTS dept3 AS
    SELECT * FROM upcompany.department;
SELECT * FROM dept3;

ALTER TABLE dept3
    ADD PRIMARY KEY (department_id);

-- CASCADE on deletion
ALTER TABLE emp3
ADD CONSTRAINT emp3_fk_1
    FOREIGN KEY (department_id) REFERENCES dept3(department_id)
    ON DELETE CASCADE;
# emp3 is the child table and dept3 is the parent table

ALTER TABLE emp3
DROP CONSTRAINT emp3_fk_1;

SELECT * FROM emp3
WHERE department_id = 10;

SELECT DISTINCT department_id FROM dept3;
DELETE FROM dept3
WHERE department_id = 10;

SELECT * FROM emp3
WHERE department_id = 10;
SELECT * FROM emp3
WHERE employee_id = ;


-- SET NULL on deletion
ALTER TABLE emp3
ADD CONSTRAINT emp3_fk_1
    FOREIGN KEY (department_id) REFERENCES dept3(department_id)
    ON DELETE SET NULL;
SHOW CREATE TABLE emp3;

SELECT last_name FROM emp3
WHERE department_id = 30;

DELETE FROM dept3
WHERE department_id = 30;

SELECT last_name FROM emp3
WHERE department_id IS NULL;

# SET DEFAULT not supported by MySQL

-- If you don't want changes to be committed automatically
# SET AUTOCOMMIT = FALSE;
