INSERT INTO Groups(group_id, group_name)
VALUES
  (1, 'M34361'),
  (2, 'M34371'),
  (3, 'M34381'),
  (4, 'M34391');
  
INSERT INTO Students(student_id, student_name, group_id)
VALUES
  (1, 'Бац Константин', 1),
  (2, 'Алексеев Иван', 4),
  (3, 'Белодедова Алина', 3),
  (4, 'Бородин Ярослав', 2),
  (5, 'Чмыхалов Артемий', 2),
  (6, 'Солодовников Андрей', 1);
  
INSERT INTO Lecturers(lecturer_id, lecturer_name)
VALUES
  (1, 'Корнеев Георгий Александрович'),
  (2, 'Станкевич Андрей Сергеевич'),
  (3, 'Штукенберг Дмитрий Григорьевич');
    
INSERT INTO Courses (course_id, course_name)
VALUES
  (1, 'Дискретная математика'),
  (2, 'Введение в программирование'),
  (3, 'Парадигмы программирования'),
  (4, 'Java Advanced'),
  (5, 'Базы данных'),
  (6, 'Теория типов'),
  (7, 'Математическая логика');
  
INSERT INTO Plan(course_id, group_id, lecturer_id)
VALUES
  (5, 1, 1),
  (6, 4, 3),
  (4, 1, 2),
  (7, 2, 3),
  (3, 1, 1);

INSERT INTO Marks(student_id, course_id, mark)
VALUES
  (1, 5, 'A'),
  (2, 6, 'B'),
  (1, 4, 'D'),
  (4, 7, 'A'),
  (6, 3, 'C');