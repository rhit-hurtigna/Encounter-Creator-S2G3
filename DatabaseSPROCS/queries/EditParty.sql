CREATE PROCEDURE edit_party
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