# Домашнее задание 4. Нормализация БД «Университет»
Дано отношение с атрибутами *StudentId*, *StudentName*, *GroupId*, *GroupName*, *CourseId*, *CourseName*, *LecturerId*, *LecturerName*, *Mark*. И функциональными зависимостями:

- StudentId → StudentName, GroupId, GroupName;
- GroupId → GroupName;
- GroupName → GroupId;
- CourseId → CourseName;
- LecturerId → LecturerName;
- StudentId, CourseId → Mark;
- GroupId, CourseId → LecturerId, LecturerName.

1. Инкрементально приведите данное отношение в пятую нормальную форму.
1. Постройте соответствующую модель сущность-связь.
1. Постройте соответствующую физическую модель.
1. Реализуйте SQL-скрипты, создающие схему базы данных.
1. Создайте базу данных по спроектированной модели.
1. Заполните базу тестовыми данными.

В рамках проекта:

1. Приведите схему базы в пятую нормальную форму.
1. Если итоговая схема не будет в НФ-5, то обоснуйте принятое решение.
1. Запишите определения таблиц на языке SQL.
1. Запишите на языке SQL наполнение таблиц тестовым данными.

# Введение в СУБД. ДЗ-4

##### 1. Первая нормальная форма

##### 1.1. Описание

	Для удобства построим НМФЗ:
	StudentId -> StudentName
	StudentId -> GroupId
	GroupId -> GroupName
	GroupName -> GroupId
	CourseId -> CourseName
	LecturerId -> LecturerName
	StudentId, CourseId -> Mark
	CourseId, GroupId -> LecturerId
	
	И сразу выделим ключ (StudentId, CourseId)
	
	Отношение будет находиться в первой нормальной форме, если в нём не будет повторяющихся групп атрибутов,
	все атрибуты будут атомарны, а также отношение должно иметь ключ.
	Атрибуты уже являются неповторяющимися и атомарными, а также у данного отношения есть ключ
	Из всего этого мы делаем вывод, что наше отношение уже находится в первой нормальной форме

##### 1.2. Результат

<sub>Для исходного отношения укажите на какие отношения вы его разбили в формате\
   Исходное отношение => полученное отношение ; полученное отношение ; ... .\
по одному на строке. Где все отношения заданы в формате\
   (атрибут1, атрибут2, ...)\
Например:\
   (SellerId, GoodId, PriceId, OrderId) => (SellerId, GoodId, PriceId); \
\
(GoodId, PriceId).\
Обратите внимание на точку в конце описания.\
\
Строки, начинающиеся с двух минусов ( -- ) будут считаться комментариями.\
Разносить разбиение отношения на несколько строк нельзя.\
Если отношение не изменилось, укажите его разбиение на одно отношение (его самого).<sub>

	(StudentId, StudentName, GroupId, GroupName, CourseId, CourseName, LecturerId, LecturerName, Mark) =>
	(StudentId, StudentName, GroupId, GroupName, CourseId, CourseName, LecturerId, LecturerName, Mark).
	
##### 2. Вторая нормальная форма

##### 2.1. Описание

	Для того, чтобы отношение находилось во второй нормальной форме, нужно, чтобы оно находилось в 1НФ и
	неключевые атрибуты зависели от всего ключа. 
	
	Рассмотрим какие неключевые атрибуты зависят от части ключа или от ключа целиком:
	StudentName и GroupId зависят от StudentId и также GroupName зависит от StudentId, так как он зависит от GroupId
	CourseName зависит только от CourseId
	Mark зависит только от StudentId и CourseId
	LecturerId зависит от CourseId и GroupId, а также LecturerName зависит от CourseId и GroupId, так как LecturerName
	зависит от LecturerId
	
	В итоге у нас получился 4 отношения, ключами в которых будут (StudentId), (CourseId), (StudentId, CourseId)
	и (CourseId, GroupId)

##### 2.2. Результат

<sub>Для каждого отношения из предыдущей нормальной формы укажите на какие отношения вы его разбили в формате, указанном в пункте 1.2.<sub>

	(StudentId, StudentName, GroupId, GroupName, CourseId, CourseName, LecturerId, LecturerName, Mark) =>
	(StudentId, StudentName, GroupId, GroupName);
	(CourseId, CourseName);
	(StudentId, CourseId, Mark);
	(GroupId, CourseId, LecturerId, LecturerName).

##### 3. Третья нормальная форма

##### 3.1. Описание

	Отношение находится в третьей нормальной форме, если оно находится в 2НФ и все неключевые атрибуты непосредственно зависят от ключа
	
	Рассмотрим все цепочки ФЗ
	1) StudentId -> StudentName
	2) StudentId -> GroupId -> GroupName
	3) CourseId -> CourseName
	4) StudentId, CourseId -> Mark
	5) CourseId, GroupId -> LecturerId -> LecturerName
	
	Цепочка 2 и цепочка 5 имеют неключевые атрибуты, которые не зависят напрямую от ключа (StudentId, CourseId). Декомпозируем отношение
	(StudentId, StudentName, GroupId, GroupName) по ФЗ GroupId -> GroupName и отношение (GroupId, CourseId, LecturerId, LecturerName)
	по ФЗ LecturerId -> LecturerName. Отношения (CourseId, CourseName) и (StudentId, CourseId, Mark) останутся без изменений

