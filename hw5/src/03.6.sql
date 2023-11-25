SELECT S.StudentId, StudentName, S.GroupId 
FROM Plan 
        NATURAL JOIN Marks 
		NATURAL JOIN Lecturers
        INNER JOIN Students S
			ON Marks.StudentId = S.StudentId
WHERE Mark = :Mark AND LecturerName = :LecturerName;