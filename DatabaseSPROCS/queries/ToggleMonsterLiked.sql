CREATE PROCEDURE toggle_monster_liked
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