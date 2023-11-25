# Домашнее задание 5. Реляционная алгебра

Структура базы данных «Университет»:

- <em>Students(StudentId, StudentName, GroupId)</em>
- <em>Groups(GroupId, GroupName)</em>
- <em>Courses(CourseId, CourseName)</em>
- <em>Lecturers(LecturerId, LecturerName)</em>
- <em>Plan(GroupId, CourseId, LecturerId)</em>
- <em>Marks(StudentId, CourseId, Mark)</em>

Составьте выражения реляционной алгебры и соответствующие SQL-запросы, позволяющие получать

<ol>
<li> Информацию о студентах<br/>
	1. С заданным идентификатором (<em>StudentId</em>, <em>StudentName</em>, <em>GroupId</em> по <em>:StudentId</em>).<br/>
	2. С заданным ФИО (<em>StudentId</em>, <em>StudentName</em>, <em>GroupId</em> по <em>:StudentName</em>).
</li>
<li> Полную информацию о студентах<br/>
	1. С заданным идентификатором (<em>StudentId</em>, <em>StudentName</em>, <em>GroupName</em> по <em>:StudentId</em>).<br/>
	2. С заданным ФИО (<em>StudentId</em>, <em>StudentName</em>, <em>GroupName</em> по <em>:StudentName</em>).
</li>
<li> Информацию о студентах с заданной оценкой по дисциплине<br/>
	1. С заданным идентификатором (<em>StudentId</em>, <em>StudentName</em>, <em>GroupId</em> по <em>:Mark</em>, <em>:CourseId</em>).<br/>
	2. С заданным названием (<em>StudentId</em>, <em>StudentName</em>, <em>GroupId</em> по <em>:Mark</em>, <em>:CourseName</em>).<br/>
	3. Которую у них вёл лектор заданный идентификатором (<em>StudentId</em>, <em>StudentName</em>, <em>GroupId</em> по <em>:Mark</em>, <em>:LecturerId</em>).<br/>
	4. Которую у них вёл лектор, заданный ФИО (<em>StudentId</em>, <em>StudentName</em>, <em>GroupId</em> по <em>:Mark</em>, <em>:LecturerName</em>).<br/>
	5. Которую вёл лектор, заданный идентификатором (<em>StudentId</em>, <em>StudentName</em>, <em>GroupId</em> по <em>:Mark</em>, <em>:LecturerId</em>).<br/>
	6. Которую вёл лектор, заданный ФИО (<em>StudentId</em>, <em>StudentName</em>, <em>GroupId</em> по <em>:Mark</em>, <em>:LecturerName</em>).
</li>
<li> Информацию о студентах не имеющих оценки по дисциплине<br/>
	1. Среди всех студентов (<em>StudentId</em>, <em>StudentName</em>, <em>GroupId</em> по <em>:CourseName</em>).<br/>
	2. Среди студентов, у которых есть эта дисциплина (<em>StudentId</em>, <em>StudentName</em>, <em>GroupId</em> по <em>:CourseName</em>).
</li>
<li> Для каждого студента ФИО и названия дисциплин<br/>
	1. Которые у него есть по плану (<em>StudentName</em>, <em>CourseName</em>).<br/>
	2. Есть, но у него нет оценки (<em>StudentName</em>, <em>CourseName</em>).<br/>
	3. Есть, но у него не 4 или 5 (<em>StudentName</em>, <em>CourseName</em>).
</li>
<li> Идентификаторы студентов по преподавателю<br/>
	1. Имеющих хотя бы одну оценку у преподавателя (<em>StudentId</em> по <em>:LecturerName</em>).<br/>
	2. Не имеющих ни одной оценки у преподавателя (<em>StudentId</em> по <em>:LecturerName</em>).<br/>
	3. Имеющих оценки по всем дисциплинам преподавателя (<em>StudentId</em> по <em>:LecturerName</em>).<br/>
	4. Имеющих оценки по всем дисциплинам преподавателя, которые он вёл у этого студента (<em>StudentId</em> по <em>:LecturerName</em>).
</li>
<li> Группы и дисциплины, такие что все студенты группы имеют оценку по этой дисциплине<br/>
	1. Идентификаторы (<em>GroupId</em>, <em>CourseId</em>).<br/>
	2. Названия (<em>GroupName</em>, <em>CourseName</em>).
</li>
</ol>
Cоставьте SQL-запросы, позволяющие получать
<ol start="8">
<li>Суммарный балл<br/>
1. Одного студента (<em>SumMark</em> по <em>:StudentId</em>).<br/>
2. Каждого студента (<em>StudentName</em>, <em>SumMark</em>).<br/>
3. Каждой группы (<em>GroupName</em>, <em>SumMark</em>).
</li>
<li>Средний балл<br/>
1. Одного студента (<em>AvgMark</em> по <em>:StudentId</em>).<br/>
2. Каждого студента (<em>StudentName</em>, <em>AvgMark</em>).<br/>
3. Каждой группы (<em>GroupName</em>, <em>AvgMark</em>).<br/>
4. Средний балл средних баллов студентов каждой группы (<em>GroupName</em>, <em>AvgAvgMark</em>).
</li>
<li>Для каждого студента: число дисциплин, которые у него были, число сданных дисциплин и число несданных дисциплин (<em>StudentId</em>, <em>Total</em>, <em>Passed</em>, <em>Failed</em>).</li>
</ol>