UPDATE Students
SET marks = (SELECT COUNT(DISTINCT Marks.CourseId)
             FROM Marks
             WHERE Students.StudentId = Marks.StudentId)
WHERE TRUE;