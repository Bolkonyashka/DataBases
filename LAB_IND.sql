USE LAB_IND
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------

IF OBJECT_ID (N'BoatsTypes', N'U') IS NOT NULL 
   DROP TABLE BoatsTypes

CREATE TABLE BoatsTypes (
ID int IDENTITY(1,1),
BoatType [nvarchar](50) NOT NULL,
PRIMARY KEY (ID)
)
GO

INSERT INTO BoatsTypes(BoatType) values ('� ��������� �������')
INSERT INTO BoatsTypes(BoatType) values ('�� ���������� �������')
UPDATE BoatsTypes SET BoatType='� ��������� �������' WHERE ID=1
UPDATE BoatsTypes SET BoatType='�� ���������� �������' WHERE ID=2

----------------------------------------------------

IF OBJECT_ID (N'BoatsPasports', N'U') IS NOT NULL 
   DROP TABLE BoatsPasports

CREATE TABLE BoatsPasports (
ID int IDENTITY(1,1),
BoatName [nvarchar](50) NOT NULL,
BoatType int FOREIGN KEY REFERENCES BoatsTypes(ID),
BoatDisplacement int NOT NULL,
ConstructionDate smalldatetime,
PRIMARY KEY (BoatName)
)
GO

INSERT INTO BoatsPasports(BoatName, BoatType, BoatDisplacement, ConstructionDate) values ('��������', 2, 80, '23.05.2013')
INSERT INTO BoatsPasports(BoatName, BoatType, BoatDisplacement, ConstructionDate) values ('�������', 2, 114, '11.09.2009')
INSERT INTO BoatsPasports(BoatName, BoatType, BoatDisplacement, ConstructionDate) values ('����� ������', 1, 14, '03.06.2015')
INSERT INTO BoatsPasports(BoatName, BoatType, BoatDisplacement, ConstructionDate) values ('��������', 2, 131, '15.08.2016')
INSERT INTO BoatsPasports(BoatName, BoatType, BoatDisplacement, ConstructionDate) values ('�����', 1, 23, '15.03.2006')
INSERT INTO BoatsPasports(BoatName, BoatType, BoatDisplacement, ConstructionDate) values ('����', 2, 150, '13.06.2011')
INSERT INTO BoatsPasports(BoatName, BoatType, BoatDisplacement, ConstructionDate) values ('���������', 2, 100, '22.11.2015')
INSERT INTO BoatsPasports(BoatName, BoatType, BoatDisplacement, ConstructionDate) values ('���������', 2, 90, '30.07.2013')

----------------------------------------------------

IF OBJECT_ID (N'Posts', N'U') IS NOT NULL 
   DROP TABLE Posts

CREATE TABLE Posts (
ID int IDENTITY(1,1),
PostName [nvarchar](50) NOT NULL,
PRIMARY KEY (ID)
)
GO

INSERT INTO Posts(PostName) values ('�������')
INSERT INTO Posts(PostName) values ('������')
INSERT INTO Posts(PostName) values ('������')

----------------------------------------------------

IF OBJECT_ID (N'CatchType', N'U') IS NOT NULL 
   DROP TABLE CatchType

CREATE TABLE CatchType (
ID int IDENTITY(1,1),
FishName [nvarchar](50) NOT NULL,
PRIMARY KEY (FishName)
)
GO

INSERT INTO CatchType(FishName) values ('������')
INSERT INTO CatchType(FishName) values ('�����')
INSERT INTO CatchType(FishName) values ('������')
INSERT INTO CatchType(FishName) values ('������')

----------------------------------------------------

IF OBJECT_ID (N'Persons', N'U') IS NOT NULL 
   DROP TABLE Persons

CREATE TABLE Persons (
ID int IDENTITY(1,1),
FirstName [nvarchar](50) NOT NULL,
LastName [nvarchar](50) NOT NULL,
Patronymic [nvarchar](50) NOT NULL,
PRIMARY KEY (ID)
)
GO

