-- при бронировании
START TRANSACTION READ WRITE ISOLATION LEVEL READ COMMITTED;
SELECT Reserve(:UserId, :Pass, :FlightId, :SeatNo);
COMMIT;

--при продлении бронирования
START TRANSACTION READ WRITE ISOLATION LEVEL REPEATABLE READ;
SELECT ExtendReservation(:UserId, :Pass, :FlightId, :SeatNo);
COMMIT;

-- при покупке свободного места
START TRANSACTION READ WRITE ISOLATION LEVEL READ COMMITTED;
SELECT BuyFree(:FlightId, :SeatNo);
COMMIT;

-- при покупке забронированного места
START TRANSACTION READ WRITE ISOLATION LEVEL REPEATABLE READ;
SELECT BuyReserved(:UserId, :Pass, :FlightId, :SeatNo);
COMMIT;