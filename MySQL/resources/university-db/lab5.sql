CREATE DATABASE if not exists university;
USE university;

set foreign_key_checks = 0;

DROP TABLE if exists Department;
DROP TABLE if exists Faculty;
DROP TABLE if exists worktable_faculty;
DROP TABLE if exists DegreeProgram;
DROP TABLE if exists Student;
DROP TABLE if exists Doffers;

set foreign_key_checks = 1;
set sql_safe_updates = 0;

CREATE TABLE Department (
	DeptId VARCHAR(5),
	PRIMARY KEY (DeptId),
	DeptName VARCHAR(20),
	DeptAddress VARCHAR(20),
	Chair VARCHAR(9)
);

CREATE TABLE Faculty (
	FacName VARCHAR(20),
	FacSSNo VARCHAR(9),
	PRIMARY KEY (FacSSNo),
	OfficeAddress VARCHAR(20),
	WorksFor VARCHAR(5),
	FOREIGN KEY (WorksFor) REFERENCES Department (DeptId)
);

ALTER TABLE Department add FOREIGN KEY (Chair) REFERENCES Faculty (FacSSNo);

#The work TABLE for loading. It can be DROPped after loading#
CREATE TABLE worktable_faculty(
	FacSSNo VARCHAR(9),
	PRIMARY KEY (FacSSNo),
	WorksFor VARCHAR(5)
);

CREATE TABLE DegreeProgram(
	ProgId VARCHAR(4),
	PRIMARY KEY (ProgId),
	ProgramName VARCHAR(40),
	ProgType VARCHAR(10),
	Coordinator VARCHAR(9),
	FOREIGN KEY (Coordinator) REFERENCES Faculty(FacSSNo),
	UnivReq VARCHAR(20),
	CollReq VARCHAR(20)
);

CREATE TABLE Student(
	Sid VARCHAR(5),
	PRIMARY KEY (Sid),
	SSNo VARCHAR (9) unique,
	Sname VARCHAR(20),
    -- name VARCHAR(20),
	CurAddress VARCHAR(20),
	Major VARCHAR(4),
	FOREIGN KEY (Major) REFERENCES DegreeProgram(ProgId),
	StuLevel INT,
	Gpa DOUBLE
);


CREATE TABLE Doffers (
	DeptId VARCHAR(5),
	ProgId VARCHAR(4),
	PRIMARY KEY (DeptId, ProgId),
	FOREIGN KEY (DeptId) REFERENCES Department(DeptId),
	FOREIGN KEY (ProgId) REFERENCES DegreeProgram(ProgId),
	DeptRegrmnt VARCHAR(20)
);


-- In case you need to recreate/drop the database
-- set foreign_key_checks = 0;
-- DROP DATABASE if exists university;
