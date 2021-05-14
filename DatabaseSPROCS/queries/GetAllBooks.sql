CREATE PROCEDURE get_all_books
(
@DMID_1 int
)
AS

--  
-- Gets all the books in the database,
-- returning their IDs, names, and whether
-- the DM currently 'has' them
--
-- Parameters:
-- DMID_1: ID of existing DM
--
-- Selects:
-- Rows containing (ID, Name, Owned) for each
-- book in the DB
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT
-- EXEC @Status = get_all_books @ID_1 = 20
-- SELECT Status = @Status
-------------------------------------------  
-- Revision History
-- Created 5/13/21 Nathan Hurtig
--

-- Turn NOCOUNT on because pydobc gets confused
SET NOCOUNT ON

-- Check that parameters are good  

-- Is ID good?
IF (@DMID_1 is null)
BEGIN
  RETURN 1
END

-- Check DM exists
IF NOT EXISTS (SELECT * FROM DM WHERE ID=@DMID_1)
BEGIN
  RETURN 2
END


-- Get values
SELECT b.ID, b.Name, SIGN(ISNULL(db.BookID, 0)) AS Owned
FROM Book b
LEFT JOIN DMBooks db ON b.ID = db.BookID AND db.DMID = @DMID_1

RETURN 0