USE LAB_3
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID (N'Goals', N'U') IS NOT NULL 
   DROP TABLE [dbo].Goals

IF OBJECT_ID (N'GamesData', N'U') IS NOT NULL 
   DROP TABLE [dbo].GamesData

IF OBJECT_ID (N'TeamTypes', N'U') IS NOT NULL 
   DROP TABLE [dbo].TeamTypes

IF OBJECT_ID (N'Games', N'U') IS NOT NULL 
   DROP TABLE [dbo].Games

IF OBJECT_ID (N'Players', N'U') IS NOT NULL 
   DROP TABLE [dbo].Players

IF OBJECT_ID (N'Teams', N'U') IS NOT NULL 
   DROP TABLE [dbo].Teams

CREATE TABLE [dbo].Teams(
	ID int IDENTITY(1,1),
	TeamName [nvarchar](50) NOT NULL
	PRIMARY KEY (ID)
)
GO

CREATE TABLE [dbo].Players(
	ID int IDENTITY(1,1),
	Name [nchar](50) NOT NULL,
	Surname [nchar](50) NOT NULL,
	Team int FOREIGN KEY REFERENCES Teams(ID) NOT NULL
	PRIMARY KEY (ID)
)
GO

CREATE TABLE [dbo].Games(
	ID int IDENTITY(1,1),
	GameDate smalldatetime,
	PRIMARY KEY (ID)
)
GO

CREATE TABLE [dbo].TeamTypes(
	ID int IDENTITY(1,1),
	TeamType nchar(50)
	PRIMARY KEY (ID)
)
GO

CREATE TABLE [dbo].GamesData(
	GameID int FOREIGN KEY REFERENCES Games(ID),
	TeamID int FOREIGN KEY REFERENCES Teams(ID),
	Goalkeeper int FOREIGN KEY REFERENCES Players(ID),
	TeamType int FOREIGN KEY REFERENCES TeamTypes(ID),
	Goals int
)
GO

CREATE TABLE [dbo].Goals(
	ID int IDENTITY(1,1),
	GameID int FOREIGN KEY REFERENCES Games(ID),
	PlayerID int FOREIGN KEY REFERENCES Players(ID)
	PRIMARY KEY(ID)
)
GO

INSERT INTO Teams(TeamName) values ('Tigers')
INSERT INTO Teams(TeamName) values ('Red Bulls')
INSERT INTO Teams(TeamName) values ('Pony Fans')
INSERT INTO Teams(TeamName) values ('Dinosaur Sons')

INSERT INTO Players(Name, Surname, Team) values ('Don', 'Juan', 1)
INSERT INTO Players(Name, Surname, Team) values ('Peter', 'Dunklage', 1)
INSERT INTO Players(Name, Surname, Team) values ('Jon', 'Snowy', 1)
INSERT INTO Players(Name, Surname, Team) values ('Daenerys', 'Tartarien', 1)
INSERT INTO Players(Name, Surname, Team) values ('Bobby', 'Catson', 1)
INSERT INTO Players(Name, Surname, Team) values ('Donny', 'Voronov', 1)

INSERT INTO Players(Name, Surname, Team) values ('Kill', 'Bill', 2)
INSERT INTO Players(Name, Surname, Team) values ('God', 'Ofcats', 2)
INSERT INTO Players(Name, Surname, Team) values ('Vine', 'Mainer', 2)
INSERT INTO Players(Name, Surname, Team) values ('Micha', 'Karlensky', 2)
INSERT INTO Players(Name, Surname, Team) values ('Bear', 'Forrest', 2)
INSERT INTO Players(Name, Surname, Team) values ('Torin', 'Dogshield', 2)

INSERT INTO Players(Name, Surname, Team) values ('Legolas', 'Blondhair', 3)
INSERT INTO Players(Name, Surname, Team) values ('Kylo', 'Dren', 3)
INSERT INTO Players(Name, Surname, Team) values ('Darth', 'Voder', 3)
INSERT INTO Players(Name, Surname, Team) values ('Thranduil', 'Oropherion', 3)
INSERT INTO Players(Name, Surname, Team) values ('Obi', 'van Kenobi', 3)
INSERT INTO Players(Name, Surname, Team) values ('Blet', 'Romelny', 3)

INSERT INTO Players(Name, Surname, Team) values ('Black', 'Jack', 4)
INSERT INTO Players(Name, Surname, Team) values ('Tony', 'Stark', 4)
INSERT INTO Players(Name, Surname, Team) values ('Goga', 'Helltrooper', 4)
INSERT INTO Players(Name, Surname, Team) values ('Chaos', 'Warrior', 4)
INSERT INTO Players(Name, Surname, Team) values ('Dark', 'Elf', 4)
INSERT INTO Players(Name, Surname, Team) values ('Gala', 'Driel', 4)

