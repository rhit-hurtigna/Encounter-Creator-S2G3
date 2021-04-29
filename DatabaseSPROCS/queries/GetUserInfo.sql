CREATE PROCEDURE get_user_info
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