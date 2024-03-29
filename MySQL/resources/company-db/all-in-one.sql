-- Adminer 4.8.1 MySQL 8.0.29 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

CREATE DATABASE `Company` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `Company`;

DROP TABLE IF EXISTS `DEPARTMENT`;
CREATE TABLE `DEPARTMENT` (
  `Dname` varchar(15) NOT NULL,
  `Dnumber` int NOT NULL,
  `Mgr_ssn` char(9) NOT NULL DEFAULT '888665555',
  `Mgr_start_date` date DEFAULT NULL,
  PRIMARY KEY (`Dnumber`),
  UNIQUE KEY `DEPTSK` (`Dname`),
  KEY `DEPTMGRFK` (`Mgr_ssn`),
  CONSTRAINT `DEPTMGRFK` FOREIGN KEY (`Mgr_ssn`) REFERENCES `EMPLOYEE` (`Ssn`) ON DELETE SET DEFAULT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `DEPARTMENT` (`Dname`, `Dnumber`, `Mgr_ssn`, `Mgr_start_date`) VALUES
('Headquarters',	1,	'888665555',	'1981-06-19'),
('Administration',	4,	'987654321',	'1995-01-01'),
('Research',	5,	'333445555',	'1988-05-22');

DROP TABLE IF EXISTS `DEPENDENT`;
CREATE TABLE `DEPENDENT` (
  `Essn` char(9) NOT NULL,
  `Dependent_name` varchar(15) NOT NULL,
  `Sex` char(1) DEFAULT NULL,
  `Bdate` date DEFAULT NULL,
  `Relationship` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`Essn`,`Dependent_name`),
  CONSTRAINT `DEPENDEMPFK` FOREIGN KEY (`Essn`) REFERENCES `EMPLOYEE` (`Ssn`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `DEPENDENT` (`Essn`, `Dependent_name`, `Sex`, `Bdate`, `Relationship`) VALUES
('123456789',	'Alice',	'F',	'1988-12-30',	'Daughter'),
('123456789',	'Elizabeth',	'F',	'1967-05-05',	'Spouse'),
('123456789',	'Michael',	'M',	'1988-01-04',	'Son'),
('333445555',	'Alice',	'F',	'1986-04-05',	'Daughter'),
('333445555',	'Joy',	'F',	'1958-05-03',	'Spouse'),
('333445555',	'Theodore',	'M',	'1983-10-25',	'Son'),
('987654321',	'Abner',	'M',	'1942-02-28',	'Spouse');

DROP TABLE IF EXISTS `DEPT_LOCATIONS`;
CREATE TABLE `DEPT_LOCATIONS` (
  `Dnumber` int NOT NULL,
  `Dlocation` varchar(15) NOT NULL,
  PRIMARY KEY (`Dnumber`,`Dlocation`),
  CONSTRAINT `dept_locations_ibfk_1` FOREIGN KEY (`Dnumber`) REFERENCES `DEPARTMENT` (`Dnumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `DEPT_LOCATIONS` (`Dnumber`, `Dlocation`) VALUES
(1,	'Houston'),
(4,	'Stratford'),
(5,	'Bellaire'),
(5,	'Houston'),
(5,	'Sugarland');

DROP TABLE IF EXISTS `EMPLOYEE`;
CREATE TABLE `EMPLOYEE` (
  `Fname` varchar(15) NOT NULL,
  `Minit` char(1) DEFAULT NULL,
  `Lname` varchar(15) NOT NULL,
  `Ssn` char(9) NOT NULL,
  `Bdate` date DEFAULT NULL,
  `Address` varchar(30) DEFAULT NULL,
  `Sex` char(1) DEFAULT NULL,
  `Salary` decimal(10,2) DEFAULT NULL,
  `Super_ssn` char(9) DEFAULT NULL,
  `Dno` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`Ssn`),
  KEY `EMPSUPERFK` (`Super_ssn`),
  KEY `EMPDEPTFK` (`Dno`),
  CONSTRAINT `EMPDEPTFK` FOREIGN KEY (`Dno`) REFERENCES `DEPARTMENT` (`Dnumber`) ON DELETE SET DEFAULT ON UPDATE CASCADE,
  CONSTRAINT `EMPSUPERFK` FOREIGN KEY (`Super_ssn`) REFERENCES `EMPLOYEE` (`Ssn`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `EMPLOYEE` (`Fname`, `Minit`, `Lname`, `Ssn`, `Bdate`, `Address`, `Sex`, `Salary`, `Super_ssn`, `Dno`) VALUES
('John',	'B',	'Smith',	'123456789',	'1965-01-09',	'731 Fondren, Houston, TX',	'M',	30000.00,	'333445555',	5),
('Franklin',	'T',	'Wong',	'333445555',	'1955-12-08',	'638 Voss, Houston, TX',	'M',	40000.00,	'888665555',	5),
('Joyce',	'A',	'English',	'453453453',	'1972-07-31',	'5631 Rice, Houston, TX',	'F',	25000.00,	'333445555',	5),
('Ramesh',	'K',	'Narayan',	'666884444',	'1962-09-15',	'975 Fire Oak, Humble, TX',	'M',	38000.00,	'333445555',	5),
('James',	'E',	'Borg',	'888665555',	'1937-11-10',	'450 Stone, Houston, TX',	'M',	55000.00,	NULL,	1),
('Jennifer',	'S',	'Wallace',	'987654321',	'1941-06-20',	'291 Berry, Bellaire, TX',	'F',	43000.00,	'888665555',	4),
('Ahmad',	'V',	'Jabbar',	'987987987',	'1969-03-29',	'980 Dallas, Houston, TX',	'M',	25000.00,	'987654321',	4),
('Alicia',	'J',	'Zelaya',	'999887777',	'1968-01-19',	'3321 Castle, Spring, TX',	'F',	25000.00,	'987654321',	4);

DROP TABLE IF EXISTS `PROJECT`;
CREATE TABLE `PROJECT` (
  `Pname` varchar(15) NOT NULL,
  `Pnumber` int NOT NULL,
  `Plocation` varchar(15) DEFAULT NULL,
  `Dnum` int NOT NULL,
  PRIMARY KEY (`Pnumber`),
  UNIQUE KEY `PROJSK` (`Pname`),
  KEY `PROJDEPTFK` (`Dnum`),
  CONSTRAINT `PROJDEPTFK` FOREIGN KEY (`Dnum`) REFERENCES `DEPARTMENT` (`Dnumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `PROJECT` (`Pname`, `Pnumber`, `Plocation`, `Dnum`) VALUES
('ProductX',	1,	'Bellaire',	5),
('ProductY',	2,	'Sugarland',	5),
('ProductZ',	3,	'Houston',	5),
('Computerization',	10,	'Stafford',	4),
('Reorganization',	20,	'Houston',	1),
('Newbenefits',	30,	'Stafford',	4);

DROP TABLE IF EXISTS `WORKS_ON`;
CREATE TABLE `WORKS_ON` (
  `Essn` char(9) NOT NULL,
  `Pno` int NOT NULL,
  `Hours` decimal(3,1) DEFAULT NULL,
  PRIMARY KEY (`Essn`,`Pno`),
  KEY `WORKSPROJFK` (`Pno`),
  CONSTRAINT `WORKSEMPFK` FOREIGN KEY (`Essn`) REFERENCES `EMPLOYEE` (`Ssn`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `WORKSPROJFK` FOREIGN KEY (`Pno`) REFERENCES `PROJECT` (`Pnumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `WORKS_ON` (`Essn`, `Pno`, `Hours`) VALUES
('123456789',	1,	32.5),
('123456789',	2,	7.5),
('333445555',	2,	10.0),
('333445555',	3,	10.0),
('333445555',	10,	10.0),
('333445555',	20,	10.0),
('453453453',	1,	20.0),
('453453453',	2,	20.0),
('666884444',	3,	40.0),
('888665555',	20,	NULL),
('987654321',	20,	15.0),
('987654321',	30,	20.0),
('987987987',	10,	35.0),
('987987987',	30,	5.0),
('999887777',	10,	10.0),
('999887777',	30,	30.0);

-- 2022-08-20 23:21:39
