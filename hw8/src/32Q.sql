-- Найти максимальную и минимальную оценку по курсу
SELECT MAX(Mark), MIN(Mark)
FROM Marks
WHERE CourseId IN (SELECT CourseId
		                      FROM Courses
		                      WHERE CourseName = :CourseName);