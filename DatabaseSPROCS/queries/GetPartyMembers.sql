CREATE PROCEDURE get_party_members
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