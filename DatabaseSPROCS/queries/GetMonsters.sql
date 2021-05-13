USE [EncounterCreatorS2G3]
GO

/****** Object:  StoredProcedure [dbo].[get_monster_info]    Script Date: 05/13/21 4:12:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[get_monster_info] (@name varchar(50) = NULL, @DMID int = NULL)
AS
-- Altered 5/13/21 Nathan Hurtig to return 1 when DM has liked monster, 0 when DM has not
SET NOCOUNT ON
IF(@name IS NULL)
	SELECT Monster.ID,Monster.Name,Monster.CR,Type.Name as TypeName,Book.Name as BookName,Monster.Alignment, SIGN(ISNULL(lm.MonsterID, 0)) as Liked
	FROM Monster
	LEFT JOIN Type ON Type.ID = Monster.TypeID
	LEFT JOIN Book ON Book.ID = Monster.BookID
	LEFT JOIN LikedMonsters lm ON lm.MonsterID = Monster.ID AND lm.DMID = @DMID
ELSE
	DECLARE @name2 varchar(52)
	SET @name2 = '%' + @name + '%'
	SELECT Monster.ID, Monster.Name, Monster.CR, Type.Name as TypeName, Book.Name as BookName,Monster.Alignment, (0.5 * SIGN(ISNULL(lm.MonsterID, -1)) + 1) as Liked
	FROM Monster
	LEFT JOIN Type ON Type.ID = Monster.TypeID
	LEFT JOIN Book ON Book.ID = Monster.BookID
	LEFT JOIN LikedMonsters lm ON lm.MonsterID = Monster.ID
	WHERE Monster.Name LIKE @name2 AND lm.DMID = @DMID
RETURN 0
GO


