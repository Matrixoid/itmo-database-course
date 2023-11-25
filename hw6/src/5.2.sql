SELECT DISTINCT StudentId
FROM Students
WHERE StudentId NOT IN (SELECT StudentId
                        FROM Marks
                        WHERE Marks.CourseId IN (SELECT CourseId
                                                 FROM Plan
                                                 WHERE Plan.GroupId = Students.GroupId
                                                   AND LecturerId IN (SELECT LecturerId
                                                                      FROM Lecturers
                                                                      WHERE LecturerName = :LecturerName)));