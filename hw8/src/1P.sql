-- ДЗ-6.2.4. Полная информация о студентах, не имеющих оценки по :CourseId, у которых есть этот предмет
-- покрывающий индекс - для использования Plan как таблицы связи
CREATE UNIQUE INDEX plan_course_id_group_id ON Plan USING BTREE (CourseId, GroupId);

-- ДЗ-5.4.2. Информацию о студентах не имеющих оценки по :CourseName среди тех, у кого он есть
-- ДЗ-5.5.1. ФИО студента и названия предметов которые у него есть по плану
-- ДЗ-6.3.1. StudentId, CourseId, такие, что у студента был предмет
-- покрывающий индекс - для использования Plan как таблицы связи
CREATE UNIQUE INDEX plan_group_id_course_id ON Plan USING BTREE (GroupId, CourseId);

-- ДЗ-5.3.3. Информацию о студентах с :Mark по предмету :LecturerId
-- ДЗ-5.3.5. Информацию о студентах с :Mark по предмету :LecturerId
-- ДЗ-5.6.4. StudentId имеющих оценки по всем предметам :LecturerName, которые он у него вёл
-- покрывающий индекс - для использования Plan как таблицы связи
CREATE INDEX plan_lecturer_id_course_id ON Plan USING BTREE (LecturerId, CourseId);