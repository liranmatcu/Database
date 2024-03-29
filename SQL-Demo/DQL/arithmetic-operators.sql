
-- Arithmetic operators: +, -, *, /, %

SELECT 100, 100+1, 100+'1', 100+'a', 100+NULL
FROM DUAL;

SELECT 100*2, 100*2.0, 100/2, 100/2.0, 100 DIV 0 ;

SELECT 12%5, 12 MOD -5, -12 MOD -5, -12%5;

USE COMPANY;
# Select monthly salary
SELECT Salary/12 "Monthly Salary" FROM EMPLOYEE;

# Select those whose ssn is odd number
SELECT * FROM EMPLOYEE
WHERE Ssn%2 = 1;








-- MySQL Comparison Operators: =, <=> <, >, <=, >=, <>
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

# SELECT 1 IS NOT NULL, NULL <=> NULL;


/*
 LEAST() function in MySQL is used to find smallest values
 from given arguments respectively.
 If any given value is NULL, it return NULLs.
 Otherwise it returns the smallest value.
 */
SELECT least('a', 'b', 't', 'f' );

SELECT least(Lname, Fname)
FROM EMPLOYEE;

-- GREATEST() function