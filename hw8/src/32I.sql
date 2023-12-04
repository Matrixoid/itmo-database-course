-- Важна упорядоченность, поэтому дерево
CREATE INDEX marks_course_id_mark ON Marks USING BTREE (CourseId, Mark);