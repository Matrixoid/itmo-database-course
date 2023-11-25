MERGE INTO Marks USING NewMarks
    ON Marks.StudentId = NewMarks.StudentId AND Marks.CourseId = NewMarks.CourseId
    WHEN MATCHED THEN UPDATE SET mark = CASE
                                            WHEN Marks.Mark > NewMarks.Mark THEN Marks.Mark
                                            ELSE NewMarks.Mark
                                        END
    WHEN NOT MATCHED THEN INSERT (StudentId, CourseId, Mark) VALUES (NewMarks.StudentId, NewMarks.CourseId, NewMarks.Mark);