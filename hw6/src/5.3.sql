SELECT DISTINCT StudentId
FROM Students
WHERE NOT EXISTS(SELECT CourseId
                 FROM Plan
                 WHERE LecturerId IN (SELECT LecturerId
                                      FROM Lecturers
                                      WHERE LecturerName = :LecturerName)
                   AND CourseId NOT IN (SELECT CourseId
                                        FROM Marks
                                        WHERE Marks.StudentId = Students.StudentId));