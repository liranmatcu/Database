USE demo;
DROP TABLE IF EXISTS iud_demo;

CREATE TABLE iud_demo (
	id INT,
    gpa FLOAT
);  

/* INSERT syntax:

   INSERT INTO Table [c1, c2, ...]
   VALUES (v1, v2, ...)
*/

-- Insert one tuple with all attributes
INSERT INTO iud_demo
	VALUES (19, 3.475);
SELECT * FROM iud_demo;

-- Insert multiple tuples with all attributes
INSERT INTO iud_demo
	VALUES (18, 3.5248),
	       (21, 3.52);
SELECT * FROM iud_demo;


-- Insert one tuple with certain attributes
INSERT INTO iud_demo (id)
	VALUES (18);
SELECT * FROM iud_demo;


INSERT INTO iud_demo (gpa)
VALUES (3.98);

-- Insert from select (query results)
INSERT INTO iud_demo
SELECT *
FROM iud_demo;

INSERT INTO iud_demo (id)
SELECT id
FROM iud_demo
WHERE id = 18;
SELECT * FROM iud_demo;


INSERT INTO iud_demo (id, gpa)
SELECT id, 4.0
FROM iud_demo
WHERE id = 19;
SELECT * FROM iud_demo;