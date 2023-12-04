-- Используем дерево, чтобы поддерживать запросы на префиксе
CREATE INDEX students_group_id_student_name_student_id ON Students USING BTREE (GroupId, StudentName, StudentId);

-- Удаляем индекс, потому что теперь можно использовать префикс
-- индекса idx_students_group_id_student_name_student_id
DROP INDEX students_groups_group_id;