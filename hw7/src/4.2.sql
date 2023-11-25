UPDATE Marks
SET mark = coalesce((SELECT NewMarks.Mark
                     FROM NewMarks
                     WHERE NewMarks.StudentId = Marks.StudentId AND NewMarks.CourseId = Marks.CourseId), Marks.Mark)
WHERE TRUE;