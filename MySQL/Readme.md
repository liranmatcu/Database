# Start MySQL database server container
docker-compose up -d mdb
(or docker-compose up mdb if you want to view debug info)

## Drop into the mysql container
docker exec -it mysql bash
mysql -u root -p

<!-- ALTER USER 'superfrog'@'%' IDENTIFIED WITH mysql_native_password BY 'password';
GRANT ALL PRIVILEGES ON tcu.* TO 'superfrog'@'%';
FLUSH PRIVILEGES; -->

# Start phpmyadmin container
docker-compose up phpmyadmin
docker-compose up -d phpmyadmin

## View MySQL server as the superfrog user in a browser
http://127.0.0.1
(Or http://localhost)
Automatically log in as superfrog (or root) user




# Start the Adminer container (similar to phpmyadmin)
docker-compose up -d adminer 
docker-compose up adminer 

http://127.0.0.1:8080
# Default username for MySQL 
root	
# Default password is 
password


# Start SQLPad
docker-compose up sqlpad
sf@tcu.edu (username/email)
frog (password)

# Example mysql commands
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

