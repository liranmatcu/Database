LOAD DATA LOCAL INFILE "/root/lab6_data/courseoffering.dat"
INTO TABLE CourseOffering
FIELDS ENCLOSED BY '"' TERMINATED BY ','
LINES TERMINATED BY '\r\n';