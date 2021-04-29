CREATE PROCEDURE create_party
(
@ID_1 int,
@Name_2 varchar(30)
)
AS

--  
-- Puts a party into party table with given
-- name and DM id
--
-- Parameters:
-- ID_1: ID of existing DM
-- Name_2: <=30 characters
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT  
-- EXEC @Status = create_party @ID_1 = 8, @Name_2 = 'The Adventurers'
-- SELECT Status = @Status  
-------------------------------------------  
-- Revision History
-- Created 4/16/21 Nathan Hurtig
-- Modified 4/29/21 Nathan Hurtig got rid of RAISERROR because
-- it cuts of access to pyodbc's status code return

-- Turn NOCOUNT on because pydobc gets confused
SET NOCOUNT ON

-- Check that parameters are good  

-- Is ID good?
IF (@ID_1 is null)
BEGIN
  RETURN 1
END

IF NOT EXISTS (SELECT * FROM DM WHERE ID=@ID_1)
BEGIN
  RETURN 2
END

-- Is name good?
IF (@Name_2 is null)
BEGIN
  RETURN 3
END

-- Is name unique to the DM?
IF EXISTS (SELECT * FROM Party WHERE DMID = @ID_1 AND Name = @Name_2)
BEGIN
  RETURN 4
END


-- Insert into table
INSERT INTO Party (DMID, Name)
VALUES (@ID_1, @Name_2)

RETURN 0