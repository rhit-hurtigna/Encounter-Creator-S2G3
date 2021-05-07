CREATE PROCEDURE get_actions
(
@Page_1 int
)
AS

--  
-- Gets 100 actions, starting with the
-- (Page_1 - 1) * 100 th action. Ordered
-- by action name.
--
-- Parameters:
-- Page_1: Page on the actions catalog
--
-- Selects:
-- Rows containing action names, descriptions
-- Then boolean as to whether there are more pages
-------------------------------------------  
-- Demo:  
-- DECLARE @Status SMALLINT
-- EXEC @Status = get_actions @Page_1 = 3
-- SELECT Status = @Status
-------------------------------------------  
-- Revision History
-- Created 5/06/21 Nathan Hurtig

-- Turn NOCOUNT on because pydobc gets confused
SET NOCOUNT ON

-- Check that parameters are good  

-- Is ID good?
IF (@Page_1 is null)
BEGIN
  RETURN 1
END

-- Check if page would have anything
DECLARE @Count int
SELECT @Count = COUNT(ID) FROM Action
IF (@Count < (100 * (@Page_1 - 1)) + 1)
BEGIN
  RETURN 2
END


-- Get values
SELECT Name, Description
FROM Action
ORDER BY Name
OFFSET (100 * (@Page_1 - 1)) ROWS FETCH NEXT 100 ROWS ONLY

-- Select whether there should be a next page
IF(@Count < (100 * (@Page_1)) + 1)
  SELECT 0
ELSE
  SELECT 1

RETURN 0