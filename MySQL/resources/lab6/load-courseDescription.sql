LOAD DATA LOCAL INFILE "/resources/lab6/coursedescription.dat"
INTO TABLE CourseDescription
FIELDS ENCLOSED BY '"' TERMINATED BY ','
LINES TERMINATED BY '\r\n'
(cno, Title, Credits, Offers);
