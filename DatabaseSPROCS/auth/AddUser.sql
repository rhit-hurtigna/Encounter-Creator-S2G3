CREATE PROCEDURE add_user
(
@Username_1 varchar(30),
@Salt_2 varchar(32),
@PasswordHash_3 varchar(128)
)
AS

--  
-- Puts a user into the DM table with
-- the given username & login info
--
-- Parameters:
-- Username_1: <= 30 chars, not already in table
-- Salt_2: 16 random bytes converted to hex
-- PasswordHash_3: 64 bytes of SHA-512 hashed password
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT  
-- EXEC @Status = add_user @Username_1 = theLegend27, @Salt_2 = [32 hex chars], @PasswordHash_3 = [128 hex chars]
-- SELECT Status = @Status  
-------------------------------------------  
-- Revision History
-- Created 4/16/21
--

-- Turn NOCOUNT on because pydobc gets confused
SET NOCOUNT ON

-- Check that parameters are good  

-- Is Username good?
IF (@Username_1 is null)
BEGIN
  RAISERROR('Username must not be null', 10, 1)
  RETURN 1
END

IF EXISTS (SELECT * FROM DM WHERE Username=@Username_1)
BEGIN
  RAISERROR('Username already taken', 10, 1)
  RETURN 2
END

-- Is salt good?
IF (@Salt_2 is null)
BEGIN
  RAISERROR('Salt must not be null', 10, 1)
  RETURN 3
END

-- Is password good?
IF (@PasswordHash_3 is null)
BEGIN
  RAISERROR('Password hash must not be null', 10, 1)
  RETURN 4
END


-- Insert into table
INSERT INTO DM (Username, Salt, PasswordHash)
VALUES (@Username_1, @Salt_2, @PasswordHash_3)

RETURN 0