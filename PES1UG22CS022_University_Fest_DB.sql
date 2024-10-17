create database uni_fest;
use uni_fest;

CREATE TABLE Fests(
    festID varchar(5) primary key,
    festName varchar(25) unique not null,
    year year,
    headTeamID varchar(5) unique
);

CREATE TABLE Teams(
    teamID varchar(5) primary key,
    teamName varchar(25),
    teamType ENUM('MNG', 'ORG') default 'ORG',
    festID varchar(5)
);

alter table fests add foreign key(headTeamID) references Teams(teamID);
alter table teams add foreign key(festID) references Fests(festID);

CREATE TABLE Members(
    memID varchar(5) primary key,
    memName varchar(25) not null,
    DOB date,
    superMemID varchar(5),
    teamID varchar(5)
);

alter table Members add foreign key(superMemID) references Members(memID);
alter table Members add foreign key(teamID) references Teams(teamID);

CREATE TABLE Events (
    eventID varchar(5) primary key,
    eventName varchar(25) not null,
    building varchar(25),
    floor varchar(25),
    roomNo INT,
    Price decimal(10, 2) check (Price <= 1500.00),
    teamID varchar(5)
);

alter table Events add foreign key(teamID) references Teams(teamID);

CREATE TABLE Event_conduction(
    eventID varchar(5),
    dateOfConduction date,
    primary key(eventID, dateOfConduction),
    foreign key(eventID) references Events(eventID)
);

CREATE TABLE Participants(
    srn varchar(10) primary key,
    name varchar(25) not null,
    department varchar(25),
    semester INT,
    gender ENUM('male', 'female')
);

CREATE TABLE Visitors(
    srn varchar(10),
    name varchar(25) not null,
    age INT,
    gender ENUM('male', 'female'),
    primary key(srn, name)
);

CREATE TABLE Registrations(
    eventID varchar(5),
    srn varchar(10),
    registrationID varchar(5) not null,
    primary key(eventID, srn)
);

alter table Registrations add foreign key(eventID) references Events(eventID);
alter table Registrations add foreign key(srn) references Participants(srn);

CREATE TABLE Stall(
    stallID varchar(5) primary key,
    stallName varchar(25) UNIQUE NOT NULL,
    festID varchar(5),
    FOREIGN KEY (festID) REFERENCES fests(festID)
);

CREATE TABLE item(
    name varchar(25) PRIMARY KEY,
    type ENUM('veg', 'non-veg')
);

create table stall_items(
	stallID varchar(5),
    itemName varchar(25),
    Price_per_unit decimal(10,2),
    totalQuantity INT,
    primary key(stallID, itemName),
    foreign key (stallID) references stall(stallID),
    foreign key (itemName) references item(name)
    );


CREATE TABLE purchased(
    srn VARCHAR(10),
	stallID varchar(10),
    itemName VARCHAR(25),
    timestamp timestamp,
    quantity INT,
    primary key(srn, stallID, itemName, timestamp),
    FOREIGN KEY (srn) references participants(srn),
    FOREIGN KEY (itemName) references item(name),
    FOREIGN KEY (stallID) references stall(stallID)
);
>SELECT * FROM event WHERE building LIKE '%@%%\%%' or '%\%%@%';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ' 
    fest' at line 7
mysql>
SELECT * FROM PURCHASED WHERE TIMESTAMP >= '2023016120000' AND TIMESTAMP <= '20230416150000';
