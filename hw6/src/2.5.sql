SELECT DISTINCT StudentId, StudentName, GroupName
FROM Students, Groups
WHERE Students.GroupId = Groups.GroupId
  AND Students.GroupId IN
      (SELECT GroupId
       FROM Plan
       WHERE CourseId IN
         (SELECT CourseId
          FROM Courses
          WHERE CourseName = :CourseName))
  AND Students.StudentId NOT IN
      (SELECT StudentId
       FROM Marks
       WHERE CourseId IN
         (SELECT CourseId
          FROM Courses
          WHERE CourseName = :CourseName));