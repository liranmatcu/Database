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
CREATE TABLE emp3 AS
    SELECT * FROM upcompany.employee;
SELECT * FROM emp3;
-- Delete all tuples whose department id is 80
-- and salary is higher than 8000


-- If you don't want changes to be committed automatically
# SET AUTOCOMMIT = FALSE;
