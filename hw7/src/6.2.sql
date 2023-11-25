--PostgreSQL 16.0

CREATE FUNCTION check_same_marks() RETURNS TRIGGER AS
$$
DECLARE
    is_correct BOOLEAN;
    bad        RECORD;
BEGIN
	is_correct = TRUE;
    FOR bad IN (
		SELECT S1.StudentId AS Student1Id,
			   S1.StudentName AS Student1Name,
			   S2.StudentId AS Student2Id,
			   S2.StudentName AS Student2Name,
			   S1.GroupId
		FROM Students S1
				INNER JOIN Students S2
				ON S1.GroupId = S2.GroupId
		WHERE EXISTS (SELECT M1.Mark
					  FROM Marks M1
					  WHERE M1.StudentId = S1.StudentId
					    AND NOT EXISTS (SELECT M2.Mark
									    FROM Marks M2
									    WHERE M2.StudentId = S2.StudentId
									      AND M1.CourseId = M2.CourseId))
	)
		LOOP
			is_correct = FALSE;
			RAISE NOTICE 'Студенты (id = %) и (id = %) учащиеся в группе (id = %) имеют оценки по разным наборам дисциплин', bad.Student1Id, bad.Student2Id, bad.GroupId;
		END LOOP;
	
	IF NOT is_correct
	THEN
		RAISE EXCEPTION 'Два или более студентов одной группы имеют оценки по разным наборам дисциплин';
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER SameMarksOnMarks
	AFTER INSERT OR DELETE OR UPDATE OF StudentId, CourseId
	ON Marks
	EXECUTE PROCEDURE check_same_marks();

CREATE TRIGGER SameMarksOnStudent
    AFTER INSERT OR DELETE OR UPDATE OF StudentId, GroupId
    ON Students
	EXECUTE PROCEDURE same_marks();