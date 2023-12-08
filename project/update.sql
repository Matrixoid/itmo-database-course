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