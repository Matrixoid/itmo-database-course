CREATE PROCEDURE CompressSeats(IN _FlightId INTEGER) AS
$$
DECLARE
	CurrentSeatNo VARCHAR(4);
	CursorSeats CURSOR FOR
		SELECT SeatNo
		FROM Seats NATURAL JOIN Flights
		WHERE FlightId = _FlightId;
	CursorBought CURSOR FOR
		SELECT SeatNo
		FROM BoughtSeats
				NATURAL JOIN Flights
				NATURAL JOIN Seats
		WHERE FlightId = _FlightId
		FOR UPDATE;
	CursorReserved CURSOR FOR
		SELECT SeatNo
		FROM ReservedSeats
				NATURAL JOIN Flights
				NATURAL JOIN Seats
		WHERE FlightId = _FlightId
		FOR UPDATE;
BEGIN
        -- Удаляем просроченные брони
	DELETE FROM Sales
	WHERE FlightId = _FlightId
	  AND SeatNo IN (SELECT SeatNo
					 FROM FreeSeats
					 WHERE FlightId = _FlightId);

	OPEN CursorSeats;
	FOR _ IN CursorBought
		LOOP
			FETCH CursorSeats INTO CurrentSeatNo;
			UPDATE Sales SET SeatNo = CurrentSeatNo WHERE CURRENT OF CursorBought;
		END LOOP;
	
	FOR _ IN CursorReserved
		LOOP
			FETCH CursorSeats INTO CurrentSeatNo;
			UPDATE Sales SET SeatNo = CurrentSeatNo WHERE CURRENT OF CursorReserved;
		END LOOP;
	CLOSE CursorSeats;
END;
$$ LANGUAGE plpgsql;