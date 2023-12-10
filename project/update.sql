--Функция для триггера, который проверяет корректность данных о персонажах
CREATE FUNCTION CheckCharacterData() RETURNS TRIGGER AS
$$
DECLARE
    is_correct BOOLEAN;
    bad        RECORD;
BEGIN
    is_correct = TRUE;
    FOR bad IN SELECT Name, Level, Rank, MinLevel, MaxLevel
               FROM Characters NATURAL JOIN Ranks
               WHERE Level < MinLevel OR Level > MaxLevel
        LOOP
            is_correct = FALSE;
            RAISE NOTICE 'Для персонажа % указан уровень % не удовлетворяющий ограничениям ранга %. Уровень персонажа для ранга % может быть от % до %', bad.Name, bad.Level, bad.Rank, bad.Rank, bad.MinLevel, bad.MaxLevel;
        END LOOP;
    IF NOT is_correct
    THEN
        RAISE EXCEPTION 'Есть некорректные данные по персонажам';
    END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Триггер для проверки вставляемых данных о персонажах на корректность
CREATE TRIGGER CheckCharacter
	AFTER INSERT OR UPDATE OF Level, Rank
	ON Characters
	FOR EACH STATEMENT
	EXECUTE PROCEDURE CheckCharacterData();

--Функция для триггера, который проверяет корректность данных об оружии
CREATE FUNCTION CheckWeaponData() RETURNS TRIGGER AS
$$
DECLARE
    is_correct BOOLEAN;
    bad        RECORD;
BEGIN
    is_correct = TRUE;
    FOR bad IN SELECT Name, Level, Rank, MinLevel, MaxLevel
               FROM Weapons NATURAL JOIN Ranks
               WHERE Level < MinLevel OR Level > MaxLevel
        LOOP
            is_correct = FALSE;
            RAISE NOTICE 'Для оружия % указан уровень % не удовлетворяющий ограничениям ранга %. Уровень оружия для ранга % может быть от % до %', bad.Name, bad.Level, bad.Rank, bad.Rank, bad.MinLevel, bad.MaxLevel;
        END LOOP;
    IF NOT is_correct
    THEN
        RAISE EXCEPTION 'Есть некорректные данные по персонажам';
    END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Триггер для проверки вставляемых данных об оружии на корректность
CREATE TRIGGER CheckWeapon
	AFTER INSERT OR UPDATE OF Level, Rank
	ON Weapons
	FOR EACH STATEMENT
	EXECUTE PROCEDURE CheckWeaponData();

--Возвращает количество книжек опыта(самых больших), которые нужно потратить, чтобы прокачать персонажа с его текущего уровня(_CurLevel)
--до некоторого определённого уровня(_Level)
CREATE FUNCTION ExperienceBooksCount(IN _CurLevel INT, IN _Level INT) RETURNS INT AS
$$
DECLARE
	ExperienceBooks INT = 0;
	ExperienceCount INT = 0;
	CurRank INT;
	NewRank INT;
BEGIN
	SELECT Rank INTO CurRank 
	FROM Ranks 
	WHERE _CurLevel >= MinLevel AND _CurLevel < MaxLevel;
	
	SELECT Rank INTO NewRank
	FROM Ranks
	WHERE _Level > MinLevel AND _Level <= MaxLevel;
	
	WHILE CurRank <= NewRank LOOP
		SELECT SUM(Experience) INTO ExperienceCount
		FROM CharacterLevels
		WHERE Level >= _CurLevel AND Level < LEAST((SELECT MaxLevel FROM Ranks WHERE Rank = CurRank), _Level);
		ExperienceBooks = ExperienceBooks + CEIL(ExperienceCount / 20000.0);
		SELECT MaxLevel INTO _CurLevel FROM Ranks WHERE Rank = CurRank;
		CurRank = CurRank + 1;
	END LOOP;
	
	RETURN ExperienceBooks;
END;
$$ LANGUAGE plpgsql;

--Функция, которая подсчитывает количество ресурсов необходимых для прокачки персонажа с его текущего уровня до уровня _Level
CREATE FUNCTION AllResourcesCount(in _Name VARCHAR(50), in _Level INT) RETURNS TABLE(ResourceName VARCHAR(50), ResourceCount INT) AS
$$
DECLARE
	CurLevel INT;
	CurRank INT;
	NewRank INT;
BEGIN
	SELECT Level INTO CurLevel FROM Characters WHERE Name = _Name;
	SELECT Rank INTO CurRank FROM Characters WHERE Name = _Name;
	SELECT Rank INTO NewRank FROM Ranks WHERE _Level >= MinLevel AND _Level <= MaxLevel;
	
	RETURN QUERY 
	SELECT R.Name, SUM(RC.ResourceCount)::INT AS cnt
	FROM Characters C
 		INNER JOIN CharacterResources CR ON Id = CharacterId
 		INNER JOIN Resources R ON R.Id = CR.ResourceId
 		INNER JOIN ResourceCountForCharacterElevations RC ON R.ResourceClassId = RC.ResourceClassId AND CurRank < RC.Rank AND RC.Rank < NewRank AND RC.ResourceRarity = R.Rarity
 	WHERE C.Name = _Name
 	GROUP BY R.Name
	UNION
	SELECT 'Опыт героя' AS ResourceName, ExperienceBooksCount(CurLevel, _Level) AS ResourceCount;
END;
$$ LANGUAGE plpgsql;

--Функция, которая выводит количество ресурсов, которых не хватает на удучшение персонажа до уровня _Level
CREATE FUNCTION AllResourcesCountWithInventory(in _Name VARCHAR(50), in _Level INT) RETURNS TABLE(ResourceName VARCHAR(50), ResourceCount INT) AS
$$
BEGIN
	RETURN QUERY 
	SELECT ARC.ResourceName, ARC.ResourceCount - I.ResourceCount AS ResourceCount 
	FROM AllResourcesCount(_Name, _Level) ARC
			INNER JOIN Resources R ON R.Name = ARC.ResourceName
			INNER JOIN Inventory I ON I.ResourceId = R.Id
	WHERE ARC.ResourceCount - I.ResourceCount > 0;
END;
$$ LANGUAGE plpgsql;

--Для каждого персонажа выводит истину, если его можно прокачать до уровня _Level и ложь иначе
CREATE FUNCTION CanCharacterElevations(in _Level INT) RETURNS TABLE(CharacterName VARCHAR(50), CanElevations BOOLEAN) AS
$$
BEGIN
	RETURN QUERY 
	SELECT Name AS CharacterName, (SELECT COUNT(*) = 0 FROM AllResourcesCountWithInventory(Name, _Level)) AS CanElevations
	FROM Characters
	WHERE Level <> _Level;
END;
$$ LANGUAGE plpgsql;