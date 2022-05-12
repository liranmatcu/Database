https://medium.com/@chrischuck35/how-to-create-a-mysql-instance-with-docker-compose-1598f3cc1bee




# Start MySQL Database Server container in a terminal
docker-compose up mysql

docker-compose up -d mysql

docker exec -it mysql bash

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