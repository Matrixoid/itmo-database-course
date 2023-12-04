CREATE FUNCTION ExtendReservation(
	IN _UserId INTEGER,
	IN _Pass VARCHAR(50),
	IN _FlightId INTEGER,
	IN _SeatNo VARCHAR(4)
) RETURNS BOOLEAN AS
$$
BEGIN
	IF NOT EXISTS (SELECT FlightId
				   FROM Flights
				   WHERE FlightId = _FlightId)
	THEN RETURN FALSE;
	END IF;
	
	IF NOT UserIsValid(_UserId, _Pass)
	THEN RETURN FALSE;
	END IF;
	
	IF EXISTS (SELECT FlightId
			   FROM Sales NATURAL JOIN Flights
			   WHERE FlightId = _FlightId
			     AND SeatNo = _SeatNo
			     AND UserId = _UserId
			     AND Status = 'reserved'
			  	 AND ReservationTimeEnd >= NOW()
			  	 AND NOW() <= FlightTime)
	THEN
		UPDATE Sales
		SET ReservationTimeEnd = NOW() + INTERVAL '3 days'
		WHERE FlightId = _FlightId AND SeatNo = _SeatNo AND UserId = _UserId;
		RETURN TRUE;
	END IF;
	
	RETURN FALSE;
END;
$$ LANGUAGE plpgsql;