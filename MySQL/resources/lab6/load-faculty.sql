LOAD DATA LOCAL INFILE "/root/lab6_data/faculty.dat"
INTO TABLE Faculty
FIELDS ENCLOSED BY '"' TERMINATED BY ','
LINES TERMINATED BY '\r\n'
(FacName,FacSSNo,OfficeAddress);
