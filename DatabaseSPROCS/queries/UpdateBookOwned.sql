CREATE PROCEDURE update_book_owned
(
@DMID_1 int,
@BookID_2 int,
@NewValue_3 smallint
)
AS

--  
-- Updates a specific entry in
-- the DMBooks table to the specified
-- value.
--
-- Parameters:
-- DMID_1: ID of existing DM
-- BookID_2: ID of existing book
-- NewValue_3: 0 for not owned, 1 for owned
--
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT
-- EXEC @Status = update_book_owned @DMID_1 = 20, @BookID_2 = 9, @NewValue_3 = 1
-- SELECT Status = @Status
-------------------------------------------  
-- Revision History
-- Created 5/13/21 Nathan Hurtig
--

-- Turn NOCOUNT on because pydobc gets confused
SET NOCOUNT ON

-- Check that parameters are good  

-- Is DMID good?
IF (@DMID_1 is null)
BEGIN
  RETURN 1
END

-- Check DM exists
IF NOT EXISTS (SELECT * FROM DM WHERE ID=@DMID_1)
BEGIN
  RETURN 2
END

-- Is BookID good?
IF (@BookID_2 is null)
BEGIN
  RETURN 3
END

IF NOT EXISTS (SELECT * FROM Book WHERE ID=@BookID_2)
BEGIN
  RETURN 4
END

-- Is NewValue good?
IF (@NewValue_3 is null)
BEGIN
  RETURN 5
END

IF (@NewValue_3 <> 0 AND @NewValue_3 <> 1)
BEGIN
  RETURN 6
END

-- Make the change
IF (@NewValue_3 = 0)
BEGIN
  DELETE FROM DMBooks
  WHERE DMID=@DMID_1 AND BookID=@BookID_2
END
ELSE
BEGIN
  INSERT INTO DMBooks (DMID, BookID)
  VALUES (@DMID_1, @BookID_2)
END

RETURN 0