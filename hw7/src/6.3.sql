--PostgreSQL 16.0

CREATE FUNCTION preserve_marks() RETURNS TRIGGER AS
$$
BEGIN
    UPDATE Marks
    SET Mark = OLD.Mark
    WHERE Marks.CourseId = OLD.CourseId AND Marks.StudentId = OLD.StudentId;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE FUNCTION delete_marks() RETURNS TRIGGER AS
$$
BEGIN
    RAISE EXCEPTION 'Нельзя удалить оценку у студента, это будет считаться её уменьшением';
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER PreserverMarksOnUpdate
    AFTER UPDATE OF Mark
    ON Marks
    FOR EACH ROW
    WHEN (OLD.mark > NEW.mark)
	EXECUTE PROCEDURE preserve_marks();

CREATE TRIGGER PreserverMarksOnDelete
	AFTER DELETE
	ON Marks
	EXECUTE PROCEDURE delete_marks();