SELECT StudentName, CourseName
FROM (SELECT StudentId, CourseId
      FROM Students,
           Plan
      WHERE Students.GroupId = Plan.GroupId
      UNION
      SELECT StudentId, CourseId
      FROM Marks) StudentsCourse,
     Students,
     Courses
WHERE StudentsCourse.StudentId = Students.StudentId
  AND StudentsCourse.CourseId = Courses.CourseId;