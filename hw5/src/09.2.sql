SELECT StudentName, AVG(CAST(Mark AS REAL)) AS AvgMark
FROM Students
	LEFT JOIN Marks
	ON Students.StudentId = Marks.StudentId
GROUP BY Students.StudentId, Students.StudentName;