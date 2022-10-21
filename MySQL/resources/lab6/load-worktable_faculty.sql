LOAD DATA LOCAL INFILE '/root/lab6_data/faculty.dat' 
INTO TABLE worktable_faculty 
FIELDS ENCLOSED BY '"' TERMINATED BY ','
LINES TERMINATED BY '\r\n'
(@col1,@col2,@col3,@col4) SET FacSSNo=@col2,Worksfor=@col4;

UPDATE faculty a
  SET worksfor = (SELECT b.worksfor
               FROM worktable_faculty b
               WHERE a.facssno=b.facssno);