-- Group 8 Video Game Store Database Implementation
-- Group member : Anqi Guan, Chuhan Xu, Lin Ye, Xinyu Qiu, Yuwen Mai
-- CREATE DATABASE VideoGameStore;
-- USE VideoGameStore;  

/*WARNING: Only executes when testing
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS Preference;
DROP TABLE IF EXISTS GamePlatform;
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS [Order];
DROP TABLE IF EXISTS Game;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Developer;
DROP TABLE IF EXISTS Publisher;
DROP TABLE IF EXISTS Genre;
DROP TABLE IF EXISTS Platform;
*/

-- PART1 Create tables
CREATE TABLE Customer (
  CustomerID INT IDENTITY NOT NULL PRIMARY KEY,
  FirstName VARCHAR(26) NOT NULL,
  LastName VARCHAR(26) NOT NULL,
  BirthDate DATE NOT NULL,
  Gender VARCHAR(10) NOT NULL CONSTRAINT CHK_GENDER CHECK (Gender IN ('Male', 'Female')),
  StreetAddress VARCHAR(255) NOT NULL,
  City VARCHAR(255) NOT NULL,
  Zipcode VARCHAR(10) NOT NULL,
  PhoneNumber VARCHAR(20) NOT NULL
);
-- Employee
CREATE TABLE Employee (
  EmployeeID INT IDENTITY NOT NULL PRIMARY KEY,
  FirstName VARCHAR(26) NOT NULL,
  LastName VARCHAR(26) NOT NULL
);
-- Developer
CREATE TABLE Developer (
  DeveloperID INT IDENTITY NOT NULL PRIMARY KEY,
  FirstName VARCHAR(26) NOT NULL,
  LastName VARCHAR(26) NOT NULL
);
-- Publisher
CREATE TABLE Publisher (
  PublisherID INT IDENTITY NOT NULL PRIMARY KEY,
  PublisherName VARCHAR(255) NOT NULL
);
-- Genre
CREATE TABLE Genre (
  GenreID INT IDENTITY NOT NULL PRIMARY KEY,
  GenreName VARCHAR(255) NOT NULL
);
-- Platform
CREATE TABLE Platform (
  PlatformID INT IDENTITY NOT NULL PRIMARY KEY,
  PlatformName VARCHAR(255) NOT NULL,
  ReleaseYear INT NOT NULL
);
-- Game
CREATE TABLE Game (
  GameID INT IDENTITY NOT NULL PRIMARY KEY,
  GenreID INT NOT NULL
  	REFERENCES Genre(GenreID),
  PublisherID INT NOT NULL
  	 REFERENCES Publisher(PublisherID),
  DeveloperID INT NOT NULL
  	REFERENCES Developer(DeveloperID),
  GameName VARCHAR(255) NOT NULL,
  Price DECIMAL(10, 2) NOT NULL,
  ReleaseYear INT NOT NULL,
);
-- Inventory
CREATE TABLE Inventory (
  InventoryID INT IDENTITY NOT NULL,
  GameID INT NOT NULL
  	REFERENCES Game(GameID),
  Quantity INT NOT NULL,
  CONSTRAINT PKInventoryItems PRIMARY KEY CLUSTERED (InventoryID, GameID)
  -- Create composite primary key
);
-- GamePlatform
CREATE TABLE GamePlatform (
  GameID INT NOT NULL,
  PlatformID INT NOT NULL,
  FOREIGN KEY (GameID) REFERENCES Game(GameID),
  FOREIGN KEY (PlatformID) REFERENCES Platform(PlatformID),
  CONSTRAINT PKGamePlatformItems PRIMARY KEY CLUSTERED (GameID, PlatformID)
);
-- Order
CREATE TABLE [Order] (
  OrderID INT IDENTITY NOT NULL PRIMARY KEY,
  CustomerID INT NOT NULL
  	REFERENCES Customer(CustomerID),
  EmployeeID INT NOT NULL
  	REFERENCES Employee(EmployeeID),
  OrderDate DATE NOT NULL
);
-- Preference
CREATE TABLE Preference (
  PreferenceID INT IDENTITY NOT NULL PRIMARY KEY,
  CustomerID INT NOT NULL
  	 REFERENCES Customer(CustomerID),
  GenreID INT NOT NULL
  	REFERENCES Genre(GenreID),
  PublisherID INT NOT NULL
  	REFERENCES Publisher(PublisherID)
);
-- Payment
CREATE TABLE Payment (
  PaymentID INT IDENTITY NOT NULL PRIMARY KEY,
  OrderID INT NOT NULL
  	REFERENCES [Order](OrderID),
  TotalPrice DECIMAL(10, 2) NOT NULL,
  Status VARCHAR(10) NOT NULL CONSTRAINT CHK_STATUS CHECK (Status IN ('Successful', 'Pending', 'Denied')),
  Type VARCHAR(50) NOT NULL
);
-- OrderDetails
CREATE TABLE OrderDetails (
  OrderDetailsID INT IDENTITY NOT NULL PRIMARY KEY,
  OrderID INT NOT NULL
  	REFERENCES [Order](OrderID),
  GameID INT NOT NULL
  	REFERENCES Game(GameID),
  Quantity INT NOT NULL,
  TotalPrice DECIMAL(10, 2) 
);



