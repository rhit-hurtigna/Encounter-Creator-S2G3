CREATE PROCEDURE edit_member
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