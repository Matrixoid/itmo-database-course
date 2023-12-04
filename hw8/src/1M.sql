-- Этот индекс ничего не ускорит из запросов из дз 5-7, но 
-- в то же время, не иметь индекса по primary key - сомнительная идея,
-- так что пусть будет. В противном случае мы не сможем находить
-- лекторов по id быстро.
CREATE UNIQUE INDEX marks_student_id_course_id ON Marks USING HASH (StudentId, CourseId);

-- ДЗ-5.3.1. Информация о студентах с :Mark по предмету :CourseId
-- ДЗ-5.3.2. Информацию о студентах с :Mark по предмету :CourseName
-- ДЗ-5.3.3. Информацию о студентах с :Mark по предмету :LecturerId
-- покрывающий индекс для поиска по студенту и курсу,
-- по студенту курсу и оценке
CREATE UNIQUE INDEX marks_mark_student_id_course_id ON Marks USING BTREE (Mark, StudentId, CourseId);

-- ДЗ-6.2.2. Полная информация о студентах, не имеющих оценки по :CourseId
-- ДЗ-6.2.3. Полная информация о студентах, не имеющих оценки по :CourseName
-- ДЗ-6.2.4. Полная информация о студентах, не имеющих оценки по :CourseId, у которых есть этот предмет
-- индекс для поиска записей по курсу.
CREATE INDEX marks_course_id ON Marks USING HASH (CourseId);