-- PART2 Insert data
-- Inserting into Genre
INSERT INTO Genre (GenreName) VALUES
('Action'),
('Adventure'),
('RPG'),
('Shooter'),
('Strategy'),
('Puzzle'),
('Arcade'),
('Simulation'),
('Horror'),
('Sports'),
('Fighting'),
('Platformer'),
('Racing'),
('Sports Simulation'),
('MMORPG'),
('Battle Royale'),
('Sandbox'),
('Music'),
('Educational'),
('Visual Novel');
-- Inserting into Publisher
INSERT INTO Publisher (PublisherName) VALUES
('Electronic Arts'),
('Activision'),
('Ubisoft'),
('Nintendo'),
('Sony Interactive Entertainment'),
('Square Enix'),
('Sega'),
('Bandai Namco Entertainment'),
('Bethesda Softworks'),
('Capcom'),
('Valve'),
('Epic Games'),
('Rockstar Games'),
('Electronic Arts Sports'),
('Blizzard Entertainment'),
('Moonton'),
('Riot Games'),
('Supercell'),
('NetEase'),
('miHoYo');
-- Inserting into Developer
INSERT INTO Developer (FirstName, LastName) VALUES
('Casey', 'Hudson'),
('Jason', 'Jones'),
('Todd', 'Howard'),
('Hidetaka', 'Miyazaki'),
('Marcin', 'Iwiński'),
('Neil', 'Druckmann'),
('Ted', 'Price'),
('Kenzo', 'Tsujimoto'),
('Yves', 'Guillemot'),
('Sam', 'Houser'),
('Gabe', 'Newell'),
('Tim', 'Sweeney'),
('Sam', 'Houser'),
('Mike', 'Morhaime'),
('Ilkka', 'Paananen'),
('Ding', 'Nuo'),
('Marc', 'Merrill'),
('Erika', 'Nardini'),
('Min', 'Liang Tan'),
('Kim', 'Dae Il');
-- Inserting into Platform
INSERT INTO Platform (PlatformName, ReleaseYear) VALUES
('PC', 1970),
('Xbox One', 2013),
('PlayStation 5', 2020),
('Nintendo Switch', 2017),
('PlayStation 4', 2013),
('Xbox Series X', 2020),
('Mobile', 1994),
('3DS', 2011),
('PlayStation Vita', 2011),
('Wii U', 2012),
('Google Stadia', 2019),
('Amazon Luna', 2020),
('iOS', 2007),
('Android', 2008),
('Atari VCS', 2020),
('Steam Deck', 2021),
('Oculus Quest', 2019),
('PlayStation VR', 2016),
('Xbox Series S', 2020),
('Nintendo 3DS', 2011);
-- Inserting into Customer
INSERT INTO Customer (FirstName, LastName, BirthDate, Gender, StreetAddress, City, Zipcode, PhoneNumber) VALUES
('John', 'Doe', '1992-04-01', 'Male', '123 Maple Street', 'Springfield', '12345', '555-0101'),
('Jane', 'Smith', '1988-11-24', 'Female', '456 Oak Avenue', 'Greenville', '23456', '555-0102'),
('Alice', 'Johnson', '1995-07-18', 'Female', '789 Pine Road', 'Franklin', '34567', '555-0103'),
('Bob', 'Brown', '1985-02-11', 'Male', '1012 Cedar Lane', 'Centerville', '45678', '555-0104'),
('Carol', 'Jones', '1990-12-05', 'Female', '1314 Elm St', 'Lakeview', '56789', '555-0105'),
('David', 'Wilson', '1993-03-22', 'Male', '1516 Spruce Dr', 'Hill Valley', '67890', '555-0106'),
('Eve', 'Davis', '1987-08-30', 'Female', '1718 Oak St', 'Shelbyville', '78901', '555-0107'),
('Frank', 'Miller', '1989-06-15', 'Male', '1920 Birch Blvd', 'Sandford', '89012', '555-0108'),
('Grace', 'White', '1994-09-07', 'Female', '2122 Palm Road', 'Springfield', '90123', '555-0109'),
('Henry', 'Black', '1991-10-29', 'Male', '2324 Pine Ave', 'Greenville', '01234', '555-0110'),
('Laura', 'Craft', '1983-05-14', 'Female', '45 Adventurer Rd', 'Explorer City', '23456', '555-0111'),
('Marcus', 'Fenix', '1979-04-12', 'Male', '123 Sera St', 'Jacinto', '34567', '555-0112'),
('Nathan', 'Drake', '1981-11-10', 'Male', '789 Treasure Ave', 'Libertalia', '45678', '555-0113'),
('Chloe', 'Frazer', '1984-02-21', 'Female', '321 Artifact Ln', 'Uncharted Isle', '56789', '555-0114'),
('Lara', 'Croft', '1985-02-14', 'Female', '132 Explorer Tr', 'Tomb City', '67890', '555-0115'),
('John', 'Marston', '1973-05-20', 'Male', '456 Outlaw Rd', 'Armadillo', '78901', '555-0116'),
('Ellie', 'Williams', '2001-09-26', 'Female', '789 Quarantine Zone', 'Boston', '89012', '555-0117'),
('Arthur', 'Morgan', '1863-04-22', 'Male', '1012 Western Way', 'Valentine', '90123', '555-0118'),
('Jill', 'Valentine', '1974-11-03', 'Female', '1314 Raccoon St', 'Raccoon City', '01234', '555-0119'),
('Leon', 'Kennedy', '1977-10-10', 'Male', '1516 Survivor Ln', 'Raccoon City', '12345', '555-0120');
-- Inserting into Employee
INSERT INTO Employee (FirstName, LastName) VALUES
('Alice', 'Johnson'),
('Bob', 'Smith'),
('Carol', 'Taylor'),
('Derek', 'Wilson'),
('Elena', 'Rodriguez'),
('Frank', 'Moore'),
('Gina', 'Anderson'),
('Henry', 'Jackson'),
('Ivy', 'Thomas'),
('Jack', 'Lee'),
('Ada', 'Wong'),
('Chris', 'Redfield'),
('Claire', 'Redfield'),
('Barry', 'Burton'),
('Albert', 'Wesker'),
('Rebecca', 'Chambers'),
('William', 'Birkin'),
('Annette', 'Birkin'),
('Sherry', 'Birkin'),
('Carlos', 'Oliveira');
-- Inserting into Game
INSERT INTO Game (GenreID, PublisherID, DeveloperID, GameName, Price, ReleaseYear) VALUES
(1, 1, 1, 'Mass Effect', 59.99, 2007),
(2, 2, 2, 'Halo 5', 49.99, 2015),
(3, 3, 3, 'The Witcher 3', 39.99, 2015),
(4, 4, 4, 'Splatoon 2', 59.99, 2017),
(5, 5, 5, 'Civilization VI', 49.99, 2016),
(6, 6, 6, 'Tetris 99', 0.00, 2019),
(7, 7, 7, 'Sonic Mania', 19.99, 2017),
(8, 8, 8, 'The Sims 4', 39.99, 2014),
(9, 9, 9, 'Resident Evil 7', 29.99, 2017),
(10, 10, 10, 'FIFA 21', 59.99, 2020),
(11, 11, 11, 'Half-Life 3', 60.00, 2021),
(12, 12, 12, 'Fortnite', 0.00, 2017),
(13, 13, 13, 'GTA VI', 70.00, 2023),
(14, 14, 14, 'FIFA 22', 60.00, 2021),
(15, 15, 15, 'World of Warcraft', 15.00, 2004),
(16, 16, 16, 'Mobile Legends', 0.00, 2016),
(17, 17, 17, 'League of Legends', 0.00, 2009),
(18, 18, 18, 'Clash of Clans', 0.00, 2012),
(19, 19, 19, 'Rules of Survival', 0.00, 2017),
(20, 20, 20, 'Genshin Impact', 0.00, 2020);
-- Inserting into Order
INSERT INTO [Order] (CustomerID, EmployeeID, OrderDate) VALUES
(1, 1, '2023-01-10'),
(2, 2, '2023-02-15'),
(3, 3, '2023-03-20'),
(4, 4, '2023-04-25'),
(5, 5, '2023-05-30'),
(6, 6, '2023-06-04'),
(7, 7, '2023-07-09'),
(8, 8, '2023-08-14'),
(9, 9, '2023-09-19'),
(10, 10, '2023-10-24'),
(11, 11, '2023-11-10'),
(12, 12, '2023-11-15'),
(13, 13, '2023-11-20'),
(14, 14, '2023-11-25'),
(15, 15, '2023-11-30'),
(16, 16, '2023-12-05'),
(17, 17, '2023-12-10'),
(18, 18, '2023-12-15'),
(19, 19, '2023-12-20'),
(20, 20, '2023-12-25'),
-- New Insert
(1, 1, '2023-03-10'),
(3, 3, '2023-05-20'),
(5, 5, '2023-06-30'),
(7, 7, '2023-08-09'),
(8, 8, '2023-08-14'),
(9, 9, '2023-08-19'),
(11, 11, '2023-9-10'),
(12, 12, '2023-10-15'),
(13, 13, '2023-10-20'),
(14, 14, '2023-10-25'),
(16, 16, '2023-11-05'),
(17, 17, '2023-11-10'),
(18, 18, '2023-12-18'),
(19, 19, '2023-12-22'),
(1, 1, '2023-04-10'),
(1, 3, '2023-05-20'),
(5, 5, '2023-06-30'),
(5, 7, '2023-08-09'),
(6, 8, '2023-08-14'),
(6, 9, '2023-08-19'),
(8, 11, '2023-9-10'),
(8, 12, '2023-10-15'),
(9, 13, '2023-10-20'),
(6, 14, '2023-10-25'),
(5, 16, '2023-12-24'),
(3, 17, '2023-12-24'),
(4, 18, '2023-12-24'),
(4, 19, '2023-12-24'),
(4, 1, '2023-1-24'),
(5, 4, '2023-3-29'),
(6, 3, '2023-5-21'),
(7, 18, '2023-8-17'),
(8, 3, '2023-10-28'),
(9, 7, '2023-11-25'),
(10, 6, '2023-11-26');