INSERT INTO Persons(FirstName, LastName, Patronymic) values ('���������', '��������', '�����������')
INSERT INTO Persons(FirstName, LastName, Patronymic) values ('��������', '��������', '����������')
INSERT INTO Persons(FirstName, LastName, Patronymic) values ('����', '�������', '����������')
INSERT INTO Persons(FirstName, LastName, Patronymic) values ('�����', '�������', '����������')
INSERT INTO Persons(FirstName, LastName, Patronymic) values ('��������', '�����', '������������')
INSERT INTO Persons(FirstName, LastName, Patronymic) values ('�����', '�������', '���������')
INSERT INTO Persons(FirstName, LastName, Patronymic) values ('��������', '����������', '��������')
INSERT INTO Persons(FirstName, LastName, Patronymic) values ('��������', '���', '����������')
INSERT INTO Persons(FirstName, LastName, Patronymic) values ('������', '����������', '��������')
INSERT INTO Persons(FirstName, LastName, Patronymic) values ('������', '������', '�����')
INSERT INTO Persons(FirstName, LastName, Patronymic) values ('��������', '�����', '�����')
INSERT INTO Persons(FirstName, LastName, Patronymic) values ('����', '��������', '����������')
INSERT INTO Persons(FirstName, LastName, Patronymic) values ('�����', '�������', '����������')
INSERT INTO Persons(FirstName, LastName, Patronymic) values ('�������', '���������', '����������')
INSERT INTO Persons(FirstName, LastName, Patronymic) values ('������', '���������', '����������')
INSERT INTO Persons(FirstName, LastName, Patronymic) values ('������', '���������', '������������')
INSERT INTO Persons(FirstName, LastName, Patronymic) values ('��������', '����������', '���������')
INSERT INTO Persons(FirstName, LastName, Patronymic) values ('���', '�������', '����������')
INSERT INTO Persons(FirstName, LastName, Patronymic) values ('������', '�������', '����������')
INSERT INTO Persons(FirstName, LastName, Patronymic) values ('�����', '��������', '������������')

----------------------------------------------------

IF OBJECT_ID (N'FishPlaces', N'U') IS NOT NULL 
   DROP TABLE FishPlaces

CREATE TABLE FishPlaces (
ID int IDENTITY(1,1),
PlaceName [nvarchar](50) NOT NULL,
PRIMARY KEY (ID)
)
GO

INSERT INTO FishPlaces(PlaceName) values ('���������')
INSERT INTO FishPlaces(PlaceName) values ('����������')
INSERT INTO FishPlaces(PlaceName) values ('��������')
INSERT INTO FishPlaces(PlaceName) values ('��������')
INSERT INTO FishPlaces(PlaceName) values ('��������')
INSERT INTO FishPlaces(PlaceName) values ('�������������')
INSERT INTO FishPlaces(PlaceName) values ('������������')
INSERT INTO FishPlaces(PlaceName) values ('��������')

----------------------------------------------------

IF OBJECT_ID (N'Quality', N'U') IS NOT NULL 
   DROP TABLE Quality

CREATE TABLE Quality (
ID int IDENTITY(1,1),
QName [nvarchar](50) NOT NULL,
PRIMARY KEY (ID)
)
GO

INSERT INTO Quality(QName) values ('��������')
INSERT INTO Quality(QName) values ('�������')
INSERT INTO Quality(QName) values ('������')

----------------------------------------------------

IF OBJECT_ID (N'SailingRegistration', N'U') IS NOT NULL 
   DROP TABLE SailingRegistration

CREATE TABLE SailingRegistration (
ID int IDENTITY(1,1),
BoatName [nvarchar](50) FOREIGN KEY REFERENCES BoatsPasports(BoatName),
DateFrom smalldatetime,
DateTo smalldatetime,
PRIMARY KEY (ID)
)
GO

