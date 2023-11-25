UPDATE Students
SET Debts = (
    SELECT COUNT(DISTINCT CourseId)
    FROM Plan
    WHERE Plan.GroupId = Students.GroupId
      AND Plan.CourseId NOT IN (SELECT CourseId
								FROM Marks
								WHERE Marks.StudentId = Students.StudentId
    )
),
	Marks = (SELECT COUNT(Mark)
             FROM Marks
             WHERE Students.StudentId = Marks.StudentId)
WHERE TRUE;