##### 3.2. Результат

<sub>Для каждого отношения из предыдущей нормальной формы укажите на какие отношения вы его разбили в формате, указанном в пункте 1.2.<sub>

	(StudentId, StudentName, GroupId, GroupName) => (StudentId, StudentName, GroupId); (GroupId, GroupName).
	(CourseId, CourseName) => (CourseId, CourseName).
	(StudentId, CourseId, Mark) => (StudentId, CourseId, Mark).
	GroupId, CourseId, LecturerId, LecturerName) => (GroupId, CourseId, LecturerId); (LecturerId, LecturerName).

##### Б. Нормальная форма Бойса-Кодда

##### Б.1. Описание

	Отношение находится в нормальной форме Бойса-Кодда, когда для всех ФЗ этого отношения левые части ФЗ являются надключами.
	
	Рассмотрим отношение (StudentId, StudentName, GroupId), для него определены следующие ФЗ
	{StudentId -> StudentName, StudentId -> GroupId}. Для обеих этих ФЗ левая часть правил является надключом для данного отношения,
	поэтому отношение (StudentId, StudentName, GroupId) уже находится в НФБК. 
	
	Рассмотрим отношение (GroupId, GroupName), для него определены следующие ФЗ {GroupId -> GroupName, GroupName -> GroupId}.
	В этом отношении два ключа (GroupId) и (GroupName), поэтому для обеих этих ФЗ левая часть правил является надключом для
	данного отношения, следовательно отношение (GroupId, GroupName) уже находится в НФБК. 
	
	Рассмотрим отношение (CourseId, CourseName). Заметим, что это отношение находится в 3НФ и в нём нет перекрывающихся ключей,
	значит это отношение уже находится в НФБК.
	
	Рассмотрим отношение (StudentId, CourseId, Mark). Заметим, что это отношение находится в 3НФ и в нём нет перекрывающихся ключей,
	значит это отношение уже находится в НФБК.
	
	Рассмотрим отношение (GroupId, CourseId, LecturerId), для него определена ФЗ {CourseId, GroupId -> LecturerId}. Для этой
	ФЗ левая часть является надключом данного отношения, поэтому отношение(GroupId, CourseId, LecturerId) уже находится в НФБК. 

##### Б.2. Результат

<sub>Для каждого отношения из предыдущей нормальной формы укажите на какие отношения вы его разбили в формате, указанном в пункте 1.2.<sub>

	(StudentId, StudentName, GroupId) => (StudentId, StudentName, GroupId).
	(GroupId, GroupName) => (GroupId, GroupName).
	(CourseId, CourseName) => (CourseId, CourseName).
	(CourseId, StudentId, Mark) => (CourseId, StudentId, Mark).
	(CourseId, GroupId, LecturerId) => (CourseId, GroupId, LecturerId).
	(LecturerId, LecturerName) => (LecturerId, LecturerName).

##### 4. Четвёртая нормальная форма

##### 4.1. Описание

<sub>Для отношений из трёх и менее атрибутов должны быть приведены контрпримеры.<sub>

	Рассмотрим отношение (StudentId, StudentName, GroupId). По теореме Дейта-Фейгина 2, так как это отношение находится в НФБК
	и у него есть простой ключ (StudentId), то это отношение уже находится в 4НФ.
	
	Рассмотрим отношение (GroupId, GroupName). По теореме Дейта-Фейгина 2, так как это отношение находится в НФБК и у него есть
	простой ключ (GroupId), то это отношение уже находится в 4НФ.
	
	Рассмотрим отношение (CourseId, CourseName). По теореме Дейта-Фейгина 2, так как это отношение находится в НФБК и у него
	есть простой ключ (CourseId), то это отношение уже находится в 4НФ.
	
	Рассмотрим отношение (CourseId, StudentId, Mark). В этом отношении существует только одна многозначная зависимость, так как
	оценка зависит и от курса, и от студента. Допустима ситуация, когда некоторый студент не имеет никакой оценки по курсу,
	а значит, все многозначные зависимости для этого отношения уже описаны функциональными, и отношение находится в 4НФ.
	
	Аналогичная ситуация и для (CourseId, GroupId, LecturerId): здесь лектор зависит от группы и курса, но спокойно может
	существовать группы, у которой нет лектора по некоторому курсу (например, если у группы нет такого курса). Поэтому
	отношение уже находится в 4НФ.
	
	Рассмотрим отношение (LecturerId, LecturerName). По теореме Дейта-Фейгина 2, так как это отношение находится в НФБК и у него
	есть простой ключ (LecturerId), то это отношение уже находится в 4НФ.

##### 4.2. Результат

