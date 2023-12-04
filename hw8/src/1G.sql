-- ДЗ-5.2.1. Полная информация о студентах по :StudentId
-- ДЗ-5.2.2. Полная информация о студентах по :StudentName
-- ДЗ-5.7.2. GroupName и CourseName, такие что все студенты
-- группы сдали предмет
-- Primary key таблицы Groups.
CREATE UNIQUE INDEX groups_group_id ON Groups USING HASH (GroupId);

-- ДЗ-6.1.2. Информация о студентах по :GroupName
-- ДЗ-7.1.2. Удаление студентов по :GroupName
-- ДЗ-7.2.5. Перевод всех студентов в существующую группу
-- Для поиска группы по имени не ходя в память делаем
-- покрывающий индекс
CREATE UNIQUE INDEX groups_group_name_group_id ON Groups USING BTREE (GroupName, GroupId);