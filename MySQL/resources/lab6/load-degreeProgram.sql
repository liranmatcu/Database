LOAD DATA LOCAL INFILE "/root/lab6_data/degreeprogram.dat"
INTO TABLE DegreeProgram
FIELDS ENCLOSED BY '"' TERMINATED BY ','
LINES TERMINATED BY '\r\n';
