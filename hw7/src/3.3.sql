UPDATE Students
SET marks = marks + (SELECT COUNT(NewMarks.Mark)
                     FROM NewMarks
                     WHERE Students.StudentId = NewMarks.StudentId)
WHERE TRUE;