-- Inserting into Payment
INSERT INTO Payment (OrderID, TotalPrice, Status, Type) VALUES
(1, 59.99, 'Successful', 'Credit Card'),
(2, 49.99, 'Successful', 'PayPal'),
(3, 39.99, 'Successful', 'Debit Card'),
(4, 59.99, 'Successful', 'Credit Card'),
(5, 49.99, 'Successful', 'Cash'),
(6, 0.00, 'Pending', 'Credit Card'),
(7, 19.99, 'Denied', 'PayPal'),
(8, 39.99, 'Denied', 'Debit Card'),
(9, 29.99, 'Denied', 'Credit Card'),
(10, 59.99, 'Denied', 'Cash'),
(11, 120.00, 'Successful', 'Credit Card'),
(12, 0.00, 'Pending', 'PayPal'),
(13, 70.00, 'Successful', 'Debit Card'),
(14, 60.00, 'Denied', 'Credit Card'),
(15, 15.00, 'Successful', 'PayPal'),
(16, 0.00, 'Successful', 'Credit Card'),
(17, 0.00, 'Pending', 'Debit Card'),
(18, 0.00, 'Successful', 'PayPal'),
(19, 0.00, 'Denied', 'Credit Card'),
(20, 0.00, 'Successful', 'Cash'),
-- New Insert
(1, 59.99, 'Successful', 'Credit Card'),
(3, 39.99, 'Successful', 'Debit Card'),
(5, 49.99, 'Successful', 'Cash'),
(7, 19.99, 'Denied', 'PayPal'),
(8, 39.99, 'Denied', 'Debit Card'),
(9, 29.99, 'Denied', 'Credit Card'),
(11, 120.00, 'Successful', 'Credit Card'),
(12, 0.00, 'Pending', 'PayPal'),
(13, 70.00, 'Successful', 'Debit Card'),
(14, 60.00, 'Denied', 'Credit Card'),
(16, 0.00, 'Successful', 'Credit Card'),
(17, 0.00, 'Pending', 'Debit Card'),
(18, 0.00, 'Successful', 'PayPal'),
(19, 0.00, 'Denied', 'Credit Card'),
(20, 59.99, 'Successful', 'Credit Card'),
(21, 39.99, 'Successful', 'Debit Card'),
(22, 49.99, 'Successful', 'Cash'),
(23, 19.99, 'Denied', 'PayPal'),
(24, 39.99, 'Denied', 'Debit Card'),
(25, 29.99, 'Denied', 'Credit Card'),
(26, 120.00, 'Successful', 'Credit Card'),
(27, 0.00, 'Pending', 'PayPal'),
(28, 70.00, 'Successful', 'Debit Card'),
(29, 60.00, 'Denied', 'Credit Card'),
(30, 0.00, 'Successful', 'Credit Card'),
(31, 0.00, 'Pending', 'Debit Card'),
(32, 0.00, 'Successful', 'PayPal'),
(33, 0.00, 'Denied', 'Credit Card'),
(34, 39.99, 'Successful', 'PayPal'),
(35, 59.99, 'Successful', 'Debit Card'),
(36, 59.99, 'Successful', 'Credit Card'),
(37, 39.99, 'Successful', 'Credit Card'),
(38, 19.99, 'Successful', 'Debit Card'),
(39, 39.99, 'Successful', 'PayPal'),
(40, 39.99, 'Successful', 'Credit Card');

