SELECT DISTINCT StudentId
FROM Students
WHERE StudentId IN (SELECT StudentId
					FROM Marks
					WHERE CourseId IN (SELECT CourseId
									   FROM Plan
									   WHERE Plan.GroupId = Students.GroupId
									     AND LecturerId IN (SELECT LecturerId
															FROM Lecturers
															WHERE LecturerName = :LecturerName)));