CREATE FUNCTION FreeSeats(IN _FlightId INTEGER)
RETURNS TABLE (SeatNo VARCHAR(4)) AS
$$
BEGIN
    RETURN QUERY (SELECT f.SeatNo
        		  FROM FreeSeats AS f
        		  WHERE FlightId = _FlightId);
END;
$$ LANGUAGE plpgsql;