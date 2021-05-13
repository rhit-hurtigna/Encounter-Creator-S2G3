USE [EncounterCreatorS2G3]
GO

/****** Object:  StoredProcedure [dbo].[get_monster_info]    Script Date: 05/13/21 7:49:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- @exact is an optional parameter to allow for exact name searches, any nonzero val is exact search
CREATE PROCEDURE [dbo].[get_monster_info] (@name varchar(50) = NULL, @DMID int = NULL,@exact int = 0)
AS
-- Altered 5/13/21 Nathan Hurtig to return 1 when DM has liked monster, 0 when DM has not
-- Altered 5/13/21 Nathan Hurtig fixing bugs that got introduced at some point after my last revision
SET NOCOUNT ON
IF(@name IS NULL)
BEGIN
	SELECT Monster.ID,Monster.Name,Monster.CR,Type.Name as TypeName,Book.Name as BookName,Monster.Alignment, SIGN(ISNULL(lm.MonsterID, 0)) as Liked
	FROM Monster
	LEFT JOIN Type ON Type.ID = Monster.TypeID
	LEFT JOIN Book ON Book.ID = Monster.BookID
	LEFT JOIN LikedMonsters lm ON lm.MonsterID = Monster.ID AND lm.DMID = @DMID
END
ELSE
BEGIN
	DECLARE @name2 varchar(52)
	IF(@exact <> 0)
	BEGIN
		SET @name2 = @name

		SELECT Monster.ID, Monster.Name, Monster.CR, Type.Name as TypeName, Book.Name as BookName,Monster.Alignment, SIGN(ISNULL(lm.MonsterID, 0)) as Liked
		FROM Monster
		LEFT JOIN Type ON Type.ID = Monster.TypeID
		LEFT JOIN Book ON Book.ID = Monster.BookID
		LEFT JOIN LikedMonsters lm ON lm.MonsterID = Monster.ID AND lm.DMID = @DMID
		WHERE Monster.Name LIKE @name2

		DECLARE @MonsterID int
		SELECT @MonsterID = ID FROM Monster WHERE Name = @name
		SELECT a.Name, a.ID
		FROM MonsterActions ma JOIN Action a ON ma.ActionID = a.ID
		WHERE ma.MonsterID=@MonsterID
	END
	ELSE
	BEGIN
		SET @name2 = '%' + @name + '%'

		SELECT Monster.ID, Monster.Name, Monster.CR, Type.Name as TypeName, Book.Name as BookName,Monster.Alignment, SIGN(ISNULL(lm.MonsterID, 0)) as Liked
		FROM Monster
		LEFT JOIN Type ON Type.ID = Monster.TypeID
		LEFT JOIN Book ON Book.ID = Monster.BookID
		LEFT JOIN LikedMonsters lm ON lm.MonsterID = Monster.ID AND lm.DMID = @DMID
		WHERE Monster.Name LIKE @name2
	END
END
RETURN 0
GO

