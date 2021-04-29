CREATE PROCEDURE delete_party
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