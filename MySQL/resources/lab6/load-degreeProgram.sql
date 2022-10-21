LOAD DATA LOCAL INFILE "/resources/lab6/degreeprogram.dat"
INTO TABLE DegreeProgram
FIELDS ENCLOSED BY '"' TERMINATED BY ','
LINES TERMINATED BY '\r\n';
