SELECT StudentName, CourseName
FROM (SELECT DISTINCT StudentId, StudentName, CourseId
      FROM Students,
           Plan
      WHERE Students.GroupId = Plan.GroupId
        AND EXISTS
          (SELECT StudentId, CourseId
           FROM Marks
           WHERE Marks.StudentId = Students.StudentId
             AND Marks.CourseId = Plan.CourseId
             AND mark <= 2)) Debtors,
     Courses
WHERE Debtors.CourseId = Courses.CourseId;