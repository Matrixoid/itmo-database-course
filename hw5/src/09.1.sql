SELECT AVG(CAST(Mark AS REAL)) AS AvgMark
FROM Marks
WHERE StudentId = :StudentId;