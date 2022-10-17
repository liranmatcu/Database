USE COMPANY;

/*
 The ORDER BY keyword is used to sort the
 result-set in ascending or descending order.

 The ORDER BY keyword sorts the records in ascending order by default.
 To sort the records in descending order, use the DESC keyword.

 SELECT column1, column2, ...
 FROM table_name
 ORDER BY column1, column2, ... ASC|DESC;
 */

# ORDER BY c1, c2 ...
SELECT Fname AS "First Name", Lname "Last Name", Salary
FROM EMPLOYEE
ORDER BY Salary;    

SELECT Fname AS "First Name", Lname "Last Name", Salary
FROM EMPLOYEE
ORDER BY Salary DESC;

# Second order
SELECT Fname AS "First Name", Lname "Last Name", Salary
FROM EMPLOYEE
ORDER BY Salary DESC, Lname ASC;

SELECT Fname AS "First Name", Lname "Last Name", Salary
FROM EMPLOYEE 
WHERE Salary BETWEEN 10000 AND 40000 
ORDER BY Salary DESC, Lname DESC;

SELECT Fname AS "First Name", Lname Last_Name, Salary
FROM EMPLOYEE
WHERE Salary BETWEEN 10000 AND 40000
ORDER BY Salary DESC, Last_Name DESC;

/*
 The LIMIT clause is used to specify the number of records to return.

 The LIMIT clause is useful on large tables with thousands of records.
 Returning a large number of records can impact performance.

 LIMIT [number1,] number2
 n1 : starting index
 n2 : number of record/data to show

 Typically, in the end of a SQL statement
 */

SELECT Fname AS "First Name", Lname "Last Name", Salary
FROM EMPLOYEE
WHERE Salary BETWEEN 10000 AND 40000
ORDER BY Salary DESC, Lname ASC
LIMIT 3;

-- LIMIT "0, number" is the same as LIMIT number
SELECT Fname AS "First Name", Lname "Last Name", Salary
FROM EMPLOYEE
WHERE Salary BETWEEN 10000 AND 40000
ORDER BY Salary DESC, Lname ASC
LIMIT 0, 3;

# Exercise
-- Find the employee with the highest salary

# SELECT Fname AS "First Name", Lname "Last Name", Salary
# FROM EMPLOYEE
# ORDER BY Salary DESC
# LIMIT ;


# Other DBMS supports TOP, but not MySQL
SELECT TOP 1 Fname AS "First Name", Lname "Last Name", Salary
FROM EMPLOYEE
ORDER BY Salary DESC;


-- Display the second page
SELECT Fname AS "First Name", Lname "Last Name", Salary
FROM EMPLOYEE
WHERE Salary BETWEEN 10000 AND 40000
ORDER BY Salary DESC, "Last Name" ASC
LIMIT 3, 3;
-- page number = n1/n2 + 1

-- Display the with offset (number1)
SELECT Fname AS "First Name", Lname "Last Name", Salary
FROM EMPLOYEE
WHERE Salary BETWEEN 10000 AND 40000
ORDER BY Salary DESC, "Last Name" ASC
LIMIT 1, 3;


# Exercise
-- Display the 4th and 5th tuples
SELECT Fname AS "First Name", Lname "Last Name", Salary
FROM EMPLOYEE
WHERE Salary BETWEEN 10000 AND 40000
ORDER BY Salary DESC, "Last Name" ASC
LIMIT ?, ?;


# New feature OFFSET
# SELECT Fname AS "First Name", Lname "Last Name", Salary
# FROM EMPLOYEE
# WHERE Salary BETWEEN 10000 AND 40000
# ORDER BY Salary DESC, "Last Name" ASC
# LIMIT 2 OFFSET 3;