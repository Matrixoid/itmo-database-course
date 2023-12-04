CREATE FUNCTION BuyFree(
    IN _FlightId INTEGER,
    IN _SeatNo VARCHAR(4)
) RETURNS BOOLEAN AS
$$
BEGIN
	IF EXISTS(SELECT FlightId, SeatNo
              FROM FreeSeats
              WHERE FlightId = _FlightId
                AND SeatNo = _SeatNo)
    THEN
		
		INSERT INTO Sales(FlightId, SeatNo, Status, ReservationTimeEnd)
        VALUES
		  (_FlightId, _SeatNo, 'bought', NOW() + INTERVAL '3 days')
		ON CONFLICT (FlightId, SeatNo)
		DO UPDATE SET UserId = NULL,
					  Status = 'bought',
					  ReservationTimeEnd = NOW() + INTERVAL '3 days';
		
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;