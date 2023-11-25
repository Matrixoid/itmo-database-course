SELECT StudentName, CourseName
FROM (SELECT StudentId, CourseName
      FROM Students
            NATURAL JOIN Plan
            NATURAL JOIN Courses
      EXCEPT 
      SELECT StudentId, CourseName
      FROM Plan
            NATURAL JOIN Courses
            NATURAL JOIN Marks
      WHERE Mark = 4 OR Mark = 5) SCEXC
                                    NATURAL JOIN Students;