-- Inserting into Inventory
INSERT INTO Inventory (GameID, Quantity) VALUES
(1, 30),
(2, 25),
(3, 40),
(4, 15),
(5, 10),
(6, 35),
(7, 40),
(8, 45),
(9, 50),
(10, 55),
(11, 50),
(12, 100),
(13, 60),
(14, 80),
(15, 200),
(16, 150),
(17, 300),
(18, 250),
(19, 400),
(20, 500);

-- Inserting into GamePlatform
INSERT INTO GamePlatform (GameID, PlatformID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 3),
(12, 4),
(13, 5),
(14, 6),
(15, 7),
(16, 8),
(17, 9),
(18, 10),
(19, 1),
(20, 2);
-- Inserting into OrderDetails
INSERT INTO OrderDetails (OrderID, GameID, Quantity, TotalPrice) VALUES
(1, 1, 2, 119.98),
(2, 2, 1, 49.99),
(3, 3, 3, 119.97),
(4, 4, 2, 119.98),
(5, 5, 1, 49.99),
(6, 6, 2, 0.00),
(7, 7, 3, 59.97),
(8, 8, 2, 79.98),
(9, 9, 1, 29.99),
(10, 10, 2, 119.98),
(1, 5, 1, 49.99),
(2, 6, 2, 0.00),
(3, 7, 3, 59.97),
(4, 8, 2, 79.98),
(5, 9, 1, 29.99),
(6, 10, 2, 119.98),
(7, 1, 2, 119.98),
(8, 2, 1, 49.99),
(9, 3, 3, 119.97),
(10, 4, 2, 119.98),
-- New Insert
(1, 1, 2, 119.98),
(3, 3, 3, 119.97),
(5, 5, 1, 49.99),
(7, 7, 3, 59.97),
(8, 8, 2, 79.98),
(9, 9, 1, 29.99),
(1, 5, 1, 49.99),
(2, 6, 2, 0.00),
(3, 7, 3, 59.97),
(4, 8, 2, 79.98),
(6, 10, 2, 119.98),
(7, 1, 2, 119.98),
(8, 2, 1, 49.99),
(9, 3, 3, 119.97),
(20, 1, 2, 119.98),
(21, 3, 3, 119.97),
(22, 5, 1, 49.99),
(23, 7, 3, 59.97),
(24, 8, 2, 79.98),
(25, 9, 1, 29.99),
(26, 5, 1, 49.99),
(27, 6, 2, 0.00),
(28, 7, 3, 59.97),
(29, 8, 2, 79.98),
(30, 10, 2, 119.98),
(31, 1, 2, 119.98),
(32, 2, 1, 49.99),
(33, 3, 3, 119.97),
(34, 3 ,1 ,39.99),
(35, 1, 1, 59.99),
(36, 10, 1, 59.99),
(37, 3, 1, 39.99),
(38, 7, 1, 19.99),
(39, 8, 1, 39.99),
(39, 8, 1, 39.99);
INSERT INTO Preference (CustomerID, GenreID, PublisherID) VALUES
(1, 2, 2),
(2, 2, 2),
(3, 3, 3),
(4, 2, 2),
(5, 3, 4),
(6, 3, 4),
(7, 3, 7),
(8, 3, 4),
(9, 9, 4),
(10, 9, 10),
(11, 9, 4),
(12, 5, 10),
(13, 6, 13),
(14, 14, 10),
(15, 14, 10),
(16, 3, 4),
(17, 4, 12),
(18, 2, 4),
(19, 9, 20),
(20, 20, 20);
GO


