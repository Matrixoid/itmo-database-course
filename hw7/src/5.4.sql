CREATE VIEW StudentDebts AS
SELECT Students.StudentId AS StudentId, COALESCE(Stats.CourseCount, 0) AS Debts
FROM Students
         LEFT OUTER JOIN (SELECT Students.StudentId AS StudentId, COUNT(DISTINCT Plan.CourseId) AS CourseCount
                          FROM Students
									NATURAL JOIN Plan
									LEFT OUTER JOIN Marks
									  ON Plan.CourseId = Marks.CourseId AND Students.StudentId = Marks.StudentId
                          WHERE Marks.Mark IS NULL
                          GROUP BY Students.StudentId) Stats ON Students.StudentId = Stats.StudentId;