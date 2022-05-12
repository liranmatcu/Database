
# Start MySQL Database Server container in a terminal
docker-compose up -d mysql
(or docker-compose up mysql if you want to view debug info)


# Drop into the mysql container
docker exec -it mysql bash


# Operate mysql database
mysql -u root -p  
(password for root is password)

show databases;

create database TCU;
show databases;
use TCU;

create table STUDENT (
	sid int(7),
	sname varchar(30),
	sdno int(5));

describe STUDENT;


insert into STUDENT values (30, 'John Doe', 20);


select * from STUDENT;



# Reference
https://medium.com/@chrischuck35/how-to-create-a-mysql-instance-with-docker-compose-1598f3cc1bee



# Adminer
docker-compose up -d adminer 
docker-compose up adminer 

http://127.0.0.1:8080
# Default username for MySQL 
root	
# Default password is 
password