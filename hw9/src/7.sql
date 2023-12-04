CREATE FUNCTION FlightStat(
    IN _UserId INTEGER,
    IN _Pass VARCHAR(50),
	IN _FlightId INTEGER
)
    RETURNS TABLE (CanBuy       BOOLEAN,
                   CanReserve   BOOLEAN,
                   FreeSeats    INTEGER,
                   ReserveSeats INTEGER,
                   BuySeats     INTEGER) AS
$$
BEGIN
    IF UserIsValid(_UserId, _Pass)
    THEN
        RETURN QUERY (SELECT stat.CanBuy,
                   		 	 stat.CanReserve,
                   			 CAST(stat.FreeSeats AS INTEGER),
                   			 CAST(stat.ReserveSeats AS INTEGER),
                   			 CAST(stat.BuySeats AS INTEGER)
            		  FROM Statistics AS stat
            		  WHERE UserId = _UserId
					    AND FlightId = _FlightId);
    ELSE
        RETURN;
    END IF;
END;
$$ LANGUAGE plpgsql;