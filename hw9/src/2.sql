CREATE FUNCTION Reserve(
	IN _UserId INTEGER,
	IN _Pass VARCHAR(64),
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
	
	IF _SeatNo NOT IN (SELECT SeatNo
					   FROM FreeSeats
					   WHERE FlightId = _FlightId)
	THEN RETURN FALSE;
	END IF;
	
	INSERT INTO Sales(FlightId, SeatNo, UserId, ReservationTimeEnd, Status)
	VALUES
	  (_FlightId, _SeatNo, _UserId, NOW() + INTERVAL '3 days', 'reserved')
	ON CONFLICT (FlightId, SeatNo)
	DO UPDATE SET UserId = _UserId,
				  ReservationTimeEnd = NOW() + INTERVAL '3 days',
				  Status = 'reserved';
	
	RETURN TRUE;
END;
$$ LANGUAGE plpgsql;