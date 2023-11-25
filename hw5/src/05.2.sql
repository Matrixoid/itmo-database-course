SELECT StudentName, CourseName
FROM (SELECT StudentId, CourseName
      FROM Students
            NATURAL JOIN Plan
            NATURAL JOIN Courses
      EXCEPT
      SELECT StudentId, CourseName
      FROM Plan
            NATURAL JOIN Courses
            NATURAL JOIN Marks) SCEXC
                NATURAL JOIN Students;