----------------------------------------------------

IF OBJECT_ID (N'CatchWeight', N'U') IS NOT NULL 
   DROP TABLE CatchWeight

CREATE TABLE CatchWeight (
SailingID int FOREIGN KEY REFERENCES SailingRegistration(ID),
CatchType [nvarchar](50) FOREIGN KEY REFERENCES CatchType(FishName),
CatchWeight int,
)
GO

----------------------------------------------------

IF OBJECT_ID (N'Crews', N'U') IS NOT NULL 
   DROP TABLE Crews

CREATE TABLE Crews (
SailingID int FOREIGN KEY REFERENCES SailingRegistration(ID),
PersonID int FOREIGN KEY REFERENCES Persons(ID),
CrewPost int FOREIGN KEY REFERENCES Posts(ID),
)
GO

----------------------------------------------------

IF OBJECT_ID (N'FPlacesRegistration', N'U') IS NOT NULL 
   DROP TABLE FPlacesRegistration

CREATE TABLE FPlacesRegistration (
ID int IDENTITY(1,1),
SailingID int FOREIGN KEY REFERENCES SailingRegistration(ID),
FishPlaceID int FOREIGN KEY REFERENCES FishPlaces(ID),
DateTo smalldatetime,
DateFrom smalldatetime,
FishQuality int FOREIGN KEY REFERENCES Quality(ID),
CatchCount int NOT NULL,
)
GO

--------------�������-------------------------------

IF OBJECT_ID (N'CheckFPlaces', N'TR') IS NOT NULL 
   DROP TRIGGER CheckFPlaces
GO

CREATE TRIGGER CheckFPlaces
ON FPlacesRegistration
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @insDateTo smalldatetime = (SELECT TOP 1 DateTo
										FROM inserted)
	DECLARE @insSailingID int = (SELECT TOP 1 SailingID
										FROM inserted)
	DECLARE @insFishPlaceID int = (SELECT TOP 1 FishPlaceID
										FROM inserted)
	DECLARE @insDateFrom smalldatetime = (SELECT TOP 1 DateFrom
										FROM inserted)
	DECLARE @insFishQuality int = (SELECT TOP 1 FishQuality
										FROM inserted)
	DECLARE @insCatchCount int = (SELECT TOP 1 CatchCount
										FROM inserted)
	DECLARE @lastDate smalldatetime = (SELECT TOP 1 DateFrom
									   FROM FPlacesRegistration
									   WHERE SailingID = @insSailingID
									   ORDER BY DateTo DESC)
	DECLARE @sailingStart smalldatetime = (SELECT TOP 1 DateFrom
										   FROM SailingRegistration
										   WHERE ID = @insSailingID)
	DECLARE @sailingEnd smalldatetime = (SELECT TOP 1 DateTo
										 FROM SailingRegistration
										 WHERE ID = @insSailingID)
	IF (NOT @insDateTo <= @lastDate AND NOT @insDateTo <= @sailingStart AND NOT @insDateFrom >= @sailingEnd AND NOT @insDateTo >= @insDateFrom) OR (NOT EXISTS (SELECT SailingID FROM FPlacesRegistration WHERE  SailingID = @insSailingID))
		INSERT INTO FPlacesRegistration values (@insSailingID, @insFishPlaceID, @insDateTo, @insDateFrom, @insFishQuality, @insCatchCount)
	ELSE
		BEGIN
			PRINT '������: ����� �� ����� ������� �� �����, �������� �� ������ �����/�������� ��� �������� ������ � ����� ����� �� ������� ������� ������ �� ���/����� �������� ������, ��� ��������.'
			PRINT '����� ������ ��������:'
			PRINT @sailingStart
			PRINT '����� �������� � ��������� �����:'
			PRINT @lastDate
			PRINT '����� �������� �� ����� �����:'
			PRINT @insDateTo
			PRINT '����� �������� � ����� �����:'
			PRINT @insDateFrom
			PRINT '����� ��������� ��������:'
			PRINT @sailingEnd
		END
