SELECT CourseId, GroupId
FROM Marks
        CROSS JOIN Students
EXCEPT
SELECT CourseId, GroupId
FROM (SELECT Students.StudentId, CourseId, GroupId
      FROM Marks
            CROSS JOIN Students
      EXCEPT
      SELECT Students.StudentId, CourseId, GroupId
      FROM Marks
            NATURAL JOIN Students) X;