INSERT INTO TeamTypes(TeamType) values ('Host')
INSERT INTO TeamTypes(TeamType) values ('Guest')

INSERT INTO Games(GameDate) values ('05.06.2017')
INSERT INTO GamesData(GameID, TeamID, Goalkeeper, TeamType, Goals) values (1, 1, 6, 1, 3)
INSERT INTO GamesData(GameID, TeamID, Goalkeeper, TeamType, Goals) values (1, 2, 6, 2, 1)

INSERT INTO Games(GameDate) values ('06.06.2017')
INSERT INTO GamesData(GameID, TeamID, Goalkeeper, TeamType, Goals) values (2, 1, 6, 2, 1)
INSERT INTO GamesData(GameID, TeamID, Goalkeeper, TeamType, Goals) values (2, 3, 6, 1, 1)

INSERT INTO Games(GameDate) values ('07.06.2017')
INSERT INTO GamesData(GameID, TeamID, Goalkeeper, TeamType, Goals) values (3, 1, 6, 1, 2)
INSERT INTO GamesData(GameID, TeamID, Goalkeeper, TeamType, Goals) values (3, 4, 6, 2, 3)

INSERT INTO Games(GameDate) values ('08.06.2017')
INSERT INTO GamesData(GameID, TeamID, Goalkeeper, TeamType, Goals) values (4, 2, 6, 1, 5)
INSERT INTO GamesData(GameID, TeamID, Goalkeeper, TeamType, Goals) values (4, 3, 6, 2, 3)

INSERT INTO Games(GameDate) values ('09.06.2017')
INSERT INTO GamesData(GameID, TeamID, Goalkeeper, TeamType, Goals) values (5, 2, 6, 2, 4)
INSERT INTO GamesData(GameID, TeamID, Goalkeeper, TeamType, Goals) values (5, 4, 6, 1, 0)

INSERT INTO Games(GameDate) values ('12.06.2017')
INSERT INTO GamesData(GameID, TeamID, Goalkeeper, TeamType, Goals) values (6, 3, 6, 1, 0)
INSERT INTO GamesData(GameID, TeamID, Goalkeeper, TeamType, Goals) values (6, 4, 6, 2, 0)

---Функции---

IF OBJECT_ID (N'dbo.GetPointsCommand', N'FN') IS NOT NULL
	DROP FUNCTION dbo.GetPointsCommand
GO

CREATE FUNCTION dbo.GetPointsCommand(@CommandID int)  
RETURNS INT
BEGIN
	declare @pointsWins int = (SELECT Count(t1.TeamID)
							FROM GamesData t1
							INNER JOIN GamesData t2 ON t1.GameID = t2.GameID
							WHERE t1.Goals > t2.Goals AND t1.TeamID = @CommandID AND t1.TeamID != t2.TeamID)
	declare @pointsDraws int = (SELECT Count(t1.TeamID)
							FROM GamesData t1
							INNER JOIN GamesData t2 ON t1.GameID = t2.GameID
							WHERE t1.Goals = t2.Goals AND t1.TeamID = @CommandID AND t1.TeamID != t2.TeamID)
	return @pointsWins*3 + @pointsDraws;
END;
GO

IF OBJECT_ID (N'dbo.GetCountGoalsOnEnemyField', N'FN') IS NOT NULL
    DROP FUNCTION dbo.GetCountGoalsOnEnemyField
GO
CREATE FUNCTION dbo.GetCountGoalsOnEnemyField(@CommandID int)  
RETURNS INT
BEGIN
    return (SELECT SUM(t1.Goals)
                FROM GamesData t1
                INNER JOIN GamesData t2 ON t1.GameID = t2.GameID
                WHERE t1.TeamID = @CommandID AND t1.TeamID != t2.TeamID AND t1.TeamType = 2)
END;
GO
 
IF OBJECT_ID (N'dbo.GetWinsCommand', N'FN') IS NOT NULL
    DROP FUNCTION dbo.GetWinsCommand
GO
CREATE FUNCTION dbo.GetWinsCommand(@CommandID int)  
RETURNS INT
BEGIN
    return (SELECT Count(t1.TeamID)
                            FROM GamesData t1
                            INNER JOIN GamesData t2 ON t1.GameID = t2.GameID
                            WHERE t1.Goals > t2.Goals AND t1.TeamID = @CommandID AND t1.TeamID != t2.TeamID)