-- PART3 Stored Procedures/Triggers
-- 3.1.Trigger to automatically update the total price in orderdetails
CREATE TRIGGER trg_UpdateOrderdetailsTotalPrice
ON OrderDetails
AFTER INSERT, UPDATE
AS
BEGIN
   DECLARE @TotalPrice DECIMAL(10, 2), @GameID INT;

   SELECT @TotalPrice = i.Quantity * g.Price,
   		  @GameID = i.GameID
   FROM Inserted i
   JOIN Game g
   		ON i.GameID = i.GameID
   
   UPDATE OrderDetails
   SET TotalPrice = @TotalPrice
   WHERE GameID = @GameID;
END;
GO
-- DROP TRIGGER trg_UpdateOrderdetailsTotalPrice;

-- 3.2.Trigger to automatically update the inventory quantity when an OrderDetails record is changed.

CREATE TRIGGER trg_UpdateInventoryQuantity
ON OrderDetails
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
   DECLARE @GameID INT, @Adjustment INT
   SELECT @GameID = COALESCE(i.GameID, d.GameID),
   	      @Adjustment = ISNULL(i.Quantity, 0) - ISNULL(d.Quantity, 0)
   FROM Inserted i
   FULL JOIN Deleted d ON i.GameID = d.GameID
  
   UPDATE Inventory
   SET Quantity = Quantity - @Adjustment
   WHERE GameID = @GameID;
