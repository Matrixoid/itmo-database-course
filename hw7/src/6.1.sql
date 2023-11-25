--PostgreSQL 16.0

CREATE FUNCTION check_extra_marks() RETURNS TRIGGER AS
$$
DECLARE
    is_correct BOOLEAN;
    bad        RECORD;
BEGIN
    is_correct = TRUE;
    FOR bad IN SELECT StudentId, CourseId
               FROM Marks
               WHERE (StudentId, CourseId) NOT IN (SELECT StudentId, CourseId
                                                   FROM Plan
                                                           NATURAL JOIN Students)
        LOOP
            is_correct = FALSE;
            RAISE NOTICE 'Студент (id = %) имеет лишние оценки по курсу (id = %)', bad.StudentId, bad.CourseId;
        END LOOP;
    IF NOT is_correct
    THEN
        RAISE EXCEPTION 'Ошибка! Попытка выставить оценки студенту по курсам не входящим в его учебный план';
    END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER NoExtraMarksOnMarks
    AFTER INSERT OR UPDATE OF StudentId, CourseId
    ON Marks
    FOR EACH STATEMENT
	EXECUTE PROCEDURE check_extra_marks();

CREATE TRIGGER NoExtraMarksOnPlane
	AFTER DELETE OR UPDATE OF GroupId, CourseId
	ON Plan
	FOR EACH STATEMENT
	EXECUTE PROCEDURE check_extra_marks();
	
CREATE TRIGGER NoExtraMarksOnStudents
    AFTER UPDATE OF GroupId
    ON Students
    FOR EACH STATEMENT
	EXECUTE PROCEDURE check_extra_marks();