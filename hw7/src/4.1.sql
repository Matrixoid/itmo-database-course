INSERT INTO Marks (StudentId, CourseId, Mark)
SELECT NewMarks.StudentId, NewMarks.CourseId, NewMarks.Mark
FROM NewMarks
        LEFT OUTER JOIN Marks AS OldMarks
          ON NewMarks.StudentId = OldMarks.StudentId AND NewMarks.CourseId = OldMarks.CourseId
WHERE OldMarks.Mark IS NULL;