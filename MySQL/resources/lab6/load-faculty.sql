LOAD DATA LOCAL INFILE "/resources/lab6/faculty.dat"
INTO TABLE Faculty
FIELDS ENCLOSED BY '"' TERMINATED BY ','
LINES TERMINATED BY '\r\n'
(FacName,FacSSNo,OfficeAddress);