<sub>Для каждого отношения из предыдущей нормальной формы укажите на какие отношения вы его разбили в формате, указанном в пункте 1.2.<sub>

	(StudentId, StudentName, GroupId) => (StudentId, StudentName, GroupId).
	(GroupId, GroupName) => (GroupId, GroupName).
	(CourseId, CourseName) => (CourseId, CourseName).
	(CourseId, StudentId, Mark) => (CourseId, StudentId, Mark).
	(CourseId, GroupId, LecturerId) => (CourseId, GroupId, LecturerId).
	(LecturerId, LecturerName) => (LecturerId, LecturerName).

##### 5. Пятая нормальная форма

##### 5.1. Описание

<sub>Для отношений из трёх и менее атрибутов должны быть приведены контрпримеры.<sub>

	Рассмотрим отношение (StudentId, StudentName, GroupId). По теореме Дейта-Фейгина 1, так как это отношение находится в 3НФ
	и у него все ключи простые, то это отношение уже находится в 5НФ.
	
	Рассмотрим отношение (GroupId, GroupName). По теореме Дейта-Фейгина 1, так как это отношение находится в 3НФ и у него все
	ключи простые, то это отношение уже находится в 5НФ.
	
	Рассмотрим отношение (CourseId, CourseName). По теореме Дейта-Фейгина 1, так как это отношение находится в 3НФ и у него все
	ключи простые, то это отношение уже находится в 5НФ.
	
	Рассмотрим отношение (CourseId, GroupId, LecturerId). Оно имеет единственную ФЗ CourseId, GroupId -> LecturerId. Попытаемся
	найти все нетривиальные ЗС. Так как в этом отношении всего три атрибута, то единственные отношения содержащие более одного
	атрибута, которые могли бы получиться в результате декомпозиций, выглядят как (CourseId, GroupId), (CourseId, LecturerId),
	(GroupId, LecturerId). Если бы в результате декомпозиции мы бы получили отношение с одним атрибутом, мы бы гарантированно
	получили бы потерю связанности данных. Рассмотрим только вариант декомпозиции, когда мы получаем все эти отношения, поскольку
	в ином случае ситуация будет не лучше. Попробуем построить пример отношения (CourseId, GroupId, LecturerId). Добавим элементы
	[1, 1, 1], [1, 2, 2] и [2, 1, 2]. Изобразим в виде таблицы то, какие данные должны хранить отношения,
	полученные после декомпозиции.
	(CId, GId, LId) | (CId, GId) | (CId, LId) | (GId, LId) | (CId, GId) + (CId, LId) + (GId, LId)
	-----------------------------------------------------------------------------------------------
	[1, 1, 1]             | [1, 1]         |  [1, 1]       |  [1, 1]        |  [1, 1, 1]
	[1, 2, 2]             | [1, 2]         |  [1, 2]       |  [1, 2]        |  [1, 1, 2]
	[2, 1, 2]             | [2, 1]         |  [2, 2]       |  [2, 2]        |  [1, 2, 2]
                                                                            |  [2, 1, 2]
	
	Как мы видим (CourseId, GroupId, LecturerId) не эквивалентно (CourseId, GroupId) + (CourseId, LecturerId) + (GroupId, LecturerId),
	поскольку последнее отношение содержит записи [1, 1, 1] и [1, 1, 2], которые запрещены в отношении (CourseId, GroupId, LecturerId)
	в силу функциональной зависимости CourseId, GroupId -> LecturerId. Следовательно, такая декомпозиция несёт потери, а поскольку
	больше вариантов декомпозиции нет, то отношение (CourseId, GroupId, LecturerId) находится в 5НФ.
	
	Аналогично и с отношением (CourseId, StudentId, Mark), если мы попытаемся декомпозировать его на отношения с меньшим
	количеством атрибутов, то тоже понесём потери, следовательно данное отношение уже находится в 5НФ
	
	Рассмотрим отношение (LecturerId, LecturerName). По теореме Дейта-Фейгина 1, так как это отношение находится в 3НФ и у
	него все ключи простые, то это отношение уже находится в 5НФ.

##### 5.2. Результат

<sub>Для каждого отношения из предыдущей нормальной формы укажите на какие отношения вы его разбили в формате, указанном в пункте 1.2.<sub>

	(StudentId, StudentName, GroupId) => (StudentId, StudentName, GroupId).
	(GroupId, GroupName) => (GroupId, GroupName).
	(CourseId, CourseName) => (CourseId, CourseName).
	(CourseId, StudentId, Mark) => (CourseId, StudentId, Mark).
	(CourseId, GroupId, LecturerId) => (CourseId, GroupId, LecturerId).
	(LecturerId, LecturerName) => (LecturerId, LecturerName).

##### 6. Модели

##### 6. Диаграммы ERM и PDM

[Диаграммы ERM и PDM](src/models.drawio)

##### 7. SQL

<sub>Помните, что SQL – это язык программирования, и не забывайте о форматировании и отступах<sub>

##### 7.1. DDL

<sub>Определение схемы базы данных<sub>

[DDL](src/DDL.sql)

##### 7.2. DML

<sub>Пример тестовых данных. Достаточно 2-3 записей на таблицу, если они в полной мере демонстрируют особенности БД.\
 Для удобства чтения данные должны быть записаны в том же порядке, что и в схеме.<sub>
 
 [DML](src/DML.sql)