
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


/*
Example: 
Find the ssn of all employees
who works on project 20 or project 30.
*/





-- Intersect


-- Minus
/*
The Minus set operation combines the results of 
two SELECT statements and returns only those in 
the final result, which belongs to the first set of the result.

SELECT * FROM First

MINUS

SELECT * FROM Second;
*/