END;
GO
-- DROP TRIGGER trg_UpdateInventoryQuantity;



-- PART4 Views
-- 4.1.Create view to analyze remain quantity of games
CREATE VIEW RemainingGameQuantity AS
SELECT
   G.GameID,
   G.GameName,
   I.Quantity AS TotalInventory,
   ISNULL(SUM(OD.Quantity), 0) AS TotalOrdered,
   I.Quantity - ISNULL(SUM(OD.Quantity), 0) AS RemainingQuantity
FROM
   Game G
JOIN
   Inventory I ON G.GameID = I.GameID
LEFT JOIN
   OrderDetails OD ON G.GameID = OD.GameID
GROUP BY
   G.GameID,
   G.GameName,
   I.Quantity;
GO
-- use RemainingGameQuantity view
SELECT * FROM RemainingGameQuantity
ORDER BY RemainingQuantity;
GO
-- DROP VIEW RemainingGameQuantity;


-- 4.2.analyze 3 most popular sold games (every yearquarter)
-- Drop the existing PopularGamesQuarterly view if it exists
CREATE VIEW TopThreePopularGamesYearQuarterly AS
SELECT *
FROM (
  SELECT
    G.GameID,
    G.GameName,
    GN.GenreName AS Genre,
    P.PublisherName AS Publisher,
    D.FirstName + ' ' + D.LastName AS Developer,
    CAST(YEAR(O.OrderDate) AS VARCHAR) + '-' + CAST(DATEPART(qq, O.OrderDate) AS VARCHAR) AS YearQuarter,
    SUM(OD.Quantity) AS TotalOrderAmount,
    DENSE_RANK() OVER (PARTITION BY CAST(YEAR(O.OrderDate) AS VARCHAR) + '-' + CAST(DATEPART(qq, O.OrderDate) AS VARCHAR) 
     ORDER BY SUM(OD.Quantity) DESC) AS Ranking
  FROM
    Game G
    JOIN Genre GN ON G.GenreID = GN.GenreID
    JOIN Publisher P ON G.PublisherID = P.PublisherID
    JOIN Developer D ON G.DeveloperID = D.DeveloperID
    JOIN OrderDetails OD ON G.GameID = OD.GameID
    JOIN [Order] O ON OD.OrderID = O.OrderID
  GROUP BY
    G.GameID,
    G.GameName,
    GN.GenreName,
    P.PublisherName,
    D.FirstName,
    D.LastName,
    O.OrderDate
) AS SubRankedGames
WHERE
  Ranking <= 3;
