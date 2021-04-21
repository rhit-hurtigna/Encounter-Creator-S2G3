CREATE PROCEDURE build_tables
(@Delete_existing_1 [bit] = 0)
AS

--  
-- Build all of the tables for the database.
-- By default, it will not override the existing
-- tables, but if @Delete_existing (optional)
-- is set to 1, it will!
--  
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT  
-- EXEC @Status = build_tables
-- SELECT Status = @Status  
-------------------------------------------  
-- Revision History
-- Created 4/14/21 Nathan Hurtig, Michael Webb, Jackson Hajer
-- Modified 4/15/21 Nathan Hurtig Made IDs auto-increment, added authentication to DM
  
-- Check that parameters are good  
-- Is Delete_existing either a 0 or 1?

IF (@Delete_existing_1 != 0 AND @Delete_existing_1 != 1)
BEGIN
  RAISERROR('Delete_existing must either be 0 (false) or 1 (true).', 10, 1)
  RETURN 1
END

-- Drop tables if Delete_existing is 1
IF (@Delete_existing_1 = 1)
BEGIN
	DROP TABLE IF EXISTS DMBooks
	DROP TABLE IF EXISTS LikedTypes
	DROP TABLE IF EXISTS LikedMonsters
	DROP TABLE IF EXISTS MemberActions
	DROP TABLE IF EXISTS MonsterActions
	DROP TABLE IF EXISTS Action
	DROP TABLE IF EXISTS Monster
	DROP TABLE IF EXISTS Type
	DROP TABLE IF EXISTS Book
	DROP TABLE IF EXISTS Member
	DROP TABLE IF EXISTS Party
	DROP TABLE IF EXISTS DM
END


-- Create tables
-- Thanks to https://stackoverflow.com/questions/6520999/create-table-if-not-exists-equivalent-in-sql-server for IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='TableName') statement

IF NOT EXISTS (Select * From sys.tables Where name = 'DM') CREATE Table DM
(
	ID int IDENTITY(1,1),
	Username varchar(30) NOT NULL,
	Salt varchar(32) NOT NULL,
	PasswordHash varchar(128) NOT NULL,
	Unique(Username),
	Primary Key (ID)
)

IF NOT EXISTS (Select * From sys.tables Where name = 'Party') Create Table Party
(
	ID int IDENTITY(1,1),
	Name varchar(50) NOT NULL,
	DMID int NOT NULL,
	Unique(Name, DMID),
	Primary Key(ID),
	Foreign Key(DMID) References DM(ID) ON DELETE CASCADE
)

IF NOT EXISTS (Select * From sys.tables Where name = 'Member') Create Table Member
(
	ID int IDENTITY(1,1),
	Name varchar(50) NOT NULL,
	Class varchar(30) NOT NULL,
	PartyID int NOT NULL,
	Level int NOT NULL,
	Race varchar(30) NOT NULL,
	Alignment varchar(2),
	Unique(Name, PartyID),
	Primary Key(ID),
	Foreign Key (PartyID) References Party(ID) ON DELETE CASCADE,
	CHECK(Level >= 0)
)

IF NOT EXISTS (Select * From sys.tables Where name = 'Book') Create Table Book
(
	ID int IDENTITY(1,1),
	Name varchar(50) NOT NULL,
	Unique(Name),
	Primary Key(ID)
)

IF NOT EXISTS (Select * From sys.tables Where name = 'Type') Create Table Type
(
	ID int IDENTITY(1,1),
	Name varchar(50) NOT NULL,
	Description varchar(500),
	PRIMARY KEY (ID)
)

IF NOT EXISTS (Select * From sys.tables Where name = 'Monster') Create Table Monster
(
	ID int IDENTITY(1,1),
	Name varchar(50) NOT NULL,
	CR decimal(5, 3) NOT NULL,
	TypeID int,
	BookID int,
	Alignment varchar(2),
	PRIMARY KEY (ID),
	FOREIGN KEY (BookID) REFERENCES Book ON DELETE SET NULL,
	FOREIGN KEY (TypeID) REFERENCES Type,
	CHECK(CR >= 0)
)

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='Action') CREATE TABLE Action
(
	ID int IDENTITY(1,1),
	Name varchar(50) NOT NULL,
	Description varchar(200),
	PRIMARY KEY (ID),
	UNIQUE (Name)
)

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='MonsterActions') CREATE TABLE MonsterActions
(
	MonsterID int,
	ActionID int,
	PRIMARY KEY(MonsterID, ActionID),
	FOREIGN KEY(MonsterID) REFERENCES Monster ON DELETE CASCADE,
	FOREIGN KEY(ActionID) REFERENCES Action ON DELETE CASCADE
)

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='MemberActions') CREATE TABLE MemberActions
(
	MemberID int,
	ActionID int,
	PRIMARY KEY(MemberID, ActionID),
	FOREIGN KEY(MemberID) REFERENCES Member ON DELETE CASCADE,
	FOREIGN KEY(ActionID) REFERENCES Action ON DELETE CASCADE
)

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='LikedMonsters') CREATE TABLE LikedMonsters
(
	DMID int,
	MonsterID int,
	PRIMARY KEY(DMID, MonsterID),
	FOREIGN KEY(DMID) REFERENCES DM ON DELETE CASCADE,
	FOREIGN KEY(MonsterID) REFERENCES Monster ON DELETE CASCADE
)

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='LikedTypes') Create Table LikedTypes
(
	DMID int,
	TypeID int,
	Primary Key(DMID, TypeID),
	FOREIGN KEY (DMID) REFERENCES DM ON DELETE CASCADE,
	FOREIGN KEY (TypeID) REFERENCES Type ON DELETE CASCADE
)

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='DMBooks') Create Table DMBooks
(
	DMID int,
	BookID int,
	PRIMARY KEY(DMID, BookID),
	FOREIGN KEY (DMID) REFERENCES DM ON DELETE CASCADE,
	FOREIGN KEY (BookID) REFERENCES Book ON DELETE CASCADE
)

RETURN 0