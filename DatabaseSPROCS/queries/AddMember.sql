CREATE PROCEDURE add_member
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