SELECT StudentId
FROM (SELECT StudentId, GroupId
      FROM Marks
            CROSS JOIN (SELECT GroupId
                        FROM Plan
                                NATURAL JOIN Lecturers
                        WHERE LecturerName = :LecturerName) X
      EXCEPT
      SELECT StudentId, GroupId
      FROM (SELECT X.CourseId, StudentId, GroupId
            FROM Marks
                    CROSS JOIN (SELECT CourseId, GroupId
                                FROM Plan
                                        NATURAL JOIN Lecturers
                                WHERE LecturerName = :LecturerName) X
            EXCEPT
            SELECT X.CourseId, StudentId, GroupId
            FROM Marks
                    NATURAL JOIN (SELECT CourseId, GroupId
                                  FROM Plan
                                        NATURAL JOIN Lecturers
                                  WHERE LecturerName = :LecturerName) X) X) X
        NATURAL JOIN Students;