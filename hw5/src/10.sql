SELECT Students.StudentId,
       COUNT(DISTINCT Plan.CourseId)                                  AS Total,
       COUNT(DISTINCT Marks.CourseId)                                 AS Passed,
       COUNT(DISTINCT Plan.CourseId) - COUNT(DISTINCT Marks.CourseId) AS Failed
FROM Students
         LEFT JOIN Plan ON Plan.GroupId = Students.GroupId
         LEFT JOIN Marks ON Marks.StudentId = Students.StudentId AND Marks.CourseId = Plan.CourseId
GROUP BY Students.StudentId;