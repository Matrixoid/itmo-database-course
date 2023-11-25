SELECT StudentName, CourseName
FROM (SELECT DISTINCT StudentId, CourseName
      FROM Students
			NATURAL JOIN Plan
            NATURAL JOIN Courses) SC
				NATURAL JOIN Students;