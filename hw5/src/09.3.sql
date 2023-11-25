SELECT GroupName, AVG(CAST(Mark AS REAL)) AS AvgMark
FROM Groups
         LEFT JOIN Students ON Students.GroupId = Groups.GroupId
         LEFT JOIN Marks ON Marks.StudentId = Students.StudentId
GROUP BY Groups.GroupId, Groups.GroupName;