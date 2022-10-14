
-- Union
/*
The UNION set operation is used to combine the outputs 
of two or more SELECT statements. This will eliminate duplicates 
from its result set. The number of columns and the datatype must be 
the same in both the tables on which the UNION operation is being used.

SELECT FROM First
UNION
SELECT FROM Second;

*/

USE COMPANY;

/*
Example: 
Find the ssn of all employees
who works on project 20 or project 30.
*/

SELECT Ssn
FROM EMPLOYEE E
JOIN WORKS_ON WO ON E.Ssn = WO.Essn
WHERE Pno = 20
UNION
SELECT Ssn
FROM EMPLOYEE E
JOIN WORKS_ON WO ON E.Ssn = WO.Essn
WHERE Pno = 30;



-- Minus
/*
The Minus set operation combines the results of 
two SELECT statements and returns only those in 
the final result, which belongs to the first set of the result.

SELECT * FROM First
MINUS
SELECT * FROM Second;

MySql does not recognise MINUS and INTERSECT,
these are Oracle based operations.
In MySql a user can use NOT IN or NOT EXISTS as MINUS.

 */


/*
Example:
Find the ssn of all employees
who works on project 20 but not project 30.
*/
SELECT Ssn
FROM EMPLOYEE E
JOIN WORKS_ON WO ON E.Ssn = WO.Essn
WHERE Pno = 20 AND E.Ssn NOT IN
(SELECT Ssn
FROM EMPLOYEE E
JOIN WORKS_ON WO ON E.Ssn = WO.Essn
WHERE Pno = 30);

SELECT Ssn
FROM EMPLOYEE E
JOIN WORKS_ON WO ON E.Ssn = WO.Essn
WHERE Pno = 20
AND NOT EXISTS
    (SELECT 1
    FROM WORKS_ON
    WHERE Pno = 30 AND E.Ssn = Essn);



-- Intersect