END;
GO

---Рейтинговая таблица---

IF OBJECT_ID (N'dbo.GamesTab', N'U') IS NOT NULL
	DROP VIEW dbo.GamesTab
GO

CREATE VIEW dbo.GamesTab
AS
SELECT Teams.TeamName AS 'Команда',
	dbo.GetPointsCommand(t1.TeamID) AS 'Очки',
	dbo.GetWinsCommand(t1.TeamID) AS 'Победы',
	dbo.GetCountGoalsOnEnemyField(t1.TeamID) AS 'Голы на поле соперника',
	SUM(t1.Goals) AS 'Забито',
	SUM(t2.Goals) AS 'Пропущено',
	SUM(t1.Goals) - SUM(t2.Goals) AS 'Забито-пропущено'
FROM GamesData t1
	INNER JOIN GamesData t2 ON t1.GameID = t2.GameID
	INNER JOIN Teams ON t1.TeamID = Teams.ID
WHERE t1.TeamID != t2.TeamID
GROUP BY Teams.TeamName, t1.TeamID
GO

IF OBJECT_ID (N'dbo.GamesTabSort', N'U') IS NOT NULL
	DROP VIEW dbo.GamesTabSort
GO

CREATE VIEW dbo.GamesTabSort
AS
SELECT TOP 100 *
FROM GamesTab
ORDER BY 'Очки' DESC, 'Победы' DESC, 'Голы на поле соперника' DESC, 'Пропущено' ASC
GO

SELECT *
FROM GamesTabSort

---Таблицы матчей (вспомогательный вью)---

IF OBJECT_ID (N'dbo.GamesTabResults', N'U') IS NOT NULL
	DROP VIEW dbo.GamesTabResults
GO

CREATE VIEW dbo.GamesResults
AS
SELECT t1n.TeamName AS 'Команда',
	CONCAT(t1.Goals, ' - ', t2.Goals) AS 'Счет',
	t2n.TeamName AS 'Соперник',
	gts.Очки
	--t2.Goals AS 'Забито гостем'
FROM GamesData t1
	INNER JOIN GamesData t2 ON t1.GameID = t2.GameID
	INNER JOIN Teams t1n ON t1.TeamID = t1n.ID
	INNER JOIN Teams t2n ON t2.TeamID = t2n.ID
	INNER JOIN GamesTabSort gts ON t1n.TeamName = gts.Команда
WHERE t1.TeamID != t2.TeamID 
--AND t1.TeamType = 1
GROUP BY t1n.TeamName, t1.Goals, t2n.TeamName, t2.Goals, gts.Очки
GO


SELECT *
FROM GamesResults

---Статическая таблица матчей---

SELECT [Команда], ISNULL([Tigers], ' ') AS [Tigers], ISNULL([Red Bulls], ' ') AS [Red Bulls], ISNULL([Pony Fans], ' ') AS [Pony Fans], ISNULL([Dinosaur Sons], ' ') AS [Dinosaur Sons], [Очки]
    FROM dbo.GamesResults
PIVOT (MAX([Счет]) FOR [Соперник] in ([Tigers], [Red Bulls], [Pony Fans], [Dinosaur Sons])
       ) AS test_pivot
ORDER BY [Команда] DESC

---Динамическая---

DECLARE @DynamicPivotQuery AS NVARCHAR(MAX)
DECLARE @ColumnName AS NVARCHAR(MAX)
DECLARE @SelectColumnName AS NVARCHAR(MAX)

SELECT @ColumnName= ISNULL(@ColumnName + ', ','') 
       + QUOTENAME(TeamName)
FROM (SELECT DISTINCT TeamName FROM Teams) AS Teams
--SET @ColumnName = REPLACE(@ColumnName, ' ', '')
--PRINT(@ColumnName)

SELECT @SelectColumnName = ISNULL(@SelectColumnName + ',','') 
	   + 'ISNULL(' + QUOTENAME(TeamName) + ', '' '') AS '
       + QUOTENAME(TeamName)
FROM (SELECT DISTINCT TeamName FROM Teams) AS Teams

SET @DynamicPivotQuery = 
  N'SELECT [Команда], ' + @SelectColumnName + ', [Очки]
    FROM dbo.GamesResults
    PIVOT (MAX([Счет]) FOR [Соперник] in (' + @ColumnName + ')
       ) AS test_pivot
	ORDER BY [Команда]'
PRINT(@DynamicPivotQuery)

EXEC sp_executesql @DynamicPivotQuery