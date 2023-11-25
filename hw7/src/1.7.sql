DELETE FROM Students
WHERE StudentId IN (SELECT Students.StudentId
                    FROM Students
                            NATURAL JOIN Plan
                            LEFT OUTER JOIN Marks
                              ON Plan.CourseId = Marks.CourseId AND Students.StudentId = Marks.StudentId
                    WHERE Marks.Mark IS NULL
                    GROUP BY Students.StudentId
                    HAVING COUNT(DISTINCT Plan.CourseId) >= 2);