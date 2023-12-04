-- Найти студентов из заданной группы с заданной фамилией
-- (Сначала поиск по группе, затем по префиксу имени)
SELECT StudentId, StudentName, GroupId
FROM Students
WHERE GroupId IN (SELECT GroupId
		                    FROM Groups
		                    WHERE GroupName = :GroupName)
	                      AND StudentName LIKE CONCAT(:LastName, ' %');