END
GO

--------------��������������� ������----------------

INSERT INTO SailingRegistration(BoatName, DateFrom, DateTo) values ('��������', '01.07.2017 06:00', '03.07.2017 21:35')
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (1, 1, 1)
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (1, 2, 2)
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (1, 3, 3)
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (1, 4, 3)
		INSERT INTO CatchWeight(SailingID, CatchType, CatchWeight) values (1, '������', 300)
		INSERT INTO CatchWeight(SailingID, CatchType, CatchWeight) values (1, '������', 452)
			INSERT INTO FPlacesRegistration(SailingID, FishPlaceID, DateTo, DateFrom, FishQuality, CatchCount) values (1, 1, '01.07.2017 21:00', '02.07.2017 07:00', 1, 750)
			INSERT INTO FPlacesRegistration(SailingID, FishPlaceID, DateTo, DateFrom, FishQuality, CatchCount) values (1, 2, '02.07.2017 08:00', '02.07.2017 12:30', 2, 467)
			INSERT INTO FPlacesRegistration(SailingID, FishPlaceID, DateTo, DateFrom, FishQuality, CatchCount) values (1, 3, '02.07.2017 14:00', '02.07.2017 21:00', 1, 653)
			INSERT INTO FPlacesRegistration(SailingID, FishPlaceID, DateTo, DateFrom, FishQuality, CatchCount) values (1, 4, '02.07.2017 22:30', '03.07.2017 19:00', 3, 587)

INSERT INTO SailingRegistration(BoatName, DateFrom, DateTo) values ('���������', '02.07.2017  06:00', '04.07.2017 14:05')
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (2, 5, 1)
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (2, 6, 2)
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (2, 7, 3)
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (2, 8, 3)
		INSERT INTO CatchWeight(SailingID, CatchType, CatchWeight) values (2, '������', 564)
		INSERT INTO CatchWeight(SailingID, CatchType, CatchWeight) values (2, '������', 241)
			INSERT INTO FPlacesRegistration(SailingID, FishPlaceID, DateTo, DateFrom, FishQuality, CatchCount) values (2, 3, '02.07.2017 13:15', '02.07.2017 23:50', 2, 1276)
			INSERT INTO FPlacesRegistration(SailingID, FishPlaceID, DateTo, DateFrom, FishQuality, CatchCount) values (2, 7, '03.07.2017 08:00', '04.07.2017 04:30', 2, 467)


INSERT INTO SailingRegistration(BoatName, DateFrom, DateTo) values ('��������', '02.07.2017  06:00', '03.07.2017 18:55')
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (3, 9, 1)
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (3, 10, 2)
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (3, 11, 3)
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (3, 12, 3)
		INSERT INTO CatchWeight(SailingID, CatchType, CatchWeight) values (3, '������', 432)
		INSERT INTO CatchWeight(SailingID, CatchType, CatchWeight) values (3, '������', 125)
		INSERT INTO CatchWeight(SailingID, CatchType, CatchWeight) values (3, '������', 876)
		INSERT INTO CatchWeight(SailingID, CatchType, CatchWeight) values (3, '�����', 312)
			INSERT INTO FPlacesRegistration(SailingID, FishPlaceID, DateTo, DateFrom, FishQuality, CatchCount) values (3, 8, '02.07.2017 08:00', '02.07.2017 16:00', 3, 234)
			INSERT INTO FPlacesRegistration(SailingID, FishPlaceID, DateTo, DateFrom, FishQuality, CatchCount) values (3, 5, '02.07.2017 17:00', '02.07.2017 22:30', 1, 355)
			INSERT INTO FPlacesRegistration(SailingID, FishPlaceID, DateTo, DateFrom, FishQuality, CatchCount) values (3, 6, '03.07.2017 04:00', '03.07.2017 16:00', 3, 500)


