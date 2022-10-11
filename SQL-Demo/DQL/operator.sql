
-- Arithmetic operators
SELECT 100, 100+1, 100+'1', 100+'a', 100+NULL ;

SELECT 100*2, 100*2.0, 100/2, 100/2.0, 100 DIV 0 ;

SELECT 12%5, 12 MOD -5, -12 MOD -5, -12%5;

USE COMPANY;
SELECT * FROM EMPLOYEE
WHERE Ssn%2 = 1;

-- Comparison operators
SELECT 1='1', 1='a', 0='a', 1=2,1;

SELECT 1=NULL, NULL=NULL;

SELECT Ssn, Super_ssn FROM EMPLOYEE
WHERE Super_ssn = NULL;
# WHERE Super_ssn != NULL;

# WHERE Super_ssn <=> NULL;
# <=> NULL-safe equal. This operator performs
# an equality comparison like the = operator,
# but returns 1 rather than NULL if both operands are NULL,
# and 0 rather than NULL if one operand is NULL.

# WHERE Super_ssn IS NULL ;
# WHERE ISNULL(Super_ssn) ;


SELECT least('a', 'b', 't', 'f' );
SELECT least(Lname,Fname)
FROM EMPLOYEE;