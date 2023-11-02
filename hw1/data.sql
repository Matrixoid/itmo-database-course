CREATE TABLE Groups(
  group_id int,
  group_no char(6)
);

CREATE TABLE Students(
  student_id int,
  name varchar(30),
  group_id int
);

INSERT INTO Groups(group_id, group_no)
VALUES
  (1, 'M34371'),
  (2, 'M34391');

INSERT INTO Students(student_id, name, group_id)
VALUES
  (1, 'Maksim Alzhanov', 2),
  (2, 'Artem Koton', 1),
  (3, 'Anna Suris', 1);

UPDATE Students
SET group_id = 2
WHERE student_id = 2;

INSERT INTO Groups(group_id, group_no)
VALUES
  (1, 'M34381');

DELETE FROM Groups
WHERE group_no = 'M34381';

ALTER TABLE Groups
  ADD CONSTRAINT group_id_unique
  UNIQUE(group_id);

ALTER TABLE Students
  ADD FOREIGN KEY (group_id)
  REFERENCES Groups (group_id);