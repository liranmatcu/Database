LOAD DATA LOCAL INFILE "/resources/lab6/courseoffering.dat"
INTO TABLE CourseOffering
FIELDS ENCLOSED BY '"' TERMINATED BY ','
LINES TERMINATED BY '\r\n';