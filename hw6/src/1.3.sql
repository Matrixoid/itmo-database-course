SELECT StudentId, StudentName, GroupId
FROM Students
WHERE StudentId IN
		(SELECT StudentId
		 FROM Marks
		 WHERE CourseID = :CourseId AND Mark = :Mark)