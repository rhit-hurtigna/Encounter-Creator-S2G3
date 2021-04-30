CREATE PROCEDURE delete_member
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