# Домашнее задание 1. Установка и использование СУБД
1. Установите систему управления реляционными базами данных.
1. Узнайте, как в вашей СУБД исполнять SQL в интерактивном режиме.
1. Узнайте, как в вашей СУБД исполнять SQL в пакетном режиме.
1. Разберитесь, как в вашей СУБД осуществляется поддержка русского языка.
1. Создайте базу данных и наполните ее в соответствии с примерами из презентации.

Ожидаемая структура проекта

1. Текстовая часть\
	1.Описание предметной области с кратким описанием неочевидных сущностей и атрибутов.\
	2.Предварительное разбиение на отношения (может отсутствовать).\
	3.Для каждого отношения: определение функциональных зависимостей, нормализация до 5НФ, денормализация (при необходимости).\
	4.Модель сущность-связь.\
	5.Физическая модель (должна соответствовать ERM) с указанием типов для доменов.
2. Часть на SQL
	- ddl.sql – описание таблиц и индексов.
	- insert.sql – добавление тестовых данных.
	- select.sql – запросы на получение данных и представления.
	- update.sql – запросы на изменение данных, хранимые процедуры и триггеры.
	
В рамках проекта:
- Выберите тему проекта.

# Базы данных. ДЗ-1. Введение

##### Название СУБД: PostgreSQL

##### Версия СУБД: 16

##### 1. Добавьте студентов в группу M34391

<sub>Кучма Андрей Андреевич\
Шехунов Максим Александрович\
Дзестелов Хетаг Артурович\
Жогова Мария Сергеевна<sub>

##### 1.1. Использованный оператор

```sql
INSERT INTO Students(student_id, name, group_id)
VALUES
  (4, 'Кучма Андрей Андреевич', 2),
  (5, 'Шехунов Максим Александрович', 2),
  (6, 'Дзестелов Хетаг Артурович', 2),
  (7, 'Жогова Мария Сергеевна', 2);
```

##### 1.2. Результат исполнения

	INSERT 0 4
	
##### 2. Исполните запросы

<sub>Результат исполнения каждого запроса – одно число<sub>

##### 2.1. 

<sub>select count(*) from Groups;<sub>

	2
##### 2.2. 

<sub>select count(*) from Students;<sub>

	7

##### 2.3

<sub>select count(*)\
from Students\
where group_id in (select group_id from Groups where group_no = 'M34391');
<sub>

	5

##### 2.4

<sub>select count(*)\
from Students natural join Groups\
where name like '%зе%' or group_no like '%7%';<sub>

	3

##### 2.5

<sub>select count(*)\
from Students natural join Groups\
where name like '%v' and group_no like '%7%';<sub>

	1

##### 3. Удалите все строки из таблицы Groups.

##### 3.1. Использованный оператор

```sql
DELETE FROM Groups WHERE 1=1;
```

##### 3.2. Результат исполнения

	ERROR:  update or delete on table "groups" violates foreign key constraint "students_group_id_fkey" on table "students"
	ПОДРОБНОСТИ:  Key (group_id)=(1) is still referenced from table "students".

##### 4. Удалите все строки из таблицы Students.

##### 4.1. Использованный оператор

```sql
DELETE FROM Students WHERE 1=1;
```

##### 4.2. Результат исполнения

	DELETE 7

##### 5. Удалите все строки из таблицы Groups.

<sub>Нет, это не ошибка<sub>

##### 5.1. Использованный оператор

```sql
DELETE FROM Groups WHERE 1=1;
```

##### 5.2. Результат исполнения

	DELETE 2

##### 6. Добавьте в базу информацию о студентах

<sub>Группа M34361: 1 студент\
Группа M34371: 4 студента\
Группа M34381: 3 студента\
Группа M34391: 2 студента<sub>

##### 6.1. Использованные операторы

```sql
INSERT INTO Groups
VALUES
  (1, 'M34361'),
  (2, 'M34371'),
  (3, 'M34381'),
  (4, 'M34391');
	
INSERT INTO Students
VALUES
  (1, 'Бац Константин Александрович', 1),
  (2, 'Ахметов Марсель Ринатович', 2),
  (3, 'Джахбаров Владимир Юрьевич', 2),
  (4, 'Чмыхалов Артемий Витальевич', 2),
  (5, 'Фроликов Борис Дмитриевич', 2),
  (6, 'Фитисов Артём Вячеславович', 3),
  (7, 'Юдов Виктор Сергеевич', 3),
  (8, 'Подцепко Игорь Сергеевич', 3),
  (9, 'Нагибин Вадим Алексеевич', 4),
  (10, 'Галибов Михаил Олегович', 4);
```

##### 6.2. Результаты исполнения

	INSERT 0 4
	INSERT 0 10

##### 7. Исполните запросы

##### 7.1.

<sub>select group_no, count(*)\
from Groups g inner join Students s on g.group_id = s.group_id\
group by group_no\
order by group_no desc;<sub>

	 group_no | count
	----------+-------
	 M34391   |     2
	 M34381   |     3
	 M34371   |     4
	 M34361   |     1
	(4 строки)

##### 7.2.

<sub>select group_no, count(*)\
from Groups g inner join Students s on g.group_id <> s.group_id\
where group_no not like '%7%'\
group by group_no\
order by group_no;<sub>

	 group_no | count
	----------+-------
	 M34361   |     9
	 M34381   |     7
	 M34391   |     8
	(3 строки)

##### 8. Вопросы на понимание пройденного

##### 8.1. В чем заключается отличие иерархических и сетевых баз данных?

>В иерархических БД структура древовидная и за счёт этого для иерархических БД возможна только одна иерархия записей. В сетевых БД же возможны несколько иерархий. В сетевых БД возможны все виды связей, а в иерархический БД не возможна связь многие ко многим.

##### 8.2. Почему построитель плана исполнения зависит от хранилища данных?

>Построитель плана зависит от хранилища данных для того, чтобы иметь возможность смотреть на текущие данные и собирать по ним статистику, если она потребуется и оптимизировать под это запросы

##### 8.3. Почему построитель плана исполнения зависит от менеджера памяти?

>Чтобы смотреть сколько доступно свободной памяти, чтобы наши запросы влезли в том лимит, который нам готовы обеспечить. Также построитель запроса может посмотреть какие закешированные данные мы можем взять