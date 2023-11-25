SELECT GroupName, SUM(Mark) AS SumMark
FROM Groups
         LEFT JOIN Students ON Students.GroupId = Groups.GroupId
         LEFT JOIN Marks ON Marks.StudentId = Students.StudentId
GROUP BY Groups.GroupId, Groups.GroupName;