# Домашнее задание 3. Функциональные зависимости в БД «Университет»
Дано отношение с атрибутами *StudentId*, *StudentName*, *GroupId*, *GroupName*, *CourseId*, *CourseName*, *LecturerId*, *LecturerName*, *Mark*.

1. Найдите функциональные зависимости в данном отношении.
1. Найдите все ключи данного отношения.
1. Найдите замыкание множеств атрибутов:\
	1.*GroupId*, *CourseId*;\
	2.*StudentId*, *CourseId*;\
	3.*StudentId*, *LecturerId*.
1. Найдите неприводимое множество функциональных зависимостей для данного отношения.

Примечания

1. Не требуется поддержка:
	- нескольких университетов;
	- дисциплин по выбору;
	- дисциплин с необычным распределением по группам (таких как физическая культура и иностранный язык);
	- переводов между группами;
	- нескольких оценок по одной дисциплине.
1. Многосеместровые дисциплины считаются по семестрам, например: Математический анализ (семестр 1); Математический анализ (семестр 2).

В рамках проекта:

1. Определите набор атрибутов, необходимых для проекта, и определите отношения на них.
1. Найдите функциональные зависимости полученных отношений.
1. Найдите все ключи полученных отношений.
1. Найдите неприводимые множества функциональных зависимостей для полученных отношений.

# Введение в СУБД. ДЗ-3

##### 1. Функциональные зависимости

<sub>Функциональные зависимости должны быть заданы по одной на строке в формате «A, B -> D, E».\
\
Названия атрибутов должны быть как в условии ДЗ.\<sub>

	StudentId -> StudentName, GroupId, GroupName
	GroupId -> GroupName
	GroupName -> GroupId
	CourseId -> CourseName
	LecturerId -> LecturerName
	StudentId, CourseId -> Mark
	CourseId, GroupId -> LecturerId, LecturerName 

##### 2. Ключи

##### 2.1. Процесс определения ключей

<sub>Текст в свободной форме<sub>

	StudentId и CourseId являются частью любого надключа, потому что их нет в правых частях ФЗ.
	Построим замыкание {StudentId, CourseId} получим {StudentId, CourseId, StudentName, GroupId, GroupName, CourseName,
	LecturerId, LecturerName, Mark}, что является множеством всех атрибутов.
	Попробуем выкинуть из этого надключа отдельные атрибуты:
	Выкинуть StudentId нельзя, потому что замыкание {CourseId} это {CourseId, CourseName}, что не является множеством всех
	атрибутов.
	Выкинуть CourseId тоже нельзя, потому что замыкание {StudentId} это {StudentId, StudentName, GroupId, GroupName}, что
	не является множеством всех атрибутов.

##### 2.2. Полученные ключи

<sub>По одному на строке в формате «A, B, C»<sub>

	StudentId, CourseId

##### 3. Замыкания множества атрибутов

##### 3.1. GroupId, CourseId

<sub>Последовательность построения замыкания после каждого его расширения, по одному множеству на строке в формате  «A, B, C».\
\
В первой строке должно быть исходное множество, а в последней — само замыкание.\<sub>

	GroupId, CourseId
	GroupId, CourseId, GroupName
	GroupId, CourseId, GroupName, CourseName
	GroupId, CourseId, GroupName, CourseName, LecturerId, LecturerName

##### 3.2. StudentId, CourseId

<sub>В формате из пункта 3.1.<sub>

	StudentId, CourseId
	StudentId, CourseId, StudentName, GroupId, GroupName
	StudentId, CourseId, StudentName, GroupId, GroupName, CourseName
	StudentId, CourseId, StudentName, GroupId, GroupName, CourseName, Mark
	StudentId, CourseId, StudentName, GroupId, GroupName, CourseName, Mark, LecturerId, LecturerName

##### 3.3. StudentId, LecturerId

<sub>В формате из пункта 3.1.<sub>

	StudentId, LecturerId
	StudentId, LecturerId, StudentName, GroupId, GroupName
	StudentId, LecturerId, StudentName, GroupId, GroupName, LecturerName

##### 4. Неприводимое множество функциональных зависимостей

##### 4.1d. Первый этап

<sub>Описание процесса (текст в свободной форме)<sub>

	Расщепление правых частей.
	
	1. Для StudentId -> StudentName, GroupId, GroupName в результате расщепления будут получены следующие ФЗ:
	StudentId -> StudentName
	StudentId -> GroupId
	StudentId -> GroupName

	2. Для CourseId, GroupId -> LecturerId, LecturerName  в результате расщепления будут получены следующие ФЗ:
	CourseId, GroupId -> LecturerId
	CourseId, GroupId -> LecturerName

##### 4.1r. Результаты первого этапа

<sub>В формате из пункта 1<sub>

	StudentId -> StudentName
	StudentId -> GroupId
	StudentId -> GroupName
	GroupId -> GroupName
	GroupName -> GroupId
	CourseId -> CourseName
	LecturerId -> LecturerName
	StudentId, CourseId -> Mark
	CourseId, GroupId -> LecturerId
	CourseId, GroupId -> LecturerName

##### 4.2d. Второй этап

