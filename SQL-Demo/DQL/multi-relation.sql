USE upcompany;

SELECT last_name, department_name, employee.department_id
FROM employee, department;

SELECT last_name, department_name, employee.department_id
FROM employee, department
WHERE employee.department_id = department.department_id;