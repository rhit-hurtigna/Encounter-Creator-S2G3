CREATE PROCEDURE add_action
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