CREATE FUNCTION FlightsStatistics(
    IN _UserId INTEGER,
    IN _Pass VARCHAR(50)
)
    RETURNS TABLE (FlightId     INTEGER,
                   CanBuy       BOOLEAN,
                   CanReserve   BOOLEAN,
                   FreeSeats    INTEGER,
                   ReserveSeats INTEGER,
                   BuySeats     INTEGER) AS
$$
BEGIN
    IF UserIsValid(_UserId, _Pass)
    THEN
        RETURN QUERY (SELECT stat.FlightId,
                			 stat.CanBuy,
                   		 	 stat.CanReserve,
                   			 CAST(stat.FreeSeats AS INTEGER),
                   			 CAST(stat.ReserveSeats AS INTEGER),
                   			 CAST(stat.BuySeats AS INTEGER)
            		  FROM Statistics AS stat
            		  WHERE UserId = _UserId);
    ELSE
        RETURN;
    END IF;
END;
$$ LANGUAGE plpgsql;