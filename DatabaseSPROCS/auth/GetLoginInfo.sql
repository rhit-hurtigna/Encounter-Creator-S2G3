CREATE PROCEDURE get_login_info
(
@Username_1 varchar(30)
)
AS

--  
-- Gets the hash and salt for a DM
-- by username
--
-- Parameters:
-- Username_1: <= 30 chars, not already in table
--
-- Selects:
-- Salt, Hash, and ID of that DM
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT
-- EXEC @Status = add_user @Username_1 = theLegend27
-- SELECT Status = @Status
-------------------------------------------  
-- Revision History
-- Created 4/16/21
-- Altered 4/29/21 Nathan Hurtig to allow pyodbc
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

-- Check if DM exists
IF NOT EXISTS (SELECT * FROM DM WHERE Username=@Username_1)
BEGIN
  RETURN 2
END


-- Get values
SELECT Salt AS salt, PasswordHash AS hash, ID AS ID
FROM DM
WHERE Username=@Username_1

RETURN 0