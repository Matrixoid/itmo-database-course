SELECT StudentId, StudentName, GroupId 
FROM Students 
EXCEPT 
SELECT StudentId, StudentName, GroupId 
FROM Students
        NATURAL JOIN Courses
        NATURAL JOIN Marks
WHERE CourseName = :CourseName;