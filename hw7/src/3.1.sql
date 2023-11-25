UPDATE Students
SET marks = (SELECT COUNT(Marks.Mark)
             FROM Marks
             WHERE Students.StudentId = Marks.StudentId)
WHERE Students.StudentId = :StudentId;