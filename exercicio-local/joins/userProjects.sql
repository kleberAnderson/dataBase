--DELETE DATABASE
USE master
GO
DROP DATABASE ProjectsUsers

--START THE DATABASE
CREATE DATABASE ProjectsUsers
GO
USE ProjectsUsers

--DELETE Users
--DROP TABLE

CREATE TABLE Users (
	id			INT			NOT NULL	IDENTITY(1, 1),
	name		VARCHAR(45)	NOT NULL,
	userName	VARCHAR(45),
	password	VARCHAR(45)	NULL	DEFAULT ('123mudar'),
	email		VARCHAR(45)	NOT NULL
	PRIMARY KEY(id)
)

GO
ALTER TABLE Users
ALTER COLUMN userName VARCHAR(10)


GO
ALTER TABLE Users
ALTER COLUMN password VARCHAR(8) NULL	

GO
CREATE TABLE Projects (
	id			INT			NOT NULL	IDENTITY(10001, 1),
	name		VARCHAR(45)	NOT NULL,
	description	VARCHAR(45),
	date		DATE		NOT NULL	CHECK(date > '20140901')

	PRIMARY KEY(id)
)

GO
CREATE TABLE Users_has_projects (
	users_Id	INT		NOT NULL,
	projects_Id	INT		NOT NULL,
	
	PRIMARY KEY(users_Id, projects_Id),

	FOREIGN KEY(users_Id)
	REFERENCES Users(id),

	FOREIGN KEY(projects_Id)
	REFERENCES Projects(id)
)

GO
INSERT INTO Users (name, userName, password, email) VALUES
('Maria', 'Rh_maria', DEFAULT, 'maria@empresa.com'),
('Paulo', 'Ti_paulo', '123@456', 'paulo@empresa.com'),
('Ana', 'Rh_ana', DEFAULT, 'ana@empresa.com'),
('Clara', 'Ti_clara', DEFAULT, 'clara@empresa.com'),
('Aparecido', 'Rh_apareci', '55@!cido', 'aparecido@empresa.com')

GO
INSERT INTO Projects(name, description, date) VALUES
('Re-folha', 'Refatoração das Folhas', CONVERT(CHAR(10), '20140905', 103)),
('Manutencao PCs', 'Manutencao PCs', CONVERT(CHAR(10), '06/09/2014', 103)),
('Auditoria', NULL, CONVERT(CHAR(10), '07/09/2014', 103))

GO
INSERT INTO Users_has_projects(users_Id, projects_Id) VALUES
(1, 10001),
(5, 10001),
(3, 10003),
(4, 10002),
(2, 10002)

UPDATE Projects
SET date = CONVERT(CHAR(10), '12/09/2014', 103)
WHERE name LIKE 'Manutencao%'

GO
UPDATE Users
SET userName = 'Rh_cido'
WHERE name LIKE 'Aparecido'

GO
UPDATE Users
SET password = '888@*'
WHERE userName LIKE 'Rh_maria'

GO
DELETE Users_has_projects
WHERE users_Id = 2

EXEC sp_help Users
EXEC sp_help Projects
EXEC sp_help Users_has_projects

SELECT * FROM Users
SELECT * FROM Projects
SELECT * FROM Users_has_projects
GO
--Adicionar User
INSERT INTO Users(name, userName, password, email) VALUES
('Joao', 'Ti_joao', DEFAULT, 'joao@empresa.com')

GO
--Adicionar Project
INSERT INTO Projects(name, description, date) VALUES
('Atualização de Sistemas', 'Modificação de Sistemas Operacionais nos PCs', CONVERT(date, '12/09/2014', 103))

--Consultar
--Id, Name e Email de Users, Id Name, Description e Data de Projects,
--dos usuários que participaram do projeto Name Re-Folha
SELECT us.id, us.name, us.email, pr.id, pr.name, pr.description
FROM Projects pr INNER JOIN Users_has_projects up 
ON pr.id = up.projects_Id
INNER JOIN Users us
ON us.id = up.users_Id
WHERE pr.name = 'Re-folha'
ORDER BY us.name ASC

--Name dos projects que não tem Users
SELECT pr.name
FROM Projects pr LEFT OUTER JOIN Users_has_projects up
ON pr.id = up.projects_Id
WHERE up.users_Id IS NULL

--Name dos Users que não tem Projects
SELECT us.name
FROM Users us LEFT OUTER JOIN Users_has_projects up
ON us.id = up.users_Id
WHERE up.users_Id IS NULL