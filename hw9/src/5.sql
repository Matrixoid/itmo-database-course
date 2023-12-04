CREATE OR REPLACE FUNCTION BuyReserved(
    IN _UserId INTEGER,
    IN _Pass VARCHAR(64),
    IN _FlightId INTEGER,
    IN _SeatNo VARCHAR(4)
) RETURNS BOOLEAN AS
$$
BEGIN
	IF UserIsValid(_UserId, _Pass)
	   AND
	   EXISTS (SELECT FlightId, SeatNo, UserId
			   FROM ReservedSeats 
			   WHERE FlightId = _FlightId
				 AND UserId = _UserId
			     AND SeatNo = _SeatNo)
    THEN
        UPDATE Sales
        SET ReservationTimeEnd = NOW(),
            Status = 'bought'
        WHERE FlightId = _FlightId
          AND SeatNo = _SeatNo
          AND UserId = _UserId
          AND Status = 'reserved'
          AND ReservationTimeEnd >= NOW()
          AND EXISTS(SELECT FlightId, FlightTime, PlaneId
                	 FROM Flights
                	 WHERE FlightId = _FlightId
                  	 AND FlightTime >= NOW());
        RETURN count(*) > 0;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;