
# Create company DB tables
source /resources/company-db/csv/schema-only.sql

# Enable load from local file
SET GLOBAL local_infile=1;
exit


# Log in again with loading local file privileges
mysql --local-infile=1 -u root -p

# Do not check foreign keys
SET FOREIGN_KEY_CHECKS=0;

USE company;
LOAD DATA LOCAL INFILE '/resources/company-db/csv/employee.csv' 
INTO TABLE employee
FIELDS TERMINATED BY ',' 
ENCLOSED BY '\"'
ESCAPED BY '\"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


LOAD DATA LOCAL INFILE '/resources/company-db/csv/department.csv' 
INTO TABLE department
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


LOAD DATA LOCAL INFILE '/resources/company-db/csv/project.csv' 
INTO TABLE project
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

