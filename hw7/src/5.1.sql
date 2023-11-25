CREATE VIEW StudentMarks AS
SELECT Students.StudentId AS StudentId, COUNT(Mark) AS Marks
FROM Students
        LEFT OUTER JOIN Marks
		  ON Students.StudentId = Marks.StudentId
GROUP BY Students.StudentId;