GO

-- Use TopThreePopularGamesYearQuarterly view
SELECT YearQuarter,
  	   STRING_AGG(CAST(GameID AS VARCHAR) + '-' + GameName, ', ') AS TopThreeGames
FROM TopThreePopularGamesYearQuarterly
GROUP BY YearQuarter
ORDER BY YearQuarter;
GO

-- use TopThreePopularGamesYearQuarterly view
SELECT * FROM TopThreePopularGamesYearQuarterly
GO
-- DROP VIEW TopThreePopularGamesYearQuarterly;


-- 4.3.Create view to analyze customer preference
CREATE VIEW CustomerPreferenceSummary AS
SELECT c.CustomerID,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    GenreName,
    PublisherName
    
FROM Preference pre   
   JOIN Genre g ON pre.GenreID = g.GenreID
   JOIN Publisher pub ON pre.PublisherID = pub.PublisherID
   JOIN Customer c  ON c.CustomerID = pre.CustomerID  

-- use view to get the most popular Genre
SELECT GenreName,
    COUNT(GenreName) AS GenreCount,
    DENSE_RANK() OVER
    (ORDER BY COUNT(GenreName) DESC) AS RankingGenreCount
FROM CustomerPreferenceSummary
GROUP BY GenreName
ORDER BY GenreCount DESC

-- use view to get the most popular Publisher
SELECT PublisherName,
       COUNT(PublisherName) AS PublisherCount,
       DENSE_RANK() OVER
    (ORDER BY COUNT(PublisherName) DESC) AS RankingPublisherCount
FROM CustomerPreferenceSummary
GROUP BY PublisherName
ORDER BY PublisherCount DESC;
--clean up
-- DROP VIEW CustomerPreferenceSummary




-- PART5 Table-level CHECK Constraints based on a function/Computed Columns based on a function/Column Data Encryption
-- 5.1.Table-level CHECK Constraints: Create a function to ensure that an order cannot be processed when the quantity ordered for a game exceeds its available inventory.
CREATE FUNCTION CheckInventory (@GameID INT)
RETURNS smallint
AS
BEGIN
   DECLARE @InventoryQuantity smallint, @SoldQuantity smallint, @GameRemain smallint;

   SELECT @InventoryQuantity = Quantity
   FROM Inventory
   WHERE GameID = @GameID;

   SELECT @SoldQuantity = Quantity
   FROM OrderDetails
   WHERE GameID = @GameID;

   IF @InventoryQuantity IS NULL OR @SoldQuantity IS NULL
   	RETURN -1;
  
   SET @GameRemain = @InventoryQuantity - @SoldQuantity;
   RETURN @GameRemain
