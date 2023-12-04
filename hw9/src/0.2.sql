-- Самолёты которые есть.
CREATE TABLE Planes
(
    PlaneId INTEGER NOT NULL PRIMARY KEY
);

-- Список рейсов
CREATE TABLE Flights
(
    FlightId 	INTEGER 	NOT NULL PRIMARY KEY,
    FlightTime 	TIMESTAMP 	NOT NULL,
    PlaneId 	INTEGER 	NOT NULL,
    FOREIGN KEY (PlaneId) REFERENCES Planes (PlaneId)
);

--Таблица мест в самолёте
CREATE TABLE Seats
(
    PlaneId       INTEGER    not null,
    SeatNo        VARCHAR(4) not null,
    PRIMARY KEY (PlaneId, SeatNo),
    FOREIGN KEY (PlaneId) REFERENCES Planes (PlaneId)
);

-- Таблица зарегистрированных в системе пользователей
CREATE TABLE Users
(
    UserId 	INTEGER NOT NULL PRIMARY KEY,
    Pass 	TEXT 	NOT NULL
);

-- Перечисление из зарезервировано/куплено
CREATE TYPE sale_state AS ENUM ('reserved', 'bought');

-- Проданные места и забронированные места на рейсы
CREATE TABLE Sales
(
    FlightId     		INTEGER    	NOT NULL,
    SeatNo       		VARCHAR(4) 	NOT NULL,
    UserId       		INTEGER,
    ReservationTimeEnd 	TIMESTAMP	NOT NULL,
    Status       	sale_state 		NOT NULL,
    PRIMARY KEY (FlightId, SeatNo),
    FOREIGN KEY (UserId) 	REFERENCES Users (UserId),
    FOREIGN KEY (FlightId) 	REFERENCES Flights (FlightId)
);

-- Представление для получения зарезервированных мест
CREATE VIEW ReservedSeats AS
SELECT FlightId, SeatNo, UserId
FROM Sales NATURAL JOIN Flights
WHERE Status = 'reserved'
  AND ReservationTimeEnd >= NOW()
  AND FlightTime >= NOW();

-- Представление для получения купленных мест
CREATE VIEW BoughtSeats AS
SELECT FlightId, SeatNo, UserId
FROM Sales NATURAL JOIN Flights
WHERE Status = 'bought';

-- Представление для получения свободных мест
CREATE VIEW FreeSeats AS
SELECT FlightId, SeatNo
FROM Seats NATURAL JOIN Flights
WHERE FlightTime >= NOW()
EXCEPT
SELECT FlightId, SeatNo
FROM BoughtSeats
EXCEPT
SELECT FlightId, SeatNo
FROM ReservedSeats;

-- Представление для подсчёта статистики(задания 6 и 7)
CREATE VIEW Statistics AS
SELECT u.UserId,
       f.FlightId,
       COUNT(free.SeatNo) + COUNT(r.UserId = u.UserId) > 0 AS CanBuy,
       COUNT(free.SeatNo) > 0                              AS CanReserve,
       COUNT(free.SeatNo)                                  AS FreeSeats,
       COUNT(r.SeatNo)                                     AS ReserveSeats,
       COUNT(b.SeatNo)                                     AS BuySeats
FROM Flights f
         CROSS JOIN Users u
         NATURAL LEFT JOIN Seats s
         NATURAL LEFT JOIN freeSeats free
         NATURAL LEFT JOIN boughtSeats b
         LEFT JOIN reservedSeats r ON f.FlightId = r.FlightId AND s.SeatNo = r.SeatNo
GROUP BY u.UserId, f.FlightId;