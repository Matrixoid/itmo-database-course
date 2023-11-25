SELECT GroupName, CourseName
FROM Groups, Courses
WHERE NOT EXISTS(SELECT Students.StudentId
                 FROM Students
                 WHERE Students.GroupId = Groups.GroupId AND StudentId NOT IN (SELECT StudentId
                                                                               FROM Marks
                                                                               WHERE Marks.CourseId = Courses.CourseId));