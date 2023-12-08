--Количество опыта, которое необходимо для прокачки пперсонажа от ранга до ранга
SELECT Rank, SUM(Experience) AS Exp
FROM Ranks, CharacterLevels
WHERE Level >= MinLevel AND Level < MaxLevel
Group BY Rank
ORDER BY Rank; 

-- Выводит количество ресурсов, которые необходимы для возвышения каждого персонажа с первого ранга до максимального ранга(без учёта опыта)
SELECT Name, SUM(ResourceCount) AS cnt
FROM ResourceCountForCharacterElevations NATURAL JOIN Resources WHERE Rarity = ResourceRarity
GROUP BY Name;

-- Выводит количество ресурсов, которые необходимы для возвышения каждого персонажа с его текущего ранга до максимального ранга(без учёта опыта)
SELECT C.Name, R.Name, SUM(RC.ResourceCount) AS cnt
FROM Characters C
		INNER JOIN CharacterResources CR ON Id = CharacterId
		INNER JOIN Resources R ON R.Id = CR.ResourceId
		INNER JOIN ResourceCountForCharacterElevations RC ON R.ResourceClassId = RC.ResourceClassId AND C.Rank < RC.Rank AND RC.ResourceRarity = R.Rarity
GROUP BY C.Name, R.Name;