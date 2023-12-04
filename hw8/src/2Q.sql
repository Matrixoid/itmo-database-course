SELECT AVG(CAST(Mark AS FLOAT)) AvgMark
FROM Students
         NATURAL JOIN Groups
         NATURAL JOIN Marks
WHERE GroupId = :GroupId
  AND CourseId = :CourseId;