USE COMPANY;

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

# LIMIT [number1,] number2
# Typically, in the end of a SQL statement
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