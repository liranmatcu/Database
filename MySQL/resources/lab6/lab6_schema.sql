DROP DATABASE IF EXISTS university;
CREATE DATABASE university;
USE university;

CREATE TABLE Department(
	DeptId VARCHAR(5) PRIMARY KEY,
	DeptName VARCHAR(20),
	DeptAddress VARCHAR(20),
	Chair VARCHAR(9)
);

CREATE TABLE Faculty(
	FacName VARCHAR(20),
	FacSSNo VARCHAR(9) PRIMARY KEY,
	OfficeAddress VARCHAR(20),
	Worksfor VARCHAR(5),
	FOREIGN KEY (Worksfor) REFERENCES Department(DeptId)
);

ALTER TABLE Department	
	ADD FOREIGN KEY (Chair) REFERENCES Faculty(FacSSNo);


/*The work table for loading.  It can be dropped after loading*/
CREATE TABLE worktable_faculty(
	FacSSNo VARCHAR(9) PRIMARY KEY,
	Worksfor VARCHAR(5)
);


CREATE TABLE DegreeProgram(
	ProgId VARCHAR(4) PRIMARY KEY,
	ProgramName VARCHAR(40),
	ProgType VARCHAR(10),
	Coordinator VARCHAR(9),
	UnivReq VARCHAR(20),
	CollReq VARCHAR(20),
	FOREIGN KEY (Coordinator) REFERENCES Faculty(FacSSNo)
);

CREATE TABLE Student(
	Sid VARCHAR(5) PRIMARY KEY,
	SSNo VARCHAR(9) UNIQUE,
	Sname VARCHAR(20),
	CurAddress VARCHAR(20),
	Major VARCHAR(4),
	StuLevel INTEGER(1),
	Gpa DOUBLE(2,1),
	FOREIGN KEY (Major) REFERENCES DegreeProgram(ProgId)
);

CREATE TABLE DDoffers(
	DeptId VARCHAR(5),
	ProgId VARCHAR(4),
	DeptReqrmnt VARCHAR(20),
	PRIMARY KEY (DeptId, ProgId),
	FOREIGN KEY (DeptId) REFERENCES Department(DeptId),
	FOREIGN KEY (ProgId) REFERENCES DegreeProgram(ProgId)
);
	

CREATE TABLE CourseDescription(
	Cno VARCHAR(10) PRIMARY KEY,
	Title VARCHAR(100),
	Credits INTEGER(1),
	Description VARCHAR(100),
	Offers VARCHAR(5),
	FOREIGN KEY (Offers) REFERENCES Department(DeptId)
);

CREATE TABLE CourseOffering(
	SeqID VARCHAR(5) PRIMARY KEY,
	SectionNo VARCHAR(2),
	Cno VARCHAR(10),
	Semester VARCHAR(10),
	YEAR INTEGER(4),
	Instructor VARCHAR(9),
	FOREIGN KEY (Cno) REFERENCES CourseDescription(Cno),
	FOREIGN KEY (Instructor) REFERENCES Faculty(FacSSNo)
);

CREATE TABLE taken(
	Sid VARCHAR(5),
	SeqID VARCHAR(5),
	Grade DOUBLE(2,1),
	PRIMARY KEY(Sid, SeqID),
	FOREIGN KEY (Sid) REFERENCES Student(sid),
	FOREIGN KEY (SeqID) REFERENCES CourseOffering(SeqID)
);
