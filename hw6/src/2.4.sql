SELECT DISTINCT StudentId, StudentName, GroupName
FROM Students, Groups
WHERE Students.GroupId = Groups.GroupId
  AND Students.GroupId IN
      (SELECT GroupId
       FROM Plan
       WHERE CourseId = :CourseId)
  AND Students.StudentId NOT IN
      (SELECT StudentId
       FROM Marks
       WHERE CourseId = :CourseId);