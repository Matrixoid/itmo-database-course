# Домашнее задание 6. Реляционное исчисление

Составьте запросы в терминах языков Datalog и SQL для базы данных «Университет», позволяющие получать

<ol>
<li> Информацию о студентах<br/>
	1. С заданным ФИО (<em>StudentId</em>, <em>StudentName</em>, <em>GroupId</em> по <em>:StudentName</em>).<br/>
	2. Учащихся в заданной группе (<em>StudentId</em>, <em>StudentName</em>, <em>GroupId</em> по <em>:GroupName</em>).<br/>
	3. C заданной оценкой по дисциплине, заданной идентификатором (<em>StudentId</em>, <em>StudentName</em>, <em>GroupId</em> по <em>:Mark</em>, <em>:CourseId</em>).<br/>
	4. C заданной оценкой по дисциплине, заданной названием (<em>StudentId</em>, <em>StudentName</em>, <em>GroupId</em> по <em>:Mark</em>, <em>:CourseName</em>).
</li>
<li> Полную информацию о студентах<br/>
	1. Для всех студентов (<em>StudentId</em>, <em>StudentName</em>, <em>GroupName</em>).<br/>
	2. Студентов, не имеющих оценки по дисциплине, заданной идентификатором (<em>StudentId</em>, <em>StudentName</em>, <em>GroupName</em> по <em>:CourseId</em>).<br/>
	3. Студентов, не имеющих оценки по дисциплине, заданной названием (<em>StudentId</em>, <em>StudentName</em>, <em>GroupName</em> по <em>:CourseName</em>).<br/>
	4. Студентов, не имеющих оценки по дисциплине, у которых есть эта дисциплина (<em>StudentId</em>, <em>StudentName</em>, <em>GroupName</em> по <em>:CourseId</em>).<br/>
	5. Студентов, не имеющих оценки по дисциплине, у которых есть эта дисциплина (<em>StudentId</em>, <em>StudentName</em>, <em>GroupName</em> по <em>:CourseName</em>).
</li>
<li> Студенты и дисциплины, такие что у студента была дисциплина (по плану или есть оценка)<br/>
    1. Идентификаторы (<em>StudentId</em>, <em>CourseId</em>).<br/>
    2. Имя и название (<em>StudentName</em>, <em>CourseName</em>).
</li>
<li> Студенты и дисциплины, такие что дисциплина есть в его плане, и у студента долг по этой дисциплине<br/>
    1. Долгом считается отсутствие оценки (<em>StudentName</em>, <em>CourseName</em>).<br/>
    2. Долгом считается оценка не выше 2 (<em>StudentName</em>, <em>CourseName</em>).<br/>
    3. Долгом считается отсутствие оценки или оценка не выше 2 (<em>StudentName</em>, <em>CourseName</em>).
</li>
<li> Идентификаторы студентов по преподавателю<br/>
    1. Имеющих хотя бы одну оценку у преподавателя (<em>StudentId</em> по <em>:LecturerName</em>).<br/>
    2. Не имеющих ни одной оценки у преподавателя (<em>StudentId</em> по <em>:LecturerName</em>).<br/>
    3. Имеющих оценки по всем дисциплинам преподавателя (<em>StudentId</em> по <em>:LecturerName</em>).<br/>
    4. Имеющих оценки по всем дисциплинам преподавателя, которые он вёл у этого студента (<em>StudentId</em> по <em>:LecturerName</em>).
</li>
<li> Группы и дисциплины, такие что все студенты группы имеют оценку по предмету<br/>
    1. Идентификаторы (<em>GroupId</em>, <em>CourseId</em>).<br/>
    2. Названия (<em>GroupName</em>, <em>CourseName</em>).
</li>
</ol>

<b>Примечания</b>

1. В Datalog итоговым считается последнее объявленное отношение.
2. Текущая реализация Datalog не поддерживает рекурсивные определения.
3. В SQL-запросах нельзя использовать * join.

В рамках проекта:

1. Определите запросы (в том числе, агрегирующие), необходимые для работы проекта.
2. Реализуйте запросы на языке SQL.