END;
GO
-- Add table-level CHECK constraint 
ALTER TABLE OrderDetails ADD CONSTRAINT BanInventoryUnavailable CHECK (dbo.CheckInventory(GameID) >= 0);
GO
-- Clean up
-- ALTER TABLE OrderDetails DROP CONSTRAINT BanInventoryUnavailable;
-- DROP FUNCTION CheckInventory


-- 5.2.Computed Columns based on a function: Create a function to calculate the age of a customer
CREATE FUNCTION fn_CalculateAge(@CustID INT)
RETURNS INT
AS
BEGIN
DECLARE @Age INT, @DateOfBirth DATE=
	(SELECT BirthDate
	FROM Customer
	WHERE CustomerID = @CustID);
	SET @Age = DATEDIFF(hour, @DateOfBirth, GETDATE()) / 8766;
	RETURN @Age;
END
GO
-- Add a function-based computed column to the Customer
ALTER TABLE Customer
ADD Age AS (dbo.fn_CalculateAge(CustomerID));
-- See what the computed column looks like
SELECT CustomerID,
	   FirstName,
	   LastName,
	   Age
FROM Customer
WHERE Age < 30
ORDER BY Age DESC;
GO
-- Clean up
ALTER TABLE Customer DROP COLUMN Age;
DROP FUNCTION fn_CalculateAge;
GO

-- 5.3.Column Data Encryption: Encrypt PhoneNumber
-- Check if the EncryptedPhoneNumber column already exists
IF NOT EXISTS (
SELECT 1
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Customer'
AND COLUMN_NAME = 'EncryptedPhoneNumber'
)
BEGIN

-- Add a new column for encrypted phone number
ALTER TABLE Customer
ADD EncryptedPhoneNumber VARBINARY(256) NULL;
END
GO

-- Create master key
CREATE MASTER KEY
ENCRYPTION BY PASSWORD = 'Group8';
GO

-- Create certificate
CREATE CERTIFICATE CustomerPhoneCert
WITH SUBJECT = 'Customer Phone Number Encryption',
EXPIRY_DATE = '2026-10-31';
GO

-- Create symmetric key
CREATE SYMMETRIC KEY CustomerPhoneKey
WITH ALGORITHM = AES_128
ENCRYPTION BY CERTIFICATE CustomerPhoneCert;
GO

-- Open symmetric key
OPEN SYMMETRIC KEY CustomerPhoneKey
DECRYPTION BY CERTIFICATE CustomerPhoneCert;

-- Encrypt PhoneNumber column and update EncryptedPhoneNumber
UPDATE Customer
SET EncryptedPhoneNumber = EncryptByKey(Key_GUID('CustomerPhoneKey'), CONVERT(VARBINARY, PhoneNumber));

-- Close symmetric key
CLOSE SYMMETRIC KEY CustomerPhoneKey;

-- Display encrypted and original phone numbers
SELECT
PhoneNumber,
EncryptedPhoneNumber
FROM
Customer;
GO

-- Open symmetric key to decrypte
OPEN SYMMETRIC KEY CustomerPhoneKey
DECRYPTION BY CERTIFICATE CustomerPhoneCert;

-- Decrypt EncryptedPhoneNumber column
UPDATE Customer
SET PhoneNumber = CONVERT(VARCHAR, DecryptByKey(EncryptedPhoneNumber));

-- Close symmetric key
CLOSE SYMMETRIC KEY CustomerPhoneKey;
GO

-- Drop symmetric key
DROP SYMMETRIC KEY CustomerPhoneKey;
GO

-- Drop certificate
DROP CERTIFICATE CustomerPhoneCert;
GO

-- Drop master key
DROP MASTER KEY;
GO