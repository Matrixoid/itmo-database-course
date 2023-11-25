UPDATE Marks
SET mark = COALESCE((SELECT CASE
                                WHEN NewMarks.Mark > Marks.Mark THEN NewMarks.Mark
                                ELSE Marks.Mark
                                END
                     FROM NewMarks
                     WHERE NewMarks.StudentId = Marks.StudentId AND NewMarks.CourseId = Marks.CourseId), Marks.Mark)
WHERE TRUE;