INSERT INTO SailingRegistration(BoatName, DateFrom, DateTo) values ('�����', '04.07.2017  06:00', '04.07.2017 23:55')
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (4, 13, 1)
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (4, 14, 2)
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (4, 15, 3)
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (4, 16, 3)
		INSERT INTO CatchWeight(SailingID, CatchType, CatchWeight) values (4, '������', 234)
		INSERT INTO CatchWeight(SailingID, CatchType, CatchWeight) values (4, '������', 358)
			INSERT INTO FPlacesRegistration(SailingID, FishPlaceID, DateTo, DateFrom, FishQuality, CatchCount) values (4, 3, '04.07.2017 07:00', '04.07.2017 22:00', 1, 854)


INSERT INTO SailingRegistration(BoatName, DateFrom, DateTo) values ('����� ������', '04.07.2017  06:00', '07.07.2017 08:35')
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (5, 17, 1)
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (5, 18, 2)
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (5, 19, 3)
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (5, 20, 3)
		INSERT INTO CatchWeight(SailingID, CatchType, CatchWeight) values (5, '�����', 1249)
			INSERT INTO FPlacesRegistration(SailingID, FishPlaceID, DateTo, DateFrom, FishQuality, CatchCount) values (5, 7, '04.07.2017 11:40', '04.07.2017 21:00', 1, 346)
			INSERT INTO FPlacesRegistration(SailingID, FishPlaceID, DateTo, DateFrom, FishQuality, CatchCount) values (5, 5, '05.07.2017 08:00', '06.07.2017 02:30', 2, 257)
			INSERT INTO FPlacesRegistration(SailingID, FishPlaceID, DateTo, DateFrom, FishQuality, CatchCount) values (5, 2, '06.07.2017 14:00', '06.07.2017 23:00', 3, 653)


INSERT INTO SailingRegistration(BoatName, DateFrom, DateTo) values ('�������', '05.07.2017 06:00', '07.07.2017 11:25')
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (6, 1, 1)
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (6, 2, 2)
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (6, 3, 3)
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (6, 4, 3)
		INSERT INTO CatchWeight(SailingID, CatchType, CatchWeight) values (6, '������', 165)
		INSERT INTO CatchWeight(SailingID, CatchType, CatchWeight) values (6, '�����', 210)
			INSERT INTO FPlacesRegistration(SailingID, FishPlaceID, DateTo, DateFrom, FishQuality, CatchCount) values (6, 2, '05.07.2017 16:00', '06.07.2017 07:00', 3, 400)
			INSERT INTO FPlacesRegistration(SailingID, FishPlaceID, DateTo, DateFrom, FishQuality, CatchCount) values (6, 3, '06.07.2017 08:00', '07.07.2017 09:30', 1, 655)


INSERT INTO SailingRegistration(BoatName, DateFrom, DateTo) values ('����', '05.07.2017  06:00', '06.07.2017 19:40')
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (7, 5, 1)
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (7, 6, 2)
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (7, 7, 3)
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (7, 8, 3)
		INSERT INTO CatchWeight(SailingID, CatchType, CatchWeight) values (7, '������', 300)
		INSERT INTO CatchWeight(SailingID, CatchType, CatchWeight) values (7, '������', 264)
		INSERT INTO CatchWeight(SailingID, CatchType, CatchWeight) values (7, '�����', 122)
			INSERT INTO FPlacesRegistration(SailingID, FishPlaceID, DateTo, DateFrom, FishQuality, CatchCount) values (7, 3, '05.07.2017 14:00', '06.07.2017 01:00', 1, 456)
			INSERT INTO FPlacesRegistration(SailingID, FishPlaceID, DateTo, DateFrom, FishQuality, CatchCount) values (7, 8, '06.07.2017 08:00', '06.07.2017 18:30', 1, 344)


