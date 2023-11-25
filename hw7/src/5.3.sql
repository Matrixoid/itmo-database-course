CREATE VIEW Debts AS
SELECT Students.StudentId AS StudentId, COUNT(DISTINCT Plan.CourseId) AS Debts
FROM Students
        INNER JOIN Plan
		   ON Plan.GroupId = Students.GroupId
        LEFT OUTER JOIN Marks
		  ON Plan.CourseId = Marks.CourseId AND Students.StudentId = Marks.StudentId
WHERE Marks.Mark IS NULL
GROUP BY Students.StudentId;