USE [master]
GO
/****** Object:  Database [EncounterCreator_FinalS2G3]    Script Date: 05/21/21 10:30:35 AM ******/
CREATE DATABASE [EncounterCreator_FinalS2G3]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EncounterCreator_Final', FILENAME = N'D:\Database\MSSQL15.MSSQLSERVER\MSSQL\DATA\EncounterCreator_Final.mdf' , SIZE = 10240KB , MAXSIZE = 102400KB , FILEGROWTH = 10%)
 LOG ON 
( NAME = N'EncounterCreator_Final_log', FILENAME = N'D:\Database\MSSQL15.MSSQLSERVER\MSSQL\DATA\EncounterCreator_Final_log.ldf' , SIZE = 2048KB , MAXSIZE = 51200KB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [EncounterCreator_FinalS2G3] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EncounterCreator_FinalS2G3].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EncounterCreator_FinalS2G3] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EncounterCreator_FinalS2G3] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EncounterCreator_FinalS2G3] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EncounterCreator_FinalS2G3] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EncounterCreator_FinalS2G3] SET ARITHABORT OFF 
GO
ALTER DATABASE [EncounterCreator_FinalS2G3] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EncounterCreator_FinalS2G3] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EncounterCreator_FinalS2G3] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EncounterCreator_FinalS2G3] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EncounterCreator_FinalS2G3] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EncounterCreator_FinalS2G3] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EncounterCreator_FinalS2G3] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EncounterCreator_FinalS2G3] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EncounterCreator_FinalS2G3] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EncounterCreator_FinalS2G3] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EncounterCreator_FinalS2G3] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EncounterCreator_FinalS2G3] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EncounterCreator_FinalS2G3] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EncounterCreator_FinalS2G3] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EncounterCreator_FinalS2G3] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EncounterCreator_FinalS2G3] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [EncounterCreator_FinalS2G3] SET  MULTI_USER 
GO
ALTER DATABASE [EncounterCreator_FinalS2G3] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EncounterCreator_FinalS2G3] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EncounterCreator_FinalS2G3] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [EncounterCreator_FinalS2G3] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [EncounterCreator_FinalS2G3] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'EncounterCreator_FinalS2G3', N'ON'
GO
ALTER DATABASE [EncounterCreator_FinalS2G3] SET QUERY_STORE = OFF
GO
USE [EncounterCreator_FinalS2G3]
GO
/****** Object:  User [webbma]    Script Date: 05/21/21 10:30:35 AM ******/
CREATE USER [webbma] FOR LOGIN [webbma] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [hajerjt]    Script Date: 05/21/21 10:30:35 AM ******/
CREATE USER [hajerjt] FOR LOGIN [hajerjt] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [EncounterCreator_FinalAppAccount]    Script Date: 05/21/21 10:30:35 AM ******/
CREATE USER [EncounterCreator_FinalAppAccount] FOR LOGIN [EncounterCreatorAppAccount] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [AccountStoredProcedureReader]    Script Date: 05/21/21 10:30:35 AM ******/
CREATE USER [AccountStoredProcedureReader] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  DatabaseRole [application]    Script Date: 05/21/21 10:30:35 AM ******/
CREATE ROLE [application]
GO
ALTER ROLE [db_owner] ADD MEMBER [webbma]
GO
ALTER ROLE [db_owner] ADD MEMBER [hajerjt]
GO
ALTER ROLE [application] ADD MEMBER [EncounterCreator_FinalAppAccount]
GO
ALTER ROLE [db_datareader] ADD MEMBER [AccountStoredProcedureReader]
GO
/****** Object:  Table [dbo].[Action]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Action](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Book]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DM]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DM](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](30) NOT NULL,
	[Salt] [varchar](32) NOT NULL,
	[PasswordHash] [varchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DMBooks]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DMBooks](
	[DMID] [int] NOT NULL,
	[BookID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DMID] ASC,
	[BookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LikedMonsters]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LikedMonsters](
	[DMID] [int] NOT NULL,
	[MonsterID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DMID] ASC,
	[MonsterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LikedTypes]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LikedTypes](
	[DMID] [int] NOT NULL,
	[TypeID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DMID] ASC,
	[TypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Class] [varchar](30) NOT NULL,
	[PartyID] [int] NOT NULL,
	[Level] [int] NOT NULL,
	[Race] [varchar](30) NOT NULL,
	[Alignment] [varchar](2) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Name] ASC,
	[PartyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MemberActions]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MemberActions](
	[MemberID] [int] NOT NULL,
	[ActionID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MemberID] ASC,
	[ActionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Monster]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Monster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[CR] [decimal](5, 3) NOT NULL,
	[TypeID] [int] NULL,
	[BookID] [int] NULL,
	[Alignment] [varchar](2) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MonsterActions]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MonsterActions](
	[MonsterID] [int] NOT NULL,
	[ActionID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MonsterID] ASC,
	[ActionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Party]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Party](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[DMID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Name] ASC,
	[DMID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Type]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Type](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMBooks]  WITH CHECK ADD FOREIGN KEY([BookID])
REFERENCES [dbo].[Book] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DMBooks]  WITH CHECK ADD FOREIGN KEY([DMID])
REFERENCES [dbo].[DM] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LikedMonsters]  WITH CHECK ADD FOREIGN KEY([MonsterID])
REFERENCES [dbo].[Monster] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LikedMonsters]  WITH CHECK ADD FOREIGN KEY([DMID])
REFERENCES [dbo].[DM] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LikedTypes]  WITH CHECK ADD FOREIGN KEY([TypeID])
REFERENCES [dbo].[Type] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LikedTypes]  WITH CHECK ADD FOREIGN KEY([DMID])
REFERENCES [dbo].[DM] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Member]  WITH CHECK ADD FOREIGN KEY([PartyID])
REFERENCES [dbo].[Party] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MemberActions]  WITH CHECK ADD FOREIGN KEY([ActionID])
REFERENCES [dbo].[Action] ([ID])
GO
ALTER TABLE [dbo].[MemberActions]  WITH CHECK ADD FOREIGN KEY([MemberID])
REFERENCES [dbo].[Member] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Monster]  WITH CHECK ADD FOREIGN KEY([BookID])
REFERENCES [dbo].[Book] ([ID])
GO
ALTER TABLE [dbo].[Monster]  WITH CHECK ADD FOREIGN KEY([TypeID])
REFERENCES [dbo].[Type] ([ID])
GO
ALTER TABLE [dbo].[MonsterActions]  WITH CHECK ADD FOREIGN KEY([ActionID])
REFERENCES [dbo].[Action] ([ID])
GO
ALTER TABLE [dbo].[MonsterActions]  WITH CHECK ADD FOREIGN KEY([MonsterID])
REFERENCES [dbo].[Monster] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Party]  WITH CHECK ADD FOREIGN KEY([DMID])
REFERENCES [dbo].[DM] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Member]  WITH CHECK ADD CHECK  (([Alignment]='CE' OR [Alignment]='NE' OR [Alignment]='LE' OR [Alignment]='CN' OR [Alignment]='TN' OR [Alignment]='LN' OR [Alignment]='CG' OR [Alignment]='NG' OR [Alignment]='LG'))
GO
ALTER TABLE [dbo].[Member]  WITH CHECK ADD CHECK  (([Level]>=(1) AND [Level]<=(20)))
GO
ALTER TABLE [dbo].[Monster]  WITH CHECK ADD CHECK  (([CR]>=(0) AND [CR]<=(30)))
GO
/****** Object:  StoredProcedure [dbo].[add_action]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[add_action]
(
@DMID_1 int,
@MemberID_2 int,
@Name_3 varchar(50)
)
AS

--  
-- Gives a specified member owned by the DM
-- the action with the given name
--
-- Parameters:
-- DMID_1: ID of existing DM
-- MemberID_2: ID of member owned by DM
-- Name_3: <=50 characters (name of action)
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT  
-- EXEC @Status = add_action @DMID_1 = 8, @MemberID_2 = 4, @Name_3 = 'Absorb Elements'
-- SELECT Status = @Status  
-------------------------------------------  
-- Revision History
-- Created 5/06/21 Nathan Hurtig
--

-- Turn NOCOUNT on because pydobc gets confused
SET NOCOUNT ON

-- Check that parameters are good  

-- Is DM ID good?
IF (@DMID_1 is null)
  RETURN 1

IF NOT EXISTS (SELECT * FROM DM WHERE ID=@DMID_1)
  RETURN 2

-- Is MemberID good?
IF (@MemberID_2 is null)
  RETURN 3

IF NOT EXISTS (SELECT * FROM Member WHERE ID=@MemberID_2)
  RETURN 4

-- Does the DM own the member?
IF ((SELECT DMID FROM Party WHERE ID=(SELECT PartyID FROM Member WHERE ID = @MemberID_2)) <> @DMID_1)
  RETURN 5

-- Is name good?
IF (@Name_3 is null)
  RETURN 6


IF ((SELECT ID FROM Action WHERE Name = @Name_3) is null)
  RETURN 7

-- Get ID of action
DECLARE @ActionID int
SELECT @ActionID = ID FROM Action WHERE Name = @Name_3

IF EXISTS (SELECT * FROM MemberActions WHERE MemberID = @MemberID_2 AND ActionID = @ActionID)
  RETURN 8

-- Insert into table
INSERT INTO MemberActions(MemberID, ActionID)
VALUES (@MemberID_2, @ActionID)

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[add_member]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[add_member]
(
@DMID_1 int,
@PartyID_2 int,
@Name_3 varchar(50),
@Class_4 varchar(30),
@Race_5 varchar(30),
@Alignment_6 varchar(2),
@Level_7 int
)
AS

--  
-- Puts a member into member table with given
-- characteristics as a member of the given party
-- owned by the given DM
--
-- Parameters:
-- DMID_1: ID of existing DM
-- PartyID_2: ID of party owned by DM
-- Name_3: <=50 characters (name of member)
-- Class_4: One of the 12 base classes, string form
-- Race_5: One of the 9 base races, string form
-- Alignment_6: One of the 9 alignments, 2 character acronym
-- Level_7: Level of member, within 1-20 inclusive
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT  
-- EXEC @Status = create_party @DMID_1 = 8, @PartyID_2 = 12, @Name_3 = 'Dingledorf'.
-- @Class_4 = 'Bard', @Race_5 = 'Gnome', @Alignment_6 = 'CN', @Level_7 = 3
-- SELECT Status = @Status  
-------------------------------------------  
-- Revision History
-- Created 4/29/21 Nathan Hurtig
--

-- Turn NOCOUNT on because pydobc gets confused
SET NOCOUNT ON

-- Check that parameters are good  

-- Is DM ID good?
IF (@DMID_1 is null)
  RETURN 1

IF NOT EXISTS (SELECT * FROM DM WHERE ID=@DMID_1)
  RETURN 2

-- Is PartyID good?
IF (@PartyID_2 is null)
  RETURN 3

IF NOT EXISTS (SELECT * FROM Party WHERE ID=@PartyID_2)
  RETURN 4

-- Does the DM own the party?
IF ((SELECT DMID FROM Party WHERE ID=@PartyID_2) <> @DMID_1)
  RETURN 5

-- Is name good?
IF (@Name_3 is null)
  RETURN 6

-- Is class good?
IF (@Class_4 is null)
  RETURN 7

-- Is race good?
IF (@Race_5 is null)
  RETURN 8

-- Is alignment good?
IF (@Alignment_6 is null)
  RETURN 9

IF @Alignment_6 not in ('LG', 'NG', 'CG', 'LN', 'TN', 'CN', 'LE', 'NE', 'CE')
  RETURN 10

-- Is level good?
IF (@Level_7 is null)
  RETURN 11

IF (@Level_7 not BETWEEN 1 AND 20)
  RETURN 12

-- Insert into table
INSERT INTO Member (PartyID, Name, Class, Race, Alignment, Level)
VALUES (@PartyID_2, @Name_3, @Class_4, @Race_5, @Alignment_6, @Level_7)

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[add_monster_action]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[add_monster_action]
(
@DMID int,
@MonsterName varchar(50),
@Name varchar(50)
)
AS

--  
-- Gives a specified member owned by the DM
-- the action with the given name
--
-- Parameters:
-- DMID: ID of existing DM
-- MonsterName: Name of monster
-- Name: <=50 characters (name of action)
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT  
-- EXEC @Status = add_action @DMID = 8, @MonsterName = 'Jim', @Name = 'Absorb Elements'
-- SELECT Status = @Status  
-------------------------------------------  
-- Revision History
-- Created 5/13/21 Jackson Hjaer
--

-- Turn NOCOUNT on because pydobc gets confused
SET NOCOUNT ON

-- Check that parameters are good  

-- Is DM ID good?
IF (@DMID is null)
  RETURN 1

IF NOT EXISTS (SELECT * FROM DM WHERE ID=@DMID)
  RETURN 2

-- Is MemberID good?
IF (@MonsterName is null)
  RETURN 3

IF NOT EXISTS (SELECT * FROM Monster WHERE Name=@MonsterName)
  RETURN 4

-- Is name good?
IF (@Name is null)
  RETURN 6


IF ((SELECT ID FROM Action WHERE Name = @Name) is null)
  RETURN 7

-- Get ID of action
DECLARE @ActionID int, @MonsterID int
SELECT @ActionID = ID FROM Action WHERE Name = @Name
SELECT @MonsterID = ID FROM Monster WHERE Name = @MonsterName

IF EXISTS (SELECT * FROM MonsterActions WHERE MonsterID = @MonsterID AND ActionID = @ActionID)
  RETURN 8

-- Insert into table
INSERT INTO MonsterActions(MonsterID, ActionID)
VALUES (@MonsterID, @ActionID)

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[add_user]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[add_user]
(
@Username_1 varchar(30),
@Salt_2 varchar(32),
@PasswordHash_3 varchar(128),
@NewID_4 int OUTPUT
)
AS

--  
-- Puts a user into the DM table with
-- the given username & login info. Outputs
-- the ID of the new DM if successful.
--
-- Parameters:
-- Username_1: <= 30 chars, not already in table
-- Salt_2: 16 random bytes converted to hex
-- PasswordHash_3: 64 bytes of SHA-512 hashed password
-- NewID_4: The ID of the new DM if successful
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT  
-- DECLARE @NewID INT
-- EXEC @Status = add_user @Username_1 = theLegend27, @Salt_2 = [32 hex chars], @PasswordHash_3 = [128 hex chars], @NewID_4 = @NewID OUTPUT
-- SELECT Status = @Status, NewID = @NewID
-------------------------------------------  
-- Revision History
-- Created 4/16/21 Nathan Hurtig
-- Modified 4/22/21 Nathan Hurtig to return ID of new user
-- Modified 4/29/21 Nathan Hurtig to allow pyodbc
-- to access status codes on error
-- 

-- Turn NOCOUNT on because pydobc gets confused
SET NOCOUNT ON

-- Check that parameters are good  

-- Is Username good?
IF (@Username_1 is null)
BEGIN
  RETURN 1
END

IF EXISTS (SELECT * FROM DM WHERE Username=@Username_1)
BEGIN
  RETURN 2
END

-- Is salt good?
IF (@Salt_2 is null)
BEGIN
  RETURN 3
END

-- Is password good?
IF (@PasswordHash_3 is null)
BEGIN
  RETURN 4
END


-- Insert into table
INSERT INTO DM (Username, Salt, PasswordHash)
VALUES (@Username_1, @Salt_2, @PasswordHash_3)

SET @NewID_4 = SCOPE_IDENTITY()

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[build_tables]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[build_tables]
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
-- Modified 4/21/21 Jackson Hajer Made sure proper action is taken with delete and added additional constraints
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
	Foreign Key(DMID) References DM(ID) ON DELETE CASCADE  -- Don't want DM-less parties
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
	Foreign Key (PartyID) References Party(ID) ON DELETE CASCADE,  -- Don't want party-less members
	CHECK(Level >= 1 and Level <= 20),
	CHECK(Alignment in ('LG', 'NG', 'CG', 'LN', 'TN', 'CN', 'LE', 'NE', 'CE'))
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
	FOREIGN KEY (BookID) REFERENCES Book,  -- Monsters can have no book (custom monsters), but we shouldn't be able to delete a book that's being used anyways
	FOREIGN KEY (TypeID) REFERENCES Type,  -- Monsters can have no type, but we shouldn't be able to delete a type anyways
	CHECK(CR >= 0 and CR <= 30),
	CHECK(Alignment in ('LG', 'NG', 'CG', 'LN', 'TN', 'CN', 'LE', 'NE', 'CE'))
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
	FOREIGN KEY(MonsterID) REFERENCES Monster ON DELETE CASCADE,  -- MonsterActions 'belong' to monsters
	FOREIGN KEY(ActionID) REFERENCES Action  -- No reason to allow deletion of actions in use
)

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='MemberActions') CREATE TABLE MemberActions
(
	MemberID int,
	ActionID int,
	PRIMARY KEY(MemberID, ActionID),
	FOREIGN KEY(MemberID) REFERENCES Member ON DELETE CASCADE,  -- MemberActions 'belong' to members
	FOREIGN KEY(ActionID) REFERENCES Action  -- No reason to allow deletion of actions in use
)

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='LikedMonsters') CREATE TABLE LikedMonsters
(
	DMID int,
	MonsterID int,
	PRIMARY KEY(DMID, MonsterID),
	FOREIGN KEY(DMID) REFERENCES DM ON DELETE CASCADE,  -- Preferences belong to the DM
	FOREIGN KEY(MonsterID) REFERENCES Monster ON DELETE CASCADE  -- In case if we need to delete a monster, whether a DM likes it or not won't be part of that decision
)

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='LikedTypes') Create Table LikedTypes
(
	DMID int,
	TypeID int,
	Primary Key(DMID, TypeID),
	FOREIGN KEY (DMID) REFERENCES DM ON DELETE CASCADE,  -- Preferences belong to DM
	FOREIGN KEY (TypeID) REFERENCES Type ON DELETE CASCADE  -- In case if we need to delete a type, whether a DM likes it or not won't be part of that decision
)

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='DMBooks') Create Table DMBooks
(
	DMID int,
	BookID int,
	PRIMARY KEY(DMID, BookID),
	FOREIGN KEY (DMID) REFERENCES DM ON DELETE CASCADE,  -- Literally belongs to DM
	FOREIGN KEY (BookID) REFERENCES Book ON DELETE CASCADE  -- If a book needs to be deleted, it doesn't matter how many DMs own it
)

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[calculateEncounter]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[calculateEncounter]
@PartyID int, @DM_ID int, @LikedType varchar(50) = NULL, @LikedBook varchar(50) = NULL, @DifficultyMultiplier FLOAT, @NumberOfMonsters int
AS

--
-- Selects the top 20 monsters
-- from the recommendation system. Recommends based on
-- CR level of monsters, actions of party members,
-- types and books of monsters/DM, and the difficulty
-- that the DM wants the encounter to be.
--
-- Parameters:
-- @PartyID: ID of existing, membered party
-- @DM_ID: ID of DM that owns the party
-- @LikedType: Optional, exact string match of type in db
-- @LikedBook: Optional, exact string match of book in db
-- @DifficultyMultiplier: Multiplier for how hard encounter
-- should be (likely around 0.55). Within (0, infinity).
-- @NumberOfMonsters: How many monsters that should be in the
-- encounter. Within [1, 20].
--
-- Earlier version created ?/?/? by Michael Webb
-- Recreated 5/20/21 Nathan Hurtig to make the original
-- SPROC more consistent, and to order by how 'good' the
-- encounter was

SET NOCOUNT ON

DECLARE @TargetCRLevel AS FLOAT
declare @tableSize as int

if(@DM_ID is null)
begin
return 1
end

if(@PartyID is null)
begin
return 2
end

IF ((SELECT DMID FROM Party WHERE ID = @PartyID) <> @DM_ID)
BEGIN
  RETURN 3
END

select @TargetCRLevel = AVG(CAST(Level AS FLOAT))
from Member
where PartyID = @PartyID
Group by PartyID

IF @TargetCRLevel is null
BEGIN
  RETURN 4
END

IF @DifficultyMultiplier IS NULL
BEGIN
  RETURN 5
END

IF @DifficultyMultiplier <= 0
BEGIN
  RETURN 6
END

IF (@NumberofMonsters IS NULL)
BEGIN
  RETURN 7
END

IF (@NumberofMonsters < 1 OR @NumberOfMonsters > 20)
BEGIN
  RETURN 7
END

IF (@LikedBook IS NOT NULL)
BEGIN
  IF NOT EXISTS (SELECT * FROM Book WHERE Name = @LikedBook)
  BEGIN
    RETURN 8
  END
END

IF (@LikedType IS NOT NULL)
BEGIN
  IF NOT EXISTS (SELECT * FROM Type WHERE Name = @LikedType)
  BEGIN
    RETURN 9
  END
END

SET @TargetCRLevel = @TargetCRLevel * @DifficultyMultiplier

IF(@NumberOfMonsters = 2)
begin
  SET @TargetCRLevel = @TargetCRLevel / 1.5
end
IF(@NumberOfMonsters >= 3 and @NumberOfMonsters <= 6)
begin
    SET @TargetCRLevel = @TargetCRLevel / 2
end
IF(@NumberOfMonsters >= 7 and @NumberOfMonsters <= 10)
begin
    SET @TargetCRLevel = @TargetCRLevel / 2.5
end
IF(@NumberOfMonsters >= 11 and @NumberOfMonsters <= 14)
begin
    SET @TargetCRLevel = @TargetCRLevel / 3
end
IF(@NumberOfMonsters >= 15)
begin
    SET @TargetCRLevel = @TargetCRLevel / 4
end





declare @builtEncounter as table
(
Name varchar(50),
CR decimal(5,3),
TypeName varchar(50),
BookName varchar(50),
Alignment varchar(50),
ID int
)

insert into @builtEncounter
exec FilterMonsters @DMID = @DM_ID, @LikedType = @LikedType, @LikedBook = @LikedBook

SELECT TOP 20 be.Name, be.CR, TypeName, BookName, be.Alignment, m.ID, lm.DMID AS Liked
FROM @builtEncounter be
JOIN Monster m ON m.Name = be.Name
LEFT JOIN LikedMonsters lm ON m.ID = lm.MonsterID AND lm.DMID = @DM_ID
ORDER BY ABS(be.CR - @TargetCRLevel)
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[calculateEncounter2]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[calculateEncounter2]
@PartyID int, @DM_ID int, @LikedType varchar(50) = NULL, @LikedBook varchar(50) = NULL, @DifficultyMultiplier FLOAT, @NumberOfMonsters int
AS

--
-- Selects the top 20 monsters
-- from the recommendation system. Recommends based on
-- CR level of monsters, actions of party members,
-- types and books of monsters/DM, and the difficulty
-- that the DM wants the encounter to be.
--
-- Parameters:
-- @PartyID: ID of existing, membered party
-- @DM_ID: ID of DM that owns the party
-- @LikedType: Optional, exact string match of type in db
-- @LikedBook: Optional, exact string match of book in db
-- @DifficultyMultiplier: Multiplier for how hard encounter
-- should be (likely around 0.55). Within (0, infinity).
-- @NumberOfMonsters: How many monsters that should be in the
-- encounter. Within [1, 20].
--
-- Earlier version created ?/?/? by Michael Webb
-- Recreated 5/20/21 Nathan Hurtig to make the original
-- SPROC more consistent, and to order by how 'good' the
-- encounter was

DECLARE @TargetCRLevel AS FLOAT
declare @tableSize as int

if(@DM_ID is null)
begin
return 1
end

if(@PartyID is null)
begin
return 2
end

IF ((SELECT DMID FROM Party WHERE ID = @PartyID) <> @DM_ID)
BEGIN
  RETURN 3
END

select @TargetCRLevel = AVG(CAST(Level AS FLOAT))
from Member
where PartyID = @PartyID
Group by PartyID

IF @TargetCRLevel is null
BEGIN
  RETURN 4
END

IF @DifficultyMultiplier IS NULL
BEGIN
  RETURN 5
END

IF @DifficultyMultiplier <= 0
BEGIN
  RETURN 6
END

IF (@NumberofMonsters IS NULL)
BEGIN
  RETURN 6
END

IF (@NumberofMonsters < 1 OR @NumberOfMonsters > 20)
BEGIN
  RETURN 7
END

IF (@LikedBook IS NOT NULL)
BEGIN
  IF NOT EXISTS (SELECT * FROM Book WHERE Name = @LikedBook)
  BEGIN
    RETURN 8
  END
END

IF (@LikedType IS NOT NULL)
BEGIN
  IF NOT EXISTS (SELECT * FROM Type WHERE Name = @LikedType)
  BEGIN
    RETURN 9
  END
END

SET @TargetCRLevel = @TargetCRLevel * @DifficultyMultiplier

IF(@NumberOfMonsters = 2)
begin
  SET @TargetCRLevel = @TargetCRLevel / 1.5
end
IF(@NumberOfMonsters >= 3 and @NumberOfMonsters <= 6)
begin
    SET @TargetCRLevel = @TargetCRLevel / 2
end
IF(@NumberOfMonsters >= 7 and @NumberOfMonsters <= 10)
begin
    SET @TargetCRLevel = @TargetCRLevel / 2.5
end
IF(@NumberOfMonsters >= 11 and @NumberOfMonsters <= 14)
begin
    SET @TargetCRLevel = @TargetCRLevel / 3
end
IF(@NumberOfMonsters >= 15)
begin
    SET @TargetCRLevel = @TargetCRLevel / 4
end





declare @builtEncounter as table
(
MonsterName varchar(50),
CRLevel decimal(5,3),
MonsterType varchar(50),
SourceBook varchar(50),
Alignment varchar(50)
)

insert into @builtEncounter
exec FilterMonsters @DMID = @DM_ID, @LikedType = @LikedType, @LikedBook = @LikedBook

SELECT TOP 20 *
FROM @builtEncounter be
ORDER BY ABS(CRLevel - @TargetCRLevel)
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[create_action]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<???>
-- Create date: <???>
-- Description:	<???>
-- =============================================
-- =============================================
-- Modified:		Nathan Hurtig
-- Modify date: 5/06/21
-- Description:	Modified to make description non-unique
-- and move the set NOCOUNT on and to squelch RAISERRORs
-- so the code works with pyodbc on error and to make the
-- uniqueness check functional
-- =============================================
CREATE PROCEDURE [dbo].[create_action]
	-- Add the parameters for the stored procedure here
	@Name varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
SET NOCOUNT ON;
IF (@Name is null)
BEGIN
  RETURN 1
END

IF EXISTS (SELECT * FROM Action WHERE Name = @Name)
BEGIN
  RETURN 2
END


Insert into Action(Name)
Values(@Name)
END
GO
/****** Object:  StoredProcedure [dbo].[create_book]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Parameters:
-- Book name <= 50 characters, must be unique

-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT  
-- EXEC @Status = create_book 'DM Guide'
-------------------------------------------  
-- Revision History
-- Created 4/16/21 Jackson Hajer
-- 
CREATE PROCEDURE [dbo].[create_book] (@book_name varchar(50))
AS
IF(@book_name IS NULL)
BEGIN
	PRINT('Cannot have empty name')
	RETURN 1
END
INSERT INTO Book(Name) VALUES(@book_name)
DECLARE @book_id int
SET @book_id = SCOPE_IDENTITY()
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[create_monster]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Parameters:
-- Monster name <= 50 characters
-- New name <= 50 characters, cannot be same as other names
-- CR must be 0-30, can be null
-- Book name <= 50 characters, can be null
-- type name <= 50 characters, can be null
-- Alignment 2 chars, can be null
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT  
-- EXEC @Status = create_monster @monst_name = 'Shambler', @CR = 9.0, @type_name = 'Zombie', @align = 'CE'
-------------------------------------------  
-- Revision History
-- Created 4/29/21 Jackson Hajer

CREATE PROCEDURE [dbo].[create_monster](@monst_name varchar(50),@CR decimal(5,3),@type_name varchar(50) = NULL, @book_name varchar(50) = null, @align varchar(2) = NULL)
AS
SET NOCOUNT ON
IF(@monst_name IS NULL OR @monst_name = '')
BEGIN
	PRINT('Name cannot be null or empty.')
	RETURN 1
END

IF(@CR IS NULL)
BEGIN
	PRINT('CR cannot be null.')
	RETURN 2
END

Declare @Book_ID as int

IF @book_name IS NOT NULL AND NOT EXISTS(SELECT * FROM Book WHERE Name = @book_name)
BEGIN
	Insert Into Book(Name)
	Values (@book_name)

	Select @Book_ID = ID from Book
	where @book_name = Name
END
Else
Begin
Select @Book_ID = ID from Book
where @book_name = Name
End

Declare @Type_ID as int

IF @type_name IS NOT NULL AND NOT EXISTS(SELECT * FROM Type WHERE Name = @type_name)
BEGIN
	

	Insert Into Type(Name)
	Values (@type_name)

	Select @Type_ID = ID from Type
	where @type_name = Name
END
Else
Begin
Select @Type_ID = ID from Type
where @type_name = Name
End

if EXISTS(SELECT Name from Monster where Name = @monst_name)
begin
PRINT('Monster already exists!')
return 3
end


INSERT INTO Monster(Name,CR,TypeID,BookID,Alignment) VALUES(@monst_name,@CR,@Type_ID,@Book_ID,@align)
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[create_party]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[create_party]
(
@ID_1 int,
@Name_2 varchar(30)
)
AS

--  
-- Puts a party into party table with given
-- name and DM id
--
-- Parameters:
-- ID_1: ID of existing DM
-- Name_2: <=30 characters
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT  
-- EXEC @Status = create_party @ID_1 = 8, @Name_2 = 'The Adventurers'
-- SELECT Status = @Status  
-------------------------------------------  
-- Revision History
-- Created 4/16/21 Nathan Hurtig
-- Modified 4/29/21 Nathan Hurtig got rid of RAISERROR because
-- it cuts of access to pyodbc's status code return

-- Turn NOCOUNT on because pydobc gets confused
SET NOCOUNT ON

-- Check that parameters are good  

-- Is ID good?
IF (@ID_1 is null)
BEGIN
  RETURN 1
END

IF NOT EXISTS (SELECT * FROM DM WHERE ID=@ID_1)
BEGIN
  RETURN 2
END

-- Is name good?
IF (@Name_2 is null)
BEGIN
  RETURN 3
END

-- Is name unique to the DM?
IF EXISTS (SELECT * FROM Party WHERE DMID = @ID_1 AND Name = @Name_2)
BEGIN
  RETURN 4
END


-- Insert into table
INSERT INTO Party (DMID, Name)
VALUES (@ID_1, @Name_2)

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[create_type]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Parameters:
-- Type name <= 50 characters, must be unique
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT  
-- EXEC @Status = create_type 'Undead'
-------------------------------------------  
-- Revision History
-- Created 4/29/21 Jackson Hajer
-- Modified 5/17/21 Nathan Hurtig removing type descriptions

CREATE PROCEDURE [dbo].[create_type](@type_name varchar(50))
AS
IF(@type_name IS NULL)
BEGIN
	PRINT('Name cannot be null.')
	RETURN 1
END
IF EXISTS(SELECT * FROM Type WHERE Name = @type_name)
BEGIN
	PRINT('Type already exists.')
	RETURN 2
END

INSERT INTO Type(Name) VALUES(@type_name)
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[delete_book]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Parameters:
-- Book name <= 50 characters, must be unique

-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT  
-- EXEC @Status = delete_book 'DM Guide'
-------------------------------------------  
-- Revision History
-- Created 4/29/21 Jackson Hajer
-- 
CREATE PROCEDURE [dbo].[delete_book](@book_name varchar(50))
AS 
IF(@book_name IS NULL)
BEGIN
	PRINT('Name cannot be null.')
	RETURN 1
END

IF NOT EXISTS(SELECT * FROM Book WHERE Name = @book_name)
BEGIN
	PRINT('Book does not exist.')
	RETURN 2
END

DELETE FROM Book
WHERE Name = @book_name

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[delete_member]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[delete_member]
(
@DMID_1 int,
@MemberID_2 int
)
AS

--  
-- Deletes a member with given ID.
-- Asks for DM ID
-- so it can check that the DM
-- owns it.
--
-- Parameters:
-- DMID_1: ID of existing DM
-- MemberID_2: ID of existing member owned by DM
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT  
-- EXEC @Status = delete_member @DMID_1 = 8, @MemberID_2 = 4
-- SELECT Status = @Status  
-------------------------------------------  
-- Revision History
-- Created 4/30/21 Nathan Hurtig

-- Turn NOCOUNT on because pydobc gets confused
SET NOCOUNT ON

-- Check that parameters are good  

-- Is ID good?
IF (@DMID_1 is null)
  RETURN 1

IF NOT EXISTS (SELECT * FROM DM WHERE ID=@DMID_1)
  RETURN 2

-- Is partyID good?
IF (@MemberID_2 is null)
  RETURN 3

IF NOT EXISTS (SELECT * FROM Member WHERE ID=@MemberID_2)
  RETURN 4

-- Does DM own party?
IF((SELECT DMID FROM Party WHERE ID = (SELECT PartyID FROM Member WHERE ID = @MemberID_2)) <> @DMID_1)
  RETURN 5


-- Delete
DELETE FROM Member
WHERE ID = @MemberID_2

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[delete_monster]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Parameters:
-- Monster name <= 50 characters, must be unique
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT  
-- EXEC @Status = delete_monster 'Shambler'
-------------------------------------------  
-- Revision History
-- Created 4/29/21 Jackson Hajer
-- Modified 5/21/21 Nathan Hurtig getting rid of prints so we can access return vals
--

CREATE PROCEDURE [dbo].[delete_monster](@monst_name varchar(50))
AS
SET NOCOUNT ON
IF(@monst_name IS NULL OR @monst_name = '')
BEGIN
	RETURN 1
END

IF NOT EXISTS(SELECT * FROM Monster WHERE Name = @monst_name)
BEGIN
	RETURN 2
END

DELETE FROM Monster
WHERE Name = @monst_name
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[delete_party]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[delete_party]
(
@DMID_1 int,
@PartyID_2 int
)
AS

--  
-- Deletes a party with given ID.
-- Asks for DM ID
-- so it can check that the DM
-- owns it.
--
-- Parameters:
-- DMID_1: ID of existing DM
-- PartyID_2: ID of existing party owned by DM
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT  
-- EXEC @Status = delete_party @DMID_1 = 8, @PartyID_2 = 12
-- SELECT Status = @Status  
-------------------------------------------  
-- Revision History
-- Created 4/29/21 Nathan Hurtig

-- Turn NOCOUNT on because pydobc gets confused
SET NOCOUNT ON

-- Check that parameters are good  

-- Is ID good?
IF (@DMID_1 is null)
BEGIN
  RETURN 1
END

IF NOT EXISTS (SELECT * FROM DM WHERE ID=@DMID_1)
BEGIN
  RETURN 2
END

-- Is partyID good?
IF (@PartyID_2 is null)
BEGIN
  RETURN 3
END

IF NOT EXISTS (SELECT * FROM Party WHERE ID=@PartyID_2)
BEGIN
  RETURN 4
END

-- Does DM own party?
IF((SELECT DMID FROM Party WHERE ID = @PartyID_2) <> @DMID_1)
BEGIN
  RETURN 5
END


-- Delete
DELETE FROM Party
WHERE ID = @PartyID_2

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[delete_type]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Parameters:
-- Type name <= 50 characters, must be unique
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT  
-- EXEC @Status = delete_type 'Zombie'
-------------------------------------------  
-- Revision History
-- Created 4/29/21 Jackson Hajer
CREATE PROCEDURE [dbo].[delete_type](@type_name varchar(50))
AS 
IF(@type_name IS NULL)
BEGIN
	PRINT('Name cannot be null.')
	RETURN 1
END

IF NOT EXISTS(SELECT * FROM Type WHERE Name = @type_name)
BEGIN
	PRINT('Type does not exist.')
	RETURN 2
END

DELETE FROM Type
WHERE Name = @type_name

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[edit_member]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[edit_member]
(
@DMID_1 int,
@MemberID_2 int,
@Name_3 varchar(50) = NULL,
@Class_4 varchar(30) = NULL,
@Race_5 varchar(30) = NULL,
@Alignment_6 varchar(2) = NULL,
@Level_7 int = NULL
)
AS

--  
-- Puts a member into member table with given
-- characteristics as a member of the given party
-- owned by the given DM
--
-- Parameters:
-- DMID_1: ID of existing DM
-- MemberID_2: ID of member owned by DM
-- Name_3: <=50 characters (name of member), null to not update
-- Class_4: One of the 12 base classes, string form, null to not update
-- Race_5: One of the 9 base races, string form, null to not update
-- Alignment_6: One of the 9 alignments, 2 character acronym, null to not update
-- Level_7: Level of member, within 1-20 inclusive, null to not update
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT  
-- EXEC @Status = edit_member @DMID_1 = 8, @MemberID_2 = 4, @Name_3 = 'Dingledoof'.
-- @Class_4 = 'Barbarian', @Alignment_6 = 'CN'
-- SELECT Status = @Status  
-------------------------------------------  
-- Revision History
-- Created 4/29/21 Nathan Hurtig
--

-- Turn NOCOUNT on because pydobc gets confused
SET NOCOUNT ON

-- Check that parameters are good  

-- Is DM ID good?
IF (@DMID_1 is null)
  RETURN 1

IF NOT EXISTS (SELECT * FROM DM WHERE ID=@DMID_1)
  RETURN 2

-- Is MemberID good?
IF (@MemberID_2 is null)
  RETURN 3

IF NOT EXISTS (SELECT * FROM Member WHERE ID=@MemberID_2)
  RETURN 4

-- Does the DM own the member?
IF ((SELECT DMID FROM Party WHERE ID=(SELECT PartyID FROM Member WHERE ID=@MemberID_2)) <> @DMID_1)
  RETURN 5

-- Make name good
IF (@Name_3 is null)
  SELECT @Name_3 = Name FROM Member WHERE ID=@MemberID_2

-- Make class good
IF (@Class_4 is null)
  SELECT @Class_4 = Class FROM Member WHERE ID=@MemberID_2

-- Make race good
IF (@Race_5 is null)
  SELECT @Race_5 = Race FROM Member WHERE ID=@MemberID_2

-- Make alignment good
IF (@Alignment_6 is null)
  SELECT @Alignment_6 = Alignment FROM Member WHERE ID=@MemberID_2
ELSE
-- Make sure new alignment is valid
BEGIN
  IF @Alignment_6 not in ('LG', 'NG', 'CG', 'LN', 'TN', 'CN', 'LE', 'NE', 'CE')
    RETURN 6
END

-- Make level good
IF (@Level_7 is null)
  SELECT @Level_7 = Level FROM Member WHERE ID=@MemberID_2
ELSE
-- Make sure new level is valid
BEGIN
  IF (@Level_7 not BETWEEN 1 AND 20)
    RETURN 7
END

-- Update member
UPDATE Member
SET Name = @Name_3, Class = @Class_4, Race = @Race_5, Alignment = @Alignment_6, Level = @Level_7
WHERE ID = @MemberID_2

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[edit_party]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[edit_party]
(
@DMID_1 int,
@PartyID_2 int,
@Name_3 varchar(30)
)
AS

--  
-- Renames a party with given ID
-- to given name. Asks for DM ID
-- so it can check that the DM
-- owns it.
--
-- Parameters:
-- DMID_1: ID of existing DM
-- PartyID_2: ID of existing party owned by DM
-- Name_3: <=30 characters
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT  
-- EXEC @Status = edit_party @DMID_1 = 8, @PartyID_2 = 12 , @Name_3 = 'The Boondoggles'
-- SELECT Status = @Status  
-------------------------------------------  
-- Revision History
-- Created 4/29/21 Nathan Hurtig

-- Turn NOCOUNT on because pydobc gets confused
SET NOCOUNT ON

-- Check that parameters are good  

-- Is ID good?
IF (@DMID_1 is null)
BEGIN
  RETURN 1
END

IF NOT EXISTS (SELECT * FROM DM WHERE ID=@DMID_1)
BEGIN
  RETURN 2
END

-- Is partyID good?
IF (@PartyID_2 is null)
BEGIN
  RETURN 3
END

IF NOT EXISTS (SELECT * FROM Party WHERE ID=@PartyID_2)
BEGIN
  RETURN 4
END

-- Is name good?
IF (@Name_3 is null)
BEGIN
  RETURN 5
END

-- Is name unique to the DM?
IF EXISTS (SELECT * FROM Party WHERE DMID = @DMID_1 AND Name = @Name_3 AND ID <> @PartyID_2)
BEGIN
  RETURN 6
END

-- Does DM own party?
IF((SELECT DMID FROM Party WHERE ID = @PartyID_2) <> @DMID_1)
BEGIN
  RETURN 7
END


-- Update
UPDATE Party
SET Name = @Name_3
WHERE ID = @PartyID_2

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[FilterMonsters]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[FilterMonsters]
@DMID int, @Name varchar(50) = NULL, @LikedType varchar(50) = NULL, @LikedBook varchar(50) = NULL, @MinCRLevel decimal(5,3) = NULL, @MaxCRLevel decimal(5,3) = NULL
WITH EXECUTE AS 'AccountStoredProcedureReader'
AS
if (@DMID is NULL)
begin
raiserror('DMID cannot be NULL', 1, 1)
return 1
end

if (@MinCRLevel is not NULL AND @MaxCRLevel is not NULL and @MinCRLevel > @MaxCRLevel)
begin
raiserror('Min cannot be greater than max', 1, 1)
return 2
end

Declare @TypeID int, @BookID int
Select @TypeID = ID
From Type
Where @LikedType = Name

SELECT @BookID = ID
FROM Book
WHERE @LikedBook = Name

DECLARE @sql nvarchar(max)
SET @sql = 'SELECT [Monster].Name, CR, [Type].Name As TypeName, [Book].Name As BookName, [Monster].Alignment, [Monster].ID
FROM [Monster]
Left Join [Type] on TypeID = Type.ID
Left Join [Book] on BookID = Book.ID
WHERE ([Monster].BookID is NULL OR exists(
SELECT * from [DMBooks]
where @DMID = DMID and [Monster].BookID = [DMBooks].BookID))'

IF @Name IS NOT NULL
BEGIN
	SET @sql = @sql + '
	AND Monster.Name like @Name'
END

IF @LikedType IS NOT NULL
BEGIN
	SET @sql = @sql + '
	AND TypeID = @TypeID'
END

IF @LikedBook IS NOT NULL
BEGIN
	SET @sql = @sql + '
	AND BookID = @BookID'
END

IF @MinCRLevel IS NOT NULL AND @MaxCRLevel IS NOT NULL
BEGIN
	SET @sql = @sql + '
	AND CR <= @MaxCRLevel and CR >= @MinCRLevel'
END
ELSE
BEGIN
	IF @MinCRLevel IS NULL AND @MaxCRLevel IS NOT NULL
	BEGIN
		SET @sql = @sql + '
		AND CR <= @MaxCRLevel'
	END
	IF @MinCRLevel IS NOT NULL AND @MaxCRLevel IS NULL
	BEGIN
		SET @sql = @sql + '
		AND CR >= @MinCRLevel'
	END
END

IF(@Name is NOT NULL)
BEGIN
DECLARE @VarName varchar(52)
	SET @VarName = '%'+ @Name + '%'
EXEC sp_executesql @sql,N'@DMID int,
	@Name varchar(52),
	@TypeID int,
	@BookID int,
	@MinCRLevel decimal(5,3),
	@MaxCRLevel decimal(5,3)',
	@DMID,@VarName,@TypeID,@BookID,@MinCRLevel,@MaxCRLevel;
END
ELSE
BEGIN
EXEC sp_executesql @sql,N'@DMID int,
	@Name varchar(50),
	@TypeID int,
	@BookID int,
	@MinCRLevel decimal(5,3),
	@MaxCRLevel decimal(5,3)',
	@DMID,@Name,@TypeID,@BookID,@MinCRLevel,@MaxCRLevel;
END
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[get_actions]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[get_actions]
(
@Page_1 int
)
AS

--  
-- Gets 30 actions, starting with the
-- (Page_1 - 1) * 30 th action. Ordered
-- by action name.
--
-- Parameters:
-- Page_1: Page on the actions catalog
--
-- Selects:
-- Rows containing action names, descriptions
-- Then the max page number
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT
-- EXEC @Status = get_actions @Page_1 = 3
-- SELECT Status = @Status
-------------------------------------------  
-- Revision History
-- Created 5/06/21 Nathan Hurtig

-- Turn NOCOUNT on because pydobc gets confused
SET NOCOUNT ON

-- Check that parameters are good  

-- Is ID good?
IF (@Page_1 is null OR @Page_1 < 1)
BEGIN
  RETURN 1
END

-- Check if page would have anything
DECLARE @Count int
SELECT @Count = COUNT(ID) FROM Action
IF (@Count < (30 * (@Page_1 - 1)) + 1)
BEGIN
  IF @Page_1 = 1
  BEGIN
	RETURN 3
  END
  ELSE
  BEGIN
	RETURN 2
  END
END


-- Get values
SELECT Name
FROM Action
ORDER BY Name
OFFSET (30 * (@Page_1 - 1)) ROWS FETCH NEXT 30 ROWS ONLY

-- Select max page num
SELECT CEILING(@Count / 30.0)

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[get_all_books]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[get_all_books]
(
@DMID_1 int
)
AS

--  
-- Gets all the books in the database,
-- returning their IDs, names, and whether
-- the DM currently 'has' them
--
-- Parameters:
-- DMID_1: ID of existing DM
--
-- Selects:
-- Rows containing (ID, Name, Owned) for each
-- book in the DB
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT
-- EXEC @Status = get_all_books @ID_1 = 20
-- SELECT Status = @Status
-------------------------------------------  
-- Revision History
-- Created 5/13/21 Nathan Hurtig
--

-- Turn NOCOUNT on because pydobc gets confused
SET NOCOUNT ON

-- Check that parameters are good  

-- Is ID good?
IF (@DMID_1 is null)
BEGIN
  RETURN 1
END

-- Check DM exists
IF NOT EXISTS (SELECT * FROM DM WHERE ID=@DMID_1)
BEGIN
  RETURN 2
END


-- Get values
SELECT b.ID, b.Name, SIGN(ISNULL(db.BookID, 0)) AS Owned
FROM Book b
LEFT JOIN DMBooks db ON b.ID = db.BookID AND db.DMID = @DMID_1

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[get_login_info]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[get_login_info]
(
@Username_1 varchar(30)
)
AS

--  
-- Gets the hash and salt for a DM
-- by username
--
-- Parameters:
-- Username_1: <= 30 chars, not already in table
--
-- Selects:
-- Salt, Hash, and ID of that DM
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT
-- EXEC @Status = add_user @Username_1 = theLegend27
-- SELECT Status = @Status
-------------------------------------------  
-- Revision History
-- Created 4/16/21
-- Altered 4/29/21 Nathan Hurtig to allow pyodbc
-- to access status codes on error
--

-- Turn NOCOUNT on because pydobc gets confused
SET NOCOUNT ON

-- Check that parameters are good  

-- Is Username good?
IF (@Username_1 is null)
BEGIN
  RETURN 1
END

-- Check if DM exists
IF NOT EXISTS (SELECT * FROM DM WHERE Username=@Username_1)
BEGIN
  RETURN 2
END


-- Get values
SELECT Salt AS salt, PasswordHash AS hash, ID AS ID
FROM DM
WHERE Username=@Username_1

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[get_member_info]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[get_member_info]
(
@DMID_1 int,
@MemberID_2 int
)
AS

--  
-- Gets a party member's info as long
-- as the supplied DM owns that member.
-- 2 result sets: 1 of the member's info
-- plus the party's name
-- and a second of the member's actions.
--
-- Parameters:
-- DMID_1: ID of existing DM
-- MemberID_2: ID of member owned by DM
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT  
-- EXEC @Status = get_member_info @DMID_1 = 8, @MemberID_2 = 4
-- SELECT Status = @Status  
-------------------------------------------  
-- Revision History
-- Created 4/29/21 Nathan Hurtig
--

-- Turn NOCOUNT on because pydobc gets confused
SET NOCOUNT ON

-- Check that parameters are good  

-- Is DM ID good?
IF (@DMID_1 is null)
  RETURN 1

IF NOT EXISTS (SELECT * FROM DM WHERE ID=@DMID_1)
  RETURN 2

-- Is MemberID good?
IF (@MemberID_2 is null)
  RETURN 3

IF NOT EXISTS (SELECT * FROM Member WHERE ID=@MemberID_2)
  RETURN 4


-- Does the DM own the member? 
IF ((SELECT DMID FROM Party WHERE ID=(SELECT PartyID FROM Member WHERE ID=@MemberID_2)) <> @DMID_1)
  RETURN 5

-- Select from Members table, also getting party name
SELECT Member.Name AS Name, Class, Race, Alignment, Level, Member.ID AS ID, Party.Name AS PartyName
FROM Member JOIN Party ON Member.PartyID = Party.ID
WHERE Member.ID=@MemberID_2

-- Select from Actions table
SELECT a.Name, a.ID
FROM MemberActions ma JOIN Action a ON ma.ActionID = a.ID
WHERE ma.MemberID=@MemberID_2

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[get_monster_info]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- @exact is an optional parameter to allow for exact name searches, any nonzero val is exact search
CREATE   PROCEDURE [dbo].[get_monster_info] (@name varchar(50) = NULL, @DMID int = NULL,@exact int = 0)
AS
-- Altered 5/13/21 Nathan Hurtig to return 1 when DM has liked monster, 0 when DM has not
SET NOCOUNT ON
IF(@name IS NULL)
BEGIN
	SELECT Monster.ID,Monster.Name,Monster.CR,Type.Name as TypeName,Book.Name as BookName,Monster.Alignment, SIGN(ISNULL(lm.MonsterID, 0)) as Liked
	FROM Monster
	LEFT JOIN Type ON Type.ID = Monster.TypeID
	LEFT JOIN Book ON Book.ID = Monster.BookID
	LEFT JOIN LikedMonsters lm ON lm.MonsterID = Monster.ID AND lm.DMID = @DMID
END
ELSE
BEGIN
	DECLARE @name2 varchar(52)
	IF(@exact <> 0)
	BEGIN
		SET @name2 = @name

		SELECT Monster.ID, Monster.Name, Monster.CR, Type.Name as TypeName, Book.Name as BookName,Monster.Alignment, SIGN(ISNULL(lm.MonsterID, 0)) as Liked
		FROM Monster
		LEFT JOIN Type ON Type.ID = Monster.TypeID
		LEFT JOIN Book ON Book.ID = Monster.BookID
		LEFT JOIN LikedMonsters lm ON lm.MonsterID = Monster.ID AND lm.DMID = @DMID
		WHERE Monster.Name LIKE @name2

		DECLARE @MonsterID int
		SELECT @MonsterID = ID FROM Monster WHERE Name = @name
		SELECT a.Name, a.ID
		FROM MonsterActions ma JOIN Action a ON ma.ActionID = a.ID
		WHERE ma.MonsterID=@MonsterID
	END
	ELSE
	BEGIN
		SET @name2 = '%' + @name + '%'

		SELECT Monster.ID, Monster.Name, Monster.CR, Type.Name as TypeName, Book.Name as BookName,Monster.Alignment, SIGN(ISNULL(lm.MonsterID, 0)) as Liked
		FROM Monster
		LEFT JOIN Type ON Type.ID = Monster.TypeID
		LEFT JOIN Book ON Book.ID = Monster.BookID
		LEFT JOIN LikedMonsters lm ON lm.MonsterID = Monster.ID AND lm.DMID = @DMID
		WHERE Monster.Name LIKE @name2
	END
END
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[get_party_members]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[get_party_members]
(
@ID_1 int
)
AS

--  
-- Gets the members' IDs, names, classes,
-- levels, alignments, and races for
-- a party by the party's ID
--
-- Parameters:
-- ID_1: ID of the party in the party table
--
-- Selects:
-- Rows containing (ID, name, class, level, alignment, race)
-- of party members
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT
-- EXEC @Status = get_party_members @ID_1 = 20
-- SELECT Status = @Status
-------------------------------------------  
-- Revision History
-- Created 4/16/21 Nathan Hurtig
-- Altered 4/29/21 Nathan Hurtig to allow pyodbc
-- to access status codes on error

-- Turn NOCOUNT on because pydobc gets confused
SET NOCOUNT ON

-- Check that parameters are good  

-- Is ID good?
IF (@ID_1 is null)
BEGIN
  RETURN 1
END

-- Check if party exists
IF NOT EXISTS (SELECT * FROM Party WHERE ID=@ID_1)
BEGIN
  RETURN 2
END


-- Get values
SELECT ID, Name, Class, Level, Alignment, Race
FROM Member
WHERE PartyID=@ID_1

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[get_types_and_books]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[get_types_and_books]
@DMID_1 INT
AS
--
-- Selects all the types' names in
-- the database, then all the books
-- that the given DM owns.
--
-- Parameters:
-- @DMID_1: ID of existing DM
--
-- Created 5/20/21 Nathan Hurtig

SET NOCOUNT ON

IF @DMID_1 IS NULL
BEGIN
  RETURN 1
END

IF NOT EXISTS (SELECT * FROM DM WHERE ID=@DMID_1)
BEGIN
  RETURN 2
END

-- That was easy! Now onto the selects.

SELECT Name
FROM Type

SELECT Name
FROM Book b
JOIN DMBooks db
ON b.ID = db.BookID
WHERE db.DMID = @DMID_1
GO
/****** Object:  StoredProcedure [dbo].[get_user_info]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[get_user_info]
(
@ID_1 int
)
AS

--  
-- Gets the username, party names,
-- owned books, liked monsters, and 
-- liked types for a DM by ID
--
-- Parameters:
-- ID_1: ID of the DM in the DM table
--
-- Selects:
-- Username of DM
-- Party names, party IDs
-- Owned book names, book IDs
-- Liked monster names, monster IDs
-- Liked types, type IDs
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT
-- EXEC @Status = get_user_info @ID_1 = 8
-- SELECT Status = @Status
-------------------------------------------  
-- Revision History
-- Created 4/16/21 Nathan Hurtig
-- Modified 4/29/21 Nathan Hurtig allowing pyodbc to
-- access status codes

-- Turn NOCOUNT on because pydobc gets confused
SET NOCOUNT ON

-- Check that parameters are good  

-- Is ID good?
IF (@ID_1 is null)
BEGIN
  RETURN 1
END

-- Check if DM exists
IF NOT EXISTS (SELECT * FROM DM WHERE ID=@ID_1)
BEGIN
  RETURN 2
END


-- Get values
SELECT Username AS username
FROM DM
WHERE ID=@ID_1

SELECT Name AS name, ID AS ID
FROM Party
WHERE DMID=@ID_1

SELECT Name AS name, BookID AS ID
FROM DMBooks JOIN Book ON BookID = ID
WHERE DMID=@ID_1

SELECT Name AS name, MonsterID AS ID
FROM LikedMonsters JOIN Monster ON MonsterID = ID
WHERE DMID=@ID_1

SELECT Name AS name, TypeID as ID
FROM LikedTypes JOIN Type ON TypeID = ID
WHERE DMID=@ID_1

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[search_actions]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[search_actions]
(
@Search_1 varchar(50)
)
AS

--  
-- Gets a max of 30 actions that match
-- the search parameter either in the
-- name or in the description.
--
-- Parameters:
-- Search_1: [3, 50] len
--
-- Selects:
-- Rows containing action names, descriptions
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT
-- EXEC @Status = search_actions @Search_1 = 'light'
-- SELECT Status = @Status
-------------------------------------------  
-- Revision History
-- Created 5/07/21 Nathan Hurtig

-- Turn NOCOUNT on because pydobc gets confused
SET NOCOUNT ON

-- Check that parameters are good  

-- Is Search good?
IF (@Search_1 is null OR LEN(@Search_1) < 3)
BEGIN
  RETURN 1
END
DECLARE @query varchar(52)
SET @query = '%' + @Search_1 + '%'
-- Get values
SELECT TOP 30 Name
FROM Action
WHERE Name LIKE @query

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[toggle_monster_liked]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[toggle_monster_liked]
(
@DMID_1 int,
@MonsterID_2 int
)
AS

--  
-- Toggles whether the given DM likes the
-- given monster (liked->unliked, unliked->
-- liked)
--
-- Parameters:
-- DMID_1: ID of existing DM
-- MemberID_2: ID of existing monster
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT  
-- EXEC @Status = toggle_monster_liked @DMID_1 = 8, @MonsterID_2 = 300
-- SELECT Status = @Status  
-------------------------------------------  
-- Revision History
-- Created 5/13/21 Nathan Hurtig
--

-- Turn NOCOUNT on because pydobc gets confused
SET NOCOUNT ON

-- Check that parameters are good  

-- Is DM ID good?
IF (@DMID_1 is null)
  RETURN 1

IF NOT EXISTS (SELECT * FROM DM WHERE ID=@DMID_1)
  RETURN 2

-- Is MemberID good?
IF (@MonsterID_2 is null)
  RETURN 3

IF NOT EXISTS (SELECT * FROM Monster WHERE ID=@MonsterID_2)
  RETURN 4

-- Make change
IF EXISTS (SELECT * FROM LikedMonsters WHERE DMID=@DMID_1 AND MonsterID=@MonsterID_2)
BEGIN
-- DM likes currently, now need to delete the record
DELETE FROM LikedMonsters
WHERE DMID=@DMID_1 AND MonsterID=@MonsterID_2
END
ELSE
BEGIN
-- DM doesn't like currently, need to create the record
-- Insert into table
INSERT INTO LikedMonsters(DMID, MonsterID)
VALUES (@DMID_1, @MonsterID_2)
END

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[update_book]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Parameters:
-- Book name <= 50 characters, must be unique
-- New book name <= 50 characters, must be unique
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT  
-- EXEC @Status = update_book 'DM Guide' 'Dungeon Master Guide'
-------------------------------------------  
-- Revision History
-- Created 4/29/21 Jackson Hajer

CREATE PROCEDURE [dbo].[update_book](@book_name varchar(50),@new_name varchar(50))
AS

-- check for nulls
IF(@book_name IS NULL OR @new_name IS NULL)
BEGIN
	PRINT('Neither name can be null.')
	RETURN 1
END

-- check for unique name
IF EXISTS(SELECT * FROM Book WHERE Name = @new_name)
BEGIN
	PRINT('New name cannot be the same as existing book.')
	RETURN 2
END

-- update book name
UPDATE Book
SET Name = @new_name
WHERE Name = @book_name

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[update_book_owned]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[update_book_owned]
(
@DMID_1 int,
@BookID_2 int,
@NewValue_3 smallint
)
AS

--  
-- Updates a specific entry in
-- the DMBooks table to the specified
-- value.
--
-- Parameters:
-- DMID_1: ID of existing DM
-- BookID_2: ID of existing book
-- NewValue_3: 0 for not owned, 1 for owned
--
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT
-- EXEC @Status = update_book_owned @DMID_1 = 20, @BookID_2 = 9, @NewValue_3 = 1
-- SELECT Status = @Status
-------------------------------------------  
-- Revision History
-- Created 5/13/21 Nathan Hurtig
--

-- Turn NOCOUNT on because pydobc gets confused
SET NOCOUNT ON

-- Check that parameters are good  

-- Is DMID good?
IF (@DMID_1 is null)
BEGIN
  RETURN 1
END

-- Check DM exists
IF NOT EXISTS (SELECT * FROM DM WHERE ID=@DMID_1)
BEGIN
  RETURN 2
END

-- Is BookID good?
IF (@BookID_2 is null)
BEGIN
  RETURN 3
END

IF NOT EXISTS (SELECT * FROM Book WHERE ID=@BookID_2)
BEGIN
  RETURN 4
END

-- Is NewValue good?
IF (@NewValue_3 is null)
BEGIN
  RETURN 5
END

IF (@NewValue_3 <> 0 AND @NewValue_3 <> 1)
BEGIN
  RETURN 6
END

-- Make the change
IF (@NewValue_3 = 0)
BEGIN
  DELETE FROM DMBooks
  WHERE DMID=@DMID_1 AND BookID=@BookID_2
END
ELSE
BEGIN
  INSERT INTO DMBooks (DMID, BookID)
  VALUES (@DMID_1, @BookID_2)
END

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[update_monster]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Parameters:
-- Monster name <= 50 characters
-- New name <= 50 characters, cannot be same as other names
-- CR must be 0-30, can be null
-- Book name <= 50 characters, can be null
-- type name <= 50 characters, can be null
-- Alignment 2 chars, can be null
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT  
-- EXEC @Status = update_monster @monst_name = 'Shambler', @new_name = 'Crawler', @type_name = 'Zombie', @align = 'CE'
-------------------------------------------  
-- Revision History
-- Created 4/29/21 Jackson Hajer
-- Altered 5/21/21 Nathan Hurtig adding check that orig name is valid, getting rid of prints so we can access status codes

CREATE PROCEDURE [dbo].[update_monster](@monst_name varchar(50),@new_name varchar(50) = NULL,@CR decimal(5,3) = NULL,@type_name varchar(50) = NULL, @book_name varchar(50) = null, @align varchar(2) = null)
AS
SET NOCOUNT ON
IF(@monst_name IS NULL OR @monst_name = '')
BEGIN
	RETURN 1
END

IF EXISTS(SELECT * FROM Monster WHERE Name = @new_name)
BEGIN
	RETURN 2
END

IF @book_name IS NOT NULL AND NOT EXISTS(SELECT * FROM Book WHERE Name = @book_name)
BEGIN
	RETURN 3
END

IF @type_name IS NOT NULL AND NOT EXISTS(SELECT * FROM Type WHERE Name = @type_name)
BEGIN
	RETURN 4
END

IF NOT EXISTS (SELECT * FROM Monster WHERE Name=@monst_name)
BEGIN
  RETURN 5
END

DECLARE @monst_id int
SELECT @monst_id = ID
FROM Monster
WHERE Name = @monst_name

DECLARE @book_id int
SELECT @book_id = ID
FROM Book
WHERE Name = @book_name

DECLARE @type_id int
SELECT @type_id = ID
FROM Type
WHERE Name = @type_name


IF(@new_name IS NOT NULL)
BEGIN
	UPDATE Monster
	SET Name = @new_name
	WHERE ID = @monst_id
END

IF(@CR IS NOT NULL)
BEGIN
	UPDATE Monster
	SET CR = @CR
	WHERE ID = @monst_id
END

IF(@type_name IS NOT NULL)
BEGIN
	UPDATE Monster
	SET TypeID = @type_id
	WHERE ID = @monst_id
END

IF(@book_name IS NOT NULL)
BEGIN
	UPDATE Monster
	SET BookID = @book_id
	WHERE ID = @monst_id
END

IF(@align IS NOT NULL)
BEGIN
	UPDATE Monster
	SET Alignment = @align
	WHERE ID = @monst_id
END

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[update_type]    Script Date: 05/21/21 10:30:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Parameters:
-- Type name <= 50 characters, must exist
-- New name <= 50 characters, must be unique or the same as the first name
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT  
-- EXEC @Status = update_type 'Undead' 'Zombie'
-------------------------------------------  
-- Revision History
-- Created 4/29/21 Jackson Hajer
-- Modified 5/17/21 Nathan Hurtig removing description
CREATE PROCEDURE [dbo].[update_type](@type_name varchar(50),@new_name varchar(50))
AS
IF(@type_name IS NULL)
BEGIN
	PRINT('Original type name cannot be null')
	RETURN 1
END

IF(@new_name <> @type_name)
BEGIN
	UPDATE Type
	SET Name = @new_name
	WHERE Name = @type_name
END

RETURN 0
GO

GRANT EXECUTE ON [delete_party] TO application  
GRANT EXECUTE ON [create_party] TO application  
GRANT EXECUTE ON [add_member] TO application  
GRANT EXECUTE ON [get_member_info] TO application  
GRANT EXECUTE ON [edit_member] TO application  
GRANT EXECUTE ON [delete_member] TO application  
GRANT EXECUTE ON [get_monster_info] TO application  
GRANT EXECUTE ON [FilterMonsters] TO application  
GRANT EXECUTE ON [get_actions] TO application  
GRANT EXECUTE ON [add_action] TO application  
GRANT EXECUTE ON [create_action] TO application  
GRANT EXECUTE ON [get_user_info] TO application  
GRANT EXECUTE ON [search_actions] TO application  
GRANT EXECUTE ON [toggle_monster_liked] TO application  
GRANT EXECUTE ON [add_monster_action] TO application  
GRANT EXECUTE ON [get_all_books] TO application  
GRANT EXECUTE ON [update_book_owned] TO application  
GRANT EXECUTE ON [calculateEncounter] TO application  
GRANT EXECUTE ON [calculateEncounter2] TO application  
GRANT EXECUTE ON [get_types_and_books] TO application  
GRANT EXECUTE ON [add_user] TO application  
GRANT EXECUTE ON [get_login_info] TO application  
GRANT EXECUTE ON [build_tables] TO application  
GRANT EXECUTE ON [create_book] TO application  
GRANT EXECUTE ON [delete_book] TO application  
GRANT EXECUTE ON [update_book] TO application  
GRANT EXECUTE ON [create_type] TO application  
GRANT EXECUTE ON [delete_type] TO application  
GRANT EXECUTE ON [update_type] TO application  
GRANT EXECUTE ON [create_monster] TO application  
GRANT EXECUTE ON [update_monster] TO application  
GRANT EXECUTE ON [delete_monster] TO application  
GRANT EXECUTE ON [edit_party] TO application  
GRANT EXECUTE ON [get_party_members] TO application  

USE [master]
GO
ALTER DATABASE [EncounterCreator_FinalS2G3] SET  READ_WRITE 
GO
