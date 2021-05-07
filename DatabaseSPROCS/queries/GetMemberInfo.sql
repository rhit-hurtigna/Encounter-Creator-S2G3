CREATE PROCEDURE get_member_info
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
SELECT a.Name, a.Description, a.ID
FROM MemberActions ma JOIN Action a ON ma.ActionID = a.ID
WHERE ma.MemberID=@MemberID_2

RETURN 0