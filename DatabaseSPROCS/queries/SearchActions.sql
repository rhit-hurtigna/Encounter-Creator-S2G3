CREATE PROCEDURE search_actions
(
@Search_1 varchar(50)
)
AS

--  
-- Gets a max of 30 actions that match
-- the search parameter either in the
-- name or in the description.
--
-- Parameters:
-- Search_1: [3, 50] len
--
-- Selects:
-- Rows containing action names, descriptions
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT
-- EXEC @Status = search_actions @Search_1 = 'light'
-- SELECT Status = @Status
-------------------------------------------  
-- Revision History
-- Created 5/07/21 Nathan Hurtig

-- Turn NOCOUNT on because pydobc gets confused
SET NOCOUNT ON

-- Check that parameters are good  

-- Is Search good?
IF (@Search_1 is null OR LEN(@Search_1) < 3)
BEGIN
  RETURN 1
END
DECLARE @query varchar(100)
SET @query = '"' + @Search_1 + '*"'
-- Get values
SELECT TOP 30 Name
FROM Action
WHERE CONTAINS((Name), @query)

RETURN 0