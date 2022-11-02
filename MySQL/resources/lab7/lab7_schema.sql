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

insert into Faculty (facname, facssno, officeaddress) values ('Peter', '014575454', 'Babbage Tower');
insert into Faculty (facname, facssno, officeaddress) values ('JoAnn', '735623954', 'Edison Bldg');
insert into Faculty (facname, facssno, officeaddress) values ('Malcolm', '032562344', 'Babbage Tower');
insert into Faculty (facname, facssno, officeaddress) values ('Cathy', '056707794', 'Mack Hall');
insert into Faculty (facname, facssno, officeaddress) values ('Robbins', '331405635', 'Babbage Tower');
insert into Faculty (facname, facssno, officeaddress) values ('Ramon', '349045050', 'Edison Bldg');

insert into Department (deptid, deptname, deptaddress, chair) values ('CS', 'Computer Science', 'OKC', '014575454');
insert into Department (deptid, deptname, deptaddress, chair) values ('EE', 'Electrical', 'Tulsa', '349045050');
insert into Department (deptid, deptname, deptaddress, chair) values ('ME', 'Mechanical', 'OKC', '056707794');

update Faculty set worksfor='CS' where facssno='014575454';
update Faculty set worksfor='EE' where facssno='735623954';
update Faculty set worksfor='CS' where facssno='032562344';
update Faculty set worksfor='ME' where facssno='056707794';
update Faculty set worksfor='CS' where facssno='331405635';
update Faculty set worksfor='EE' where facssno='349045050';

insert into DegreeProgram (progid, programname, progtype, coordinator) values ('P000', 'Computer Science', 'BS', '014575454');
insert into DegreeProgram (progid, programname, progtype, coordinator) values ('P001', 'Computer Science', 'PhD', '032562344'); 
insert into DegreeProgram (progid, programname, progtype, coordinator) values ('P010', 'Electrical Engineering', 'BS', '735623954');
insert into DegreeProgram (progid, programname, progtype, coordinator) values ('P014', 'Electrical Engineering', 'PhD', '349045050');
insert into DegreeProgram (progid, programname, progtype, coordinator) values ('P200', 'Mechanical Engineering', 'BS', '056707794'); 
insert into DegreeProgram (progid, programname, progtype, coordinator) values ('P050', 'Computer Science & Engineering', 'BS', '014575454');

insert into Student (sid, ssno, sname, curaddress, major, stulevel) values ('A2344', '044505777', 'John', 'OKC', 'P000', 3);
insert into Student (sid, ssno, sname, curaddress, major, stulevel) values ('A1234', '455706547', 'David', 'Lawton', 'P000', 4);
insert into Student (sid, ssno, sname, curaddress, major, stulevel) values ('A3245', '322695645', 'Randy', 'OKC', 'P010', 2);
insert into Student (sid, ssno, sname, curaddress, major, stulevel) values ('A4344', '304455799', 'Cindy', 'Tulsa', 'P200', 3);
insert into Student (sid, ssno, sname, curaddress, major, stulevel) values ('A5466', '405676777', 'Susan', 'OKC', 'P000', 1);
insert into Student (sid, ssno, sname, curaddress, major, stulevel) values ('A4567', '657894555', 'Walid', 'OKC', 'P001', 6);      
insert into Student (sid, ssno, sname, curaddress, major, stulevel) values ('A3523', '334594792', 'Jinhua', 'OKC', 'P001', 6);

insert into DDoffers values ('CS', 'P000', 'CS180');
insert into DDoffers values ('CS', 'P050', 'CS480');
insert into DDoffers values ('EE', 'P050', 'EE100');
insert into DDoffers values ('EE', 'P010', 'EE100');
insert into DDoffers values ('ME', 'P200', 'ME100');
insert into DDoffers values ('CS', 'P001', '');     
insert into DDoffers values ('EE', 'P014', '');   

insert into CourseDescription (cno, title, credits, offers) values ('CS480', 'Database systems', 4, 'CS');
insert into CourseDescription (cno, title, credits, offers) values ('CS880', 'Advanced DBMS', 3, 'CS');
insert into CourseDescription (cno, title, credits, offers) values ('ME310', 'Thermodynamics', 1, 'ME');
insert into CourseDescription (cno, title, credits, offers) values ('EE210', 'Digital Logic', 2, 'EE');
insert into CourseDescription (cno, title, credits, offers) values ('CS331', 'Algorithms', 3, 'CS');
insert into CourseDescription (cno, title, credits, offers) values ('CS410', 'Operating Systems', 4, 'CS');

insert into CourseOffering values ('00001', '01', 'CS480', 'Fall', 2005, '014575454');
insert into CourseOffering values ('00002', '02', 'CS480', 'Fall', 2005, '014575454');
insert into CourseOffering values ('00103', '01', 'CS880', 'Fall', 2005, '056707794');
insert into CourseOffering values ('02002', '01', 'CS480', 'Spring', 2006, '032562344');
insert into CourseOffering values ('51205', '01', 'EE210', 'Spring', 2006, '735623954');
insert into CourseOffering values ('00328', '01', 'CS331', 'Fall', 2004, '056707794');
insert into CourseOffering values ('00255', '01', 'CS331', 'Fall', 2003, '056707794');

insert into taken values ('A2344', '00001', 4.0);
insert into taken values ('A1234', '00001', 1.0);
insert into taken values ('A3245', '00001', 4.0);
insert into taken values ('A4344', '00001', 4.0);
insert into taken values ('A5466', '00002', 4.0);
insert into taken values ('A4567', '00103', 4.0);
insert into taken values ('A2344', '51205', 4.0);
insert into taken values ('A1234', '51205', 2.0);
insert into taken values ('A2344', '00328', 4.0);
insert into taken values ('A1234', '00255', 2.0);
insert into taken values ('A3245', '00328', 3.5);
insert into taken values ('A4344', '00328', 4.0);