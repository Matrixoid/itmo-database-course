-- Этот индекс ничего не ускорит из запросов из дз 5-7, но 
-- в то же время, не иметь индекса по primary key - сомнительная идея,
-- так что пусть будет. В противном случае мы не сможем находить
-- курсы по id быстро.
CREATE UNIQUE INDEX courses_course_id ON Courses USING HASH (CourseId);

-- ДЗ-5.3.2. Информацию о студентах с :Mark по предмету :CourseName
-- ДЗ-5.4.1. Информацию о студентах не имеющих оценки по :CourseName среди всех
-- ДЗ-5.4.2. Информацию о студентах не имеющих оценки по :CourseName среди тех, у кого он есть
-- Индекс для поиска CourseId по имени курса, покрывающий индекс
-- позволит брать данные без обращения к таблице
CREATE UNIQUE INDEX courses_course_name_course_id ON Courses USING BTREE(CourseName, CourseId);