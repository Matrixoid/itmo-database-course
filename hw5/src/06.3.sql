SELECT StudentId
FROM Marks
EXCEPT
SELECT StudentId
FROM (SELECT StudentId, CourseId
      FROM (SELECT StudentId
            FROM Marks) SM
                          CROSS JOIN
                        (SELECT CourseId
                         FROM Plan
                                NATURAL JOIN Lecturers
                         WHERE LecturerName = :LecturerName) CPL
      EXCEPT
      SELECT StudentId, CourseId
      FROM Marks) SCM;