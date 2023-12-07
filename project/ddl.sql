CREATE TABLE CharacterLevels(
	Level INT PRIMARY KEY CHECK(Level >= 1 AND Level <= 90),
	Experience INT NOT NULL
);

CREATE TABLE Ranks(
	Rank INT PRIMARY KEY CHECK(Rank >= 0 AND Rank <= 6),
	MinLevel INT NOT NULL,
	MaxLevel INT NOT NULL
);

CREATE TABLE Characters(
	Id INT PRIMARY KEY,
	Name VARCHAR(50) NOT NULL,
	Level INT NOT NULL,
	Rank INT NOT NULL,
	FOREIGN KEY (Level) REFERENCES CharacterLevels(Level),
	FOREIGN KEY (Rank) REFERENCES Ranks(Rank)
);

CREATE TABLE WeaponLevels(
	Level INT PRIMARY KEY CHECK(Level >= 1 AND Level <= 90),
	Experience INT NOT NULL
);

CREATE TABLE Weapons(
	Id INT PRIMARY KEY,
	Name VARCHAR(50) NOT NULL,
	Level INT NOT NULL,
	Rank INT NOT NULL,
	FOREIGN KEY (Level) REFERENCES WeaponLevels(Level),
	FOREIGN KEY (Rank) REFERENCES Ranks(Rank)
);

CREATE TYPE resourceClass AS ENUM ('resourceFromMob', 
								   'resourceFromBoss', 
								   'resourceFromWorld', 
								   'resourceFromDungeon', 
								   'other');

CREATE TABLE ResourceClasses(
	Id INT PRIMARY KEY,
	Name resourceClass NOT NULL
);

CREATE TABLE ResourceCountForCharacterElevations(
	Rank INT NOT NULL,
	ResourceClassId INT NOT NULL,
	ResourceCount INT NOT NULL,
	PRIMARY KEY(Rank, ResourceClassId),
	FOREIGN KEY (Rank) REFERENCES Ranks(Rank),
	FOREIGN KEY (ResourceClassId) REFERENCES ResourceClasses(Id)
);

CREATE TABLE ResourceCountForWeaponElevations(
	Rank INT NOT NULL,
	ResourceClassId INT NOT NULL,
	ResourceType INT NOT NULL CHECK(ResourceType = 0 OR ResourceType = 1),
	ResourceCount INT NOT NULL,
	PRIMARY KEY(Rank, ResourceClassId),
	FOREIGN KEY (Rank) REFERENCES Ranks(Rank),
	FOREIGN KEY (ResourceClassId) REFERENCES ResourceClasses(Id)
);

CREATE TABLE Resources(
	Id INT PRIMARY KEY,
	Name VARCHAR(50) NOT NULL,
	Rarity INT NOT NULL CHECK (Rarity = 3 OR Rarity = 4 OR Rarity = 5),
	ResourceClassId INT NOT NULL,
	FOREIGN KEY (ResourceClassId) REFERENCES ResourceClasses(Id)
);

CREATE TABLE Inventory(
	ResourceId INT PRIMARY KEY,
	ResourceCount INT NOT NULL,
	FOREIGN KEY (ResourceId) REFERENCES Resources(Id)
);