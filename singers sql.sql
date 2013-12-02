CREATE TABLE People (
  Pid      char(4) not null,
  Firstname    char(20),
  LastName     char(20),
  NumOfAb     int,
primary key(Pid)
);

Select *
From People 

INSERT INTO People( Pid, Firstname, LastName, NumofAb )
  VALUES('P01',	'Ashley', 'Morris', 1);

INSERT INTO People( Pid, Firstname, LastName, NumofAb )
  VALUES('P02',	'Kenny','Lane',	2);

INSERT INTO People( Pid, Firstname, LastName, NumofAb )
  VALUES('P03',	'Maggie', 'Gunther',3); 

INSERT INTO People( Pid, Firstname, LastName, NumofAb )
  VALUES('P04',	'Kate', 'Smith', 1);

INSERT INTO People( Pid, Firstname, LastName, NumofAb )
  VALUES('P05',	'Nick', 'Bayer',1); 


INSERT INTO People( Pid, Firstname, LastName, NumofAb )
  VALUES('P06','Kerry','Flanagan', 2); 


INSERT INTO People( Pid, Firstname, LastName, NumofAb )
  VALUES('P10','Fran','Green',	5); 

INSERT INTO People( Pid, Firstname, LastName, NumofAb )
  VALUES('P12','Tommy','Heart', 4); 


Create View NumberofAbseneses AS 
Select NumOfAb
From People
Where NumofAb > 4;



Create View NumberofAbs AS 
Select FirstName, LastName, NumofAb
From People
Where NumofAb >= 4;



Select *
From NumberofAbs;

SELECT *
FROM {NumberofAbseneses}

Select *
From People 



DROP TABLE IF EXISTS Administration;
CREATE TABLE  Administration(
  Pid     varchar(4) not null,
  Position    char(16),
primary key(Pid),
foreign key (Pid) References people(pid)
);  

--DROP TABLE IF EXISTS Ensembles;
CREATE TABLE  Ensembles(
  Eid     varchar(4) not null,
  EnsembleName    char(16),
primary key(Eid)
);  

Select * 
From Ensembles 


DROP TABLE IF EXISTS PeopleInEnsembles;
CREATE TABLE  PeopleInEnsembles(
  Pid     varchar(4) not null References people(Pid),
  Eid    varchar(4) not null References Ensembles(Eid),
primary key(Pid, Eid)  
);  

Select *
From PeopleInEnsembles

DROP TABLE Students;
CREATE TABLE Students (
  Pid      varchar(4) not null,
  VoicePart    char(20),
  NumPP     int,
  OnBoard    char(4),
primary key(Pid)
);

Select *
From Students

INSERT INTO Students( Pid, VoicePart, NumPP, OnBoard )
  VALUES('P01',	'Soprano', 2, 'T');

INSERT INTO Students( Pid, VoicePart, NumPP, OnBoard )
  VALUES('P02','Bass',2	,'T');

INSERT INTO Students( Pid, VoicePart, NumPP, OnBoard )
  VALUES('P03',	'Alto',	2,'T');

INSERT INTO Students( Pid, VoicePart, NumPP, OnBoard )
  VALUES('P04',	'Soprano', '2',	'T');

INSERT INTO Students( Pid, VoicePart, NumPP, OnBoard )
  VALUES('P05','Tenor', 2,'T');



INSERT INTO Students( Pid, VoicePart, NumPP, OnBoard )
  VALUES('P06','Soprano', 2, 'T');

INSERT INTO Students( Pid, VoicePart, NumPP, OnBoard )
  VALUES('P10','Alto', 2,'F');

Select *
From Students 
--Create view that selects who is on the board and who is not on the board. 
-- Set where condition where value in student equals true 
--inner join people table to get names

Create View PeopleOnBoard As
Select students.pid, students.Onboard, people.Firstname, people.LastName
From Students
Inner Join People
On students.pid= people.FirstName 
And Students.pid= people.LastName
Where Students.OnBoard='T'


Select students.pid, students.Onboard, people.Firstname, people.LastName
From PeopleOnBoard, students, people

Select *
From PeopleOnBoard



Drop View PeopleOnBoard
--Must do a trigger on students 
Select *
From Students 

--DROP TABLE IF EXISTS Concerts;
CREATE TABLE Concerts (
  Cid      varchar(4) not null,
  ConcertName    char(20),
  ConcertDate     Date,
primary key(Cid)
);

--DROP TABLE IF EXISTS Songs;
CREATE TABLE Songs (
  Sid      varchar(4) not null,
  SName    char(20),
  SComposer     char(20),
  PubDate   char(20),
primary key(Sid)
);
Select *
From Songs 

--DROP TABLE IF EXISTS Performances;
CREATE TABLE Performances (
  Pid   varchar not null,    
  Cid     varchar(4) not null references concerts(cid),
  Sid     varchar(3) not null references songs(sid),
 primary key(Pid, Sid, Cid)
);

Select *
From Performances 