INSERT INTO SailingRegistration(BoatName, DateFrom, DateTo) values ('��������', '06.07.2017  06:00', '09.07.2017 03:00')
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (8, 9, 1)
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (8, 10, 2)
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (8, 11, 3)
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (8, 12, 3)
		INSERT INTO CatchWeight(SailingID, CatchType, CatchWeight) values (8, '������', 540)
		INSERT INTO CatchWeight(SailingID, CatchType, CatchWeight) values (8, '�����', 490)
			INSERT INTO FPlacesRegistration(SailingID, FishPlaceID, DateTo, DateFrom, FishQuality, CatchCount) values (8, 4, '07.07.2017 15:00', '08.07.2017 17:00', 2, 1240)

INSERT INTO SailingRegistration(BoatName, DateFrom, DateTo) values ('����', '08.07.2017  06:00', '10.07.2017 14:30')
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (9, 13, 1)
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (9, 14, 2)
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (9, 15, 3)
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (9, 16, 3)
		INSERT INTO CatchWeight(SailingID, CatchType, CatchWeight) values (9, '������', 176)
		INSERT INTO CatchWeight(SailingID, CatchType, CatchWeight) values (9, '������', 133)
		INSERT INTO CatchWeight(SailingID, CatchType, CatchWeight) values (9, '������', 345)
		INSERT INTO CatchWeight(SailingID, CatchType, CatchWeight) values (9, '�����', 144)
			INSERT INTO FPlacesRegistration(SailingID, FishPlaceID, DateTo, DateFrom, FishQuality, CatchCount) values (9, 3, '08.07.2017 09:00', '08.07.2017 22:00', 1, 342)
			INSERT INTO FPlacesRegistration(SailingID, FishPlaceID, DateTo, DateFrom, FishQuality, CatchCount) values (9, 4, '09.07.2017 08:00', '09.07.2017 12:30', 3, 443)
			INSERT INTO FPlacesRegistration(SailingID, FishPlaceID, DateTo, DateFrom, FishQuality, CatchCount) values (9, 5, '09.07.2017 14:00', '09.07.2017 21:00', 1, 145)
			INSERT INTO FPlacesRegistration(SailingID, FishPlaceID, DateTo, DateFrom, FishQuality, CatchCount) values (9, 7, '10.07.2017 00:30', '10.07.2017 13:00', 1, 344)

INSERT INTO SailingRegistration(BoatName, DateFrom, DateTo) values ('�����', '09.07.2017  06:00', '10.07.2017 20:00')
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (10, 17, 1)
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (10, 18, 2)
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (10, 19, 3)
	INSERT INTO Crews(SailingID, PersonID, CrewPost) values (10, 20, 3)
		INSERT INTO CatchWeight(SailingID, CatchType, CatchWeight) values (10, '������', 987)
			INSERT INTO FPlacesRegistration(SailingID, FishPlaceID, DateTo, DateFrom, FishQuality, CatchCount) values (10, 6, '09.07.2017 13:00', '09.07.2017 16:00', 1, 750)
			INSERT INTO FPlacesRegistration(SailingID, FishPlaceID, DateTo, DateFrom, FishQuality, CatchCount) values (10, 7, '09.07.2017 18:00', '09.07.2017 22:30', 2, 467)
			INSERT INTO FPlacesRegistration(SailingID, FishPlaceID, DateTo, DateFrom, FishQuality, CatchCount) values (10, 8, '10.07.2017 07:00', '10.07.2017 18:00', 1, 653)



----------------------�������-----------------------

--1) �� ���������� ���� � ��������� ��� ������� ��� ������, �������������� ����� � ����, ������ ��� ������� � ��������������� ������� ������ � ����� � ���� � ��������� �����.
DECLARE @type nvarchar
DECLARE @SDate smalldatetime
DECLARE @EDate smalldatetime

SET @type = '� ��������� �������'
SET @SDate = '01.07.2017'
SET @EDate = '10.07.2017'




----------------------------------------------------