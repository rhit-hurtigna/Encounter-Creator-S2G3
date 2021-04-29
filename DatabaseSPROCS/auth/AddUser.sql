CREATE PROCEDURE add_user
(
@Username_1 varchar(30),
@Salt_2 varchar(32),
@PasswordHash_3 varchar(128),
@NewID_4 int OUTPUT
)
AS

--  
-- Puts a user into the DM table with
-- the given username & login info. Outputs
-- the ID of the new DM if successful.
--
-- Parameters:
-- Username_1: <= 30 chars, not already in table
-- Salt_2: 16 random bytes converted to hex
-- PasswordHash_3: 64 bytes of SHA-512 hashed password
-- NewID_4: The ID of the new DM if successful
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT  
-- DECLARE @NewID INT
-- EXEC @Status = add_user @Username_1 = theLegend27, @Salt_2 = [32 hex chars], @PasswordHash_3 = [128 hex chars], @NewID_4 = @NewID OUTPUT
-- SELECT Status = @Status, NewID = @NewID
-------------------------------------------  
-- Revision History
-- Created 4/16/21 Nathan Hurtig
-- Modified 4/22/21 Nathan Hurtig to return ID of new user
-- Modified 4/29/21 Nathan Hurtig to allow pyodbc
-- to access status codes on error
-- 

-- Turn NOCOUNT on because pydobc gets confused
SET NOCOUNT ON

-- Check that parameters are good  

-- Is Username good?
IF (@Username_1 is null)
BEGIN
  RETURN 1
END

IF EXISTS (SELECT * FROM DM WHERE Username=@Username_1)
BEGIN
  RETURN 2
END

-- Is salt good?
IF (@Salt_2 is null)
BEGIN
  RETURN 3
END

-- Is password good?
IF (@PasswordHash_3 is null)
BEGIN
  RETURN 4
END


-- Insert into table
INSERT INTO DM (Username, Salt, PasswordHash)
VALUES (@Username_1, @Salt_2, @PasswordHash_3)

SET @NewID_4 = SCOPE_IDENTITY()

RETURN 0