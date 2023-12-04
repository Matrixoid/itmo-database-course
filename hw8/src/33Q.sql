-- Найти курсы, которые вел у заданной группы заданный лектор
SELECT CourseName
FROM Courses
WHERE CourseId IN (SELECT CourseId
		                      FROM Plan
		                      WHERE LecturerId IN (SELECT LecturerId
				                                              FROM Lecturers
				                                              WHERE LecturerName = :LecturerName)
			         AND GroupId IN (SELECT GroupId
				                                FROM Groups
				                                WHERE GroupName = :GroupName));