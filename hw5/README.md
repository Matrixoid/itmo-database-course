# Домашнее задание 5. Реляционная алгебра

Структура базы данных «Университет»:

- *Students(StudentId, StudentName, GroupId)*
- *Groups(GroupId, GroupName)*
- *Courses(CourseId, CourseName)*
- *Lecturers(LecturerId, LecturerName)*
- *Plan(GroupId, CourseId, LecturerId)*
- *Marks(StudentId, CourseId, Mark)*

Составьте выражения реляционной алгебры и соответствующие SQL-запросы, позволяющие получать

<ol>
<li> Информацию о студентах
	1. С заданным идентификатором (*StudentId*, *StudentName*, *GroupId* по *:StudentId*).
	2. С заданным ФИО (*StudentId*, *StudentName*, *GroupId* по *:StudentName*).
</li>
<li> Полную информацию о студентах
	1. С заданным идентификатором (*StudentId*, *StudentName*, *GroupName* по *:StudentId*).
	2. С заданным ФИО (*StudentId*, *StudentName*, *GroupName* по *:StudentName*).
</li>
<li> Информацию о студентах с заданной оценкой по дисциплине
	1. С заданным идентификатором (*StudentId*, *StudentName*, *GroupId* по *:Mark*, *:CourseId*).
	2. С заданным названием (*StudentId*, *StudentName*, *GroupId* по *:Mark*, *:CourseName*).
	3. Которую у них вёл лектор заданный идентификатором (*StudentId*, *StudentName*, *GroupId* по *:Mark*, *:LecturerId*).
	4. Которую у них вёл лектор, заданный ФИО (*StudentId*, *StudentName*, *GroupId* по *:Mark*, *:LecturerName*).
	5. Которую вёл лектор, заданный идентификатором (*StudentId*, *StudentName*, *GroupId* по *:Mark*, *:LecturerId*).
	6. Которую вёл лектор, заданный ФИО (*StudentId*, *StudentName*, *GroupId* по *:Mark*, *:LecturerName*).
</li>
<li> Информацию о студентах не имеющих оценки по дисциплине
	1. Среди всех студентов (*StudentId*, *StudentName*, *GroupId* по *:CourseName*).
	2. Среди студентов, у которых есть эта дисциплина (*StudentId*, *StudentName*, *GroupId* по *:CourseName*).
</li>
<li> Для каждого студента ФИО и названия дисциплин
	1. Которые у него есть по плану (*StudentName*, *CourseName*).
	2. Есть, но у него нет оценки (*StudentName*, *CourseName*).
	3. Есть, но у него не 4 или 5 (*StudentName*, *CourseName*).
</li>
<li> Идентификаторы студентов по преподавателю
	1. Имеющих хотя бы одну оценку у преподавателя (*StudentId* по *:LecturerName*).
	2. Не имеющих ни одной оценки у преподавателя (*StudentId* по *:LecturerName*).
	3. Имеющих оценки по всем дисциплинам преподавателя (*StudentId* по *:LecturerName*).
	4. Имеющих оценки по всем дисциплинам преподавателя, которые он вёл у этого студента (*StudentId* по *:LecturerName*).
</li>
<li> Группы и дисциплины, такие что все студенты группы имеют оценку по этой дисциплине
	1. Идентификаторы (*GroupId*, *CourseId*).
	2. Названия (*GroupName*, *CourseName*).
</li>
</ol>
Cоставьте SQL-запросы, позволяющие получать
<ol start="8">
<li>Суммарный балл
1. Одного студента (*SumMark* по *:StudentId*).
2. Каждого студента (*StudentName*, *SumMark*).
3. Каждой группы (*GroupName*, *SumMark*).
</li>
<li>Средний балл
1. Одного студента (*AvgMark* по *:StudentId*).
2. Каждого студента (*StudentName*, *AvgMark*).
3. Каждой группы (*GroupName*, *AvgMark*).
4. Средний балл средних баллов студентов каждой группы (*GroupName*, *AvgAvgMark*).
</li>
<li>Для каждого студента: число дисциплин, которые у него были, число сданных дисциплин и число несданных дисциплин (*StudentId*, *Total*, *Passed*, *Failed*).</li>
</ol>