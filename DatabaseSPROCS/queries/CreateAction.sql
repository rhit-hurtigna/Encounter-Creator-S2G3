USE [EncounterCreatorS2G3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<???>
-- Create date: <???>
-- Description:	<???>
-- =============================================
-- =============================================
-- Modified:		Nathan Hurtig
-- Modify date: 5/06/21
-- Description:	Modified to make description non-unique
-- and move the set NOCOUNT on and to squelch RAISERRORs
-- so the code works with pyodbc on error and to make the
-- uniqueness check functional
-- =============================================
CREATE PROCEDURE [dbo].[create_action]
	-- Add the parameters for the stored procedure here
	@Name varchar(50),
	@Description varchar(200)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
SET NOCOUNT ON;
IF (@Name is null)
BEGIN
  RETURN 1
END

IF EXISTS (SELECT * FROM Action WHERE Name = @Name)
BEGIN
  RETURN 2
END


Insert into Action(Name, Description)
Values(@Name, @Description)
END
GO