CREATE TABLE Groups (
	group_id INT PRIMARY KEY,
	group_name CHAR(6) NOT NULL,
	UNIQUE(group_name)
);

CREATE TABLE Students(
	student_id INT PRIMARY KEY,
	student_name VARCHAR(50) NOT NULL,
	group_id INT NOT NULL,
	FOREIGN KEY (group_id) REFERENCES Groups(group_id)
);

CREATE TABLE Lecturers(
	lecturer_id INT PRIMARY KEY,
	lecturer_name VARCHAR(50) NOT NULL
);

CREATE TABLE Courses(
	course_id INT PRIMARY KEY,
	course_name VARCHAR(50) NOT NULL
);

CREATE TABLE Plan(
	group_id INT NOT NULL,
	course_id INT NOT NULL,
	lecturer_id INT NOT NULL,
	PRIMARY KEY(group_id, course_id),
	FOREIGN KEY (lecturer_id) REFERENCES Lecturers(lecturer_id)
);

CREATE TABLE Marks(
	student_id INT NOT NULL,
	course_id INT NOT NULL,
	mark CHAR(1) NOT NULL CHECK(mark = 'A' OR mark = 'B' OR mark = 'C' OR mark = 'D' OR mark = 'E' OR mark = 'F'),
	PRIMARY KEY(student_id, course_id),
	FOREIGN KEY (student_id) REFERENCES Students(student_id),
	FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);