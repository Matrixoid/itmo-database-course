CREATE TABLE Groups (
	group_id INT PRIMARY KEY,
	group_name VARCHAR(6) NOT NULL,
	UNIQUE (group_name)
);
CREATE TABLE Students (
	student_id INT PRIMARY KEY,
	student_name VARCHAR(50) NOT NULL,
	group_id INT NOT NULL,
	UNIQUE (student_id, group_id),
	FOREIGN KEY (group_id) REFERENCES Groups (group_id)
);
CREATE TABLE Lecturers (
	lecturer_id INT PRIMARY KEY,
	lecturer_name VARCHAR(50) NOT NULL
);
CREATE TABLE Courses (
	course_id INT PRIMARY KEY,
	course_name varchar(50) NOT NULL
);
CREATE TABLE Plans (
	course_id INT NOT NULL,
	group_id INT NOT NULL,
	lecturer_id INT NOT NULL,
	PRIMARY KEY (course_id, group_id),
	FOREIGN KEY (group_id) REFERENCES  Groups (group_id),
	FOREIGN KEY (course_id) REFERENCES  Courses (course_id),
	FOREIGN KEY (lecturer_id) REFERENCES  Lecturers (lecturer_id)
);
CREATE TABLE Marks (
	student_id INT NOT NULL,
	group_id INT NOT NULL,
	course_id INT NOT NULL,
	points INT NOT NULL CHECK (points >= 0 AND points <= 100),
	PRIMARY KEY (student_id, group_id, course_id),
	FOREIGN KEY (group_id, course_id) REFERENCES  Plans (group_id, course_id),
	FOREIGN KEY (student_id, group_id) REFERENCES Students (student_id, group_id)
);