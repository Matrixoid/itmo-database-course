-- создать нового пользоватля с паролем
CREATE PROCEDURE CreateNewUser(in UserId INTEGER, in Pass VARCHAR(64))
AS
$$
BEGIN
    INSERT INTO Users (UserId, Pass) VALUES
	  (UserId, CRYPT(Pass, GEN_SALT('md5')));
end;
$$ language plpgsql;

-- Проверка на то, зарегистрирован ли пользователь в системе
CREATE FUNCTION UserIsValid(IN _UserId INTEGER , IN _Pass VARCHAR(64))
RETURNS BOOLEAN
AS
$$
BEGIN
    RETURN EXISTS(SELECT UserId
            	  FROM Users
            	  WHERE UserId = _UserId
              		AND Pass = CRYPT(_Pass, Pass));
END;
$$ LANGUAGE plpgsql;