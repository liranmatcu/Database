LOAD DATA LOCAL INFILE "/root/lab6_data/coursedescription.dat"
INTO TABLE CourseDescription
FIELDS ENCLOSED BY '"' TERMINATED BY ','
LINES TERMINATED BY '\r\n'
(cno, Title, Credits, Offers);