<sub>Описание процесса (текст в свободной форме)<sub>

	Удаление атрибута.
	
	Для левых частей следующих ФЗ попытаемся удалить по одному атрибуту:
	StudentId, CourseId -> Mark
	CourseId, GroupId -> LecturerId
	CourseId, GroupId -> LecturerName
	
	Рассмотрим ФЗ StudentId, CourseId -> Mark. Попытаемся удалить StudentId. Замыканием CourseId над старым множеством правил
	было {CourseId, CourseName}. После удаления StudentId, замыканием CourseId стало {CourseId, CourseName, Mark}. Следовательно
	это не эквивалентные ФЗ и удалить StudentId мы не можем. Теперь попытаемся удалить CourseId. Замыканием StudentId над старым
	множеством правил было {StudentId, StudentName, GroupId, GroupName}. После удаления CourseId, замыканием StudentId
	стало {StudentId, StudentName, GroupId, GroupName, Mark}. Следовательно это не эквивалентные ФЗ и удалить CourseId мы не можем.
	
	Рассмотрим ФЗ CourseId, GroupId -> LecturerId. Попытаемся удалить CourseId. Замыканием GroupId над старым множеством правил
	было {GroupId , GroupName}. После удаления CourseId, замыканием GroupId стало {GroupId , GroupName, LecturerId}. Следовательно
	это не эквивалентные ФЗ и удалить CourseId мы не можем. Теперь попытаемся удалить GroupId. Замыканием CourseId над старым
	множеством правил было {CourseId, CourseName}. После удаления GroupId, замыканием CourseId стало
	{CourseId, CourseName, LecturerId}. Следовательно это не эквивалентные ФЗ и удалить GroupId  мы не можем.
	
	Рассмотрим ФЗ CourseId, GroupId -> LecturerName. Попытаемся удалить CourseId. Замыканием GroupId над старым множеством правил
	было {GroupId , GroupName}. После удаления CourseId, замыканием GroupId стало {GroupId , GroupName, LecturerName}.
	Следовательно это не эквивалентные ФЗ и удалить CourseId мы не можем. Теперь попытаемся удалить GroupId. Замыканием CourseId
	над старым множеством правил было {CourseId, CourseName}. После удаления GroupId, замыканием CourseId стало
	{CourseId, CourseName, LecturerName}. Следовательно это не эквивалентные ФЗ и удалить GroupId  мы не можем.
	
	В результате второго этапа множество ФЗ не изменилось

##### 4.2r. Результаты второго этапа

<sub>В формате из пункта 1<sub>

	StudentId -> StudentName
	StudentId -> GroupId
	StudentId -> GroupName
	GroupId -> GroupName
	GroupName -> GroupId
	CourseId -> CourseName
	LecturerId -> LecturerName
	StudentId, CourseId -> Mark
	CourseId, GroupId -> LecturerId
	CourseId, GroupId -> LecturerName

##### 4.3d. Третий этап

<sub>Описание процесса (текст в свободной форме)<sub>

	Удаление правила.
	
	Попробуем удалить правило StudentId -> StudentName. Замыкание {StudentId} это {StudentId, GroupId, GroupName}.
	StudentName в нём нет. Значит это правило нельзя удалить
	
	Попробуем удалить правило StudentId -> GroupId. Замыкание {StudentId} это {StudentId, StudentName, GroupName, GroupId}.
	В нём есть GroupId. Значит это правило можно удалить. Новое множество ФЗ:
	StudentId -> StudentName
	StudentId -> GroupName
	GroupId -> GroupName
	GroupName -> GroupId
	CourseId -> CourseName
	LecturerId -> LecturerName
	StudentId, CourseId -> Mark
	CourseId, GroupId -> LecturerId
	CourseId, GroupId -> LecturerName
	
	Попробуем удалить правило StudentId -> GroupName. Замыкание {StudentId} это {StudentId, StudentName}.
	GroupName в нём нет. Значит это правило удалить нельзя.
	
	Попробуем удалить правило GroupId -> GroupName. Замыкание {GroupId} это {GroupId}. GroupName в нём нет.
	Значит это правило нельзя удалить.
	
	Попробуем удалить правило GroupName -> GroupId. Замыкание {GroupName} это {GroupName}. GroupId в нём нет.
	Значит это правило нельзя удалить.
	
	Попробуем удалить правило CourseId -> CourseName. Замыкание {CourseId} это {CourseId}. CourseName в нём нет.
	Значит это правило нельзя удалить.
	
	Попробуем удалить правило LecturerId -> LecturerName. Замыкание {LecturerId} это {LecturerId}. LecturerName в нём нет.
	Значит это правило нельзя удалить.
	
	Попробуем удалить правило StudentId, CourseId -> Mark. Замыкание {StudentId, CourseId} это
	{StudentId, CourseId, StudentName, GroupName, GroupId, CourseName, LecturerId, LecturerName}. Mark в нём нет.
	Значит это правило нельзя удалить.
	
	Попробуем удалить правило CourseId, GroupId -> LecturerId. Замыкание {CourseId, GroupId} это
	{CourseId, GroupId, CourseName. GroupName, LecturerName}. LecturerId в нём нет. Значит это правило нельзя удалить.
	
	Попробуем удалить правило CourseId, GroupId -> LecturerName. Замыкание {CourseId, GroupId} это
	{CourseId, GroupId, CourseName, GroupName, LecturerId, LecturerName}. В нём есть LecturerName.
	Значит это правило можно удалить. Новое множество ФЗ:
	StudentId -> StudentName
	StudentId -> GroupName
	GroupId -> GroupName
	GroupName -> GroupId
	CourseId -> CourseName
	LecturerId -> LecturerName
	StudentId, CourseId -> Mark
	CourseId, GroupId -> LecturerId

##### 4.3r. Результаты третьего этапа

<sub>В формате из пункта 1<sub>

	StudentId -> StudentName
	StudentId -> GroupName
	GroupId -> GroupName
	GroupName -> GroupId
	CourseId -> CourseName
	LecturerId -> LecturerName
	StudentId, CourseId -> Mark
	CourseId, GroupId -> LecturerId