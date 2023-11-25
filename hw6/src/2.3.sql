SELECT StudentId, StudentName, GroupName
FROM Students, Groups
WHERE Students.GroupId = Groups.GroupId AND StudentId NOT IN (SELECT StudentId
                                                              FROM Marks, Courses
                                                              WHERE Marks.CourseId = Courses.CourseId AND CourseName = :CourseName);