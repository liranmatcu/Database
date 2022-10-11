USE demo;

SELECT * FROM iud_demo
ORDER BY id;

/* UPDATE syntax:

   UPDATE Table
   SET c1, c2, ...
   [WHERE conditions]
*/

-- Update one attribute
UPDATE iud_demo 
SET gpa = 3.99
WHERE id = 21;

SELECT * FROM iud_demo
WHERE id = 19;

-- Update multiple attributes
UPDATE iud_demo 
SET gpa = 3.6, id = 19
WHERE id = 18;
	
SELECT * FROM iud_demo
WHERE id > 10;

-- Update multiple tuples
UPDATE iud_demo
SET gpa = 3.2
WHERE id > 10;


-- What happens of there is no WHERE conditions?
UPDATE iud_demo 
SET gpa = 3.92;

SELECT * FROM iud_demo;

# Add more data in case necessary
# INSERT INTO iud_demo
# VALUES(81, 3.59), (21, 3.12);
# SELECT * FROM iud_demo;


-- Would this update work?
UPDATE upcompany.employee
SET department_id = 1000
WHERE employee_id = 100;