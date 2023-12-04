-- индекс для внешнего ключа таблицы students по groupid
CREATE INDEX students_groups_group_id ON Students USING HASH (GroupId);

-- для соединения и поиска оценки по курсу и студентам группы
CREATE UNIQUE INDEX marks_course_id_student_id_mark ON Marks USING BTREE (CourseId, StudentId, Mark);
