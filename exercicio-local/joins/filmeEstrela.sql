--DELETE DATABASE
USE master
GO
DROP DATABASE LocadoraFilme

--START THE DATABASE
CREATE DATABASE LocadoraFilme
GO
USE LocadoraFilme

--DELETE ENTITY
--DROP TABLE

GO
CREATE TABLE Filme(
	id		INT		IDENTITY(1001, 1),
	titulo	VARCHAR(40)	NOT NULL,
	ano		INT			NOT NULL CHECK(LEN(ano) <= 2021)

	PRIMARY KEY(id)
)
GO
ALTER TABLE Filme
ALTER COLUMN titulo VARCHAR(80) NOT NULL

GO
CREATE TABLE Estrela(
	id			INT			NOT NULL	IDENTITY(9901, 1),
	nome		VARCHAR(40)	NOT NULL
	PRIMARY KEY(id)
)
GO
ALTER TABLE Estrela ADD nomeReal VARCHAR(50)

GO
CREATE TABLE Filme_Estrela(
	filmeId		INT,
	estrelaId	INT		NOT NULL,

	PRIMARY KEY(filmeId, estrelaId),

	FOREIGN KEY(filmeId)
	REFERENCES Filme(id),

	FOREIGN KEY(estrelaId)
	REFERENCES Estrela(id)
)
GO
CREATE TABLE Dvd(
	num				INT	IDENTITY(10001, 1),
	data_Fabricacao	DATE	NOT NULL CHECK(data_Fabricacao < GETDATE()),
	filmeId			INT
	
	PRIMARY KEY(num)
	
	FOREIGN KEY(filmeId)
	REFERENCES Filme(id)		
)
GO
CREATE TABLE Cliente(
	num_Cadastro	INT	IDENTITY(5501, 1),
	nome			VARCHAR(70)		NOT NULL,
	logradouro		VARCHAR(150)	NOT NULL,
	num				INT				NOT NULL	CHECK(num >= 0),
	cep				CHAR(8)			NULL	CHECK(LEN(cep) = 8)	

	PRIMARY KEY(num_Cadastro),
)
GO
CREATE TABLE Locacao(
	dvdNum				INT,
	clienteNum_Cadastro	INT,
	data_Locacao		DATE	NOT NULL	DEFAULT(GETDATE()),
	data_Devolucao		DATE			NOT NULL,
	valor				DECIMAL(7, 2)	NOT NULL	CHECK(valor >= 0)

	PRIMARY KEY(data_Locacao, dvdNum, clienteNum_Cadastro),

	FOREIGN KEY(dvdNum)
	REFERENCES Dvd(num),

	FOREIGN KEY(clienteNum_Cadastro)
	REFERENCES Cliente(num_Cadastro),
	CONSTRAINT chk_sx_alt CHECK (
		data_Devolucao > data_Locacao
	)
)
GO
INSERT INTO Filme(titulo, ano) VALUES
('Whiplash', 2015),
('Birdman', 2015),
('Interestelar', 2014),
('A culpa é das estrelas', 2014),
('Alexandre o Dia Terrivel, Horrivel, Espantoso e Horroroso', 2014),
('Sing', 2016)

GO
INSERT INTO Estrela (nome, nomeReal) VALUES	
('Michael Keaton', 'Michael John Douglas'),
('Emma Stone', 'Emily Jean Stone'),
('Miles Teller', NULL),
('Steve Carell', 'Steven John Carell'),
('Jennifer Garner', 'Jennifer Anne Garner')

INSERT INTO Filme_Estrela(filmeId, estrelaId) VALUES
(1002, 9901),
(1002, 9902),
(1001, 9903),
(1005, 9904),
(1005, 9905)

GO
INSERT INTO Dvd(data_Fabricacao, filmeId) VALUES
(CONVERT(DATE, '2020/12/02', 102), 1001),
(CONVERT(DATE, '2019/10/18', 102), 1002),
(CONVERT(DATE, '2020/04/03', 102), 1003),
(CONVERT(DATE, '2020/12/02', 102), 1001),
(CONVERT(DATE, '2019/10/18', 102), 1004),
(CONVERT(DATE, '2020/04/03', 102), 1002),
(CONVERT(DATE, '2020/12/02', 102), 1005),
(CONVERT(DATE, '2019/10/18', 102), 1002),
(CONVERT(DATE, '2020/04/03', 102), 1003)	

INSERT INTO Cliente(nome, logradouro, num, cep) VALUES
('Matilde Luz', 'Rua Síria', 150, '03086040'),
('Carlos Carreiro', 'Rua Bartollomeu', 1250, '04419110'),
('Matilde Luz', 'Rua Itajutiba', 169, NULL),
('Matilde Luz', 'Rua Jayme Von Rosenburg', 36, NULL),
('Matilde Luz', 'Rua Arnaldo Simoes Pinto', 235, '02917110')

GO
INSERT INTO Locacao	(dvdNum, clienteNum_Cadastro, data_Locacao, data_Devolucao, valor) VALUES
(10001, 5502,(CONVERT(DATE, '20210218', 102)), (CONVERT(DATE, '20210221', 102)), CAST('3.50' AS DECIMAL(7, 2))),
(10009, 5502, (CONVERT(DATE, '20210218', 102)), (CONVERT(DATE, '20210221', 102)), CAST('3.50' AS DECIMAL(7, 2))),
(10002, 5503,(CONVERT(DATE, '20210218', 102)), (CONVERT(DATE, '20210219', 102)), CAST('3.50' AS DECIMAL(7, 2))),
(10002, 5505,(CONVERT(DATE, '20210220', 102)), (CONVERT(DATE, '20210223', 102)), CAST('3.00' AS DECIMAL(7, 2))),
(10004, 5505,(CONVERT(DATE, '20210220', 102)), (CONVERT(DATE, '20210223', 102)), CAST('3.00' AS DECIMAL(7, 2))),
(10005, 5505,(CONVERT(DATE, '20210220', 102)), (CONVERT(DATE, '20210223', 102)), CAST('3.00' AS DECIMAL(7, 2))),
(10001, 5501,(CONVERT(DATE, '20210224', 102)), (CONVERT(DATE, '20210226', 102)), CAST('3.50' AS DECIMAL(7, 2))),
(10008, 5501,(CONVERT(DATE, '20210224', 102)), (CONVERT(DATE, '20210226', 102)), CAST('3.50' AS DECIMAL(7, 2)))

--OPERATION
GO
UPDATE Cliente
SET cep = '08411150'
WHERE num_Cadastro = 5503

GO
UPDATE Cliente
SET cep = '02918190'
WHERE num_Cadastro = 5504

GO
UPDATE Locacao
SET valor = 3.25
WHERE data_Locacao = '2021-02-18' AND clienteNum_Cadastro = 5502

GO
UPDATE Locacao
SET valor = 3.10
WHERE data_Locacao = '2021-02-24' AND clienteNum_Cadastro = 5501

GO
UPDATE Dvd
SET data_Fabricacao = '2019-07-14'
WHERE num = 10005

GO
UPDATE Estrela
SET nomeReal = 'Miles Alexander Teller'
WHERE nome LIKE 'Miles Teller'

DELETE Dvd
WHERE filmeId = 1006

GO
--CONSULTATION
EXEC sp_help Users
EXEC sp_help Projects
EXEC sp_help Users_has_projects

SELECT * FROM Filme
SELECT * FROM Estrela
SELECT * FROM Filme_Estrela
SELECT * FROM Dvd
SELECT * FROM Cliente
SELECT * FROM Locacao

--1 Consultar num_cadastro do cliente, nome do cliente, data_locacao(
--Formato dd/mm/aaaa), Qtd_dias_alugado(total de dias que o filme ficou alugado),
--titulo do filme, ano do filme de locacao do cliente cujo nome inicia com Matilde.
GO
SELECT cl.num_Cadastro, cl.nome, CONVERT(VARCHAR(10), lc.data_Locacao, 103) AS data_locacao,
DATEDIFF(DAY, data_Locacao, lc.data_Devolucao) AS qtd_dias,
fi.titulo, fi.ano
FROM Cliente cl INNER JOIN Locacao lc
ON cl.num_Cadastro = lc.clienteNum_Cadastro
INNER JOIN Dvd dvd
ON dvd.num = lc.dvdNum
INNER JOIN Filme fi
ON fi.id = dvd.filmeId
WHERE cl.nome LIKE 'Matilde%'

--2 Consultar nome da estrela, nome_real da estrela, título do filme dos filmes
--cadastrados do ano de 2025
GO
SELECT es.nome, es.nomeReal, fi.titulo
FROM Estrela es INNER JOIN Filme_Estrela fe
ON es.id = fe.estrelaId
INNER JOIN Filme fi
ON fi.id = fe.filmeId
WHERE fi.ano = 2015

--3 Consultar título do filme, data_fabricação do dvd(formato dd/mm/aaaa), caso
--a diferença do ano filme com o ano atual seja maior que 6, deve aparecer a
--diferença do ano com o ano atual concatenado com a palavra anos (Exemplo: 7 anos),
--caso contrário só a diferença (Exemplo: 4).
GO
SELECT fi.titulo, 
CONVERT(VARCHAR(10), dvd.data_Fabricacao, 103) AS dt_Fab,
	CASE
		WHEN YEAR(GETDATE()) - fi.ano > 6
		THEN CAST(YEAR(GETDATE()) - fi.ano AS VARCHAR(4)) + ' anos'
		ELSE CAST(YEAR(GETDATE()) - fi.ano AS VARCHAR(4))
		END AS dif_ano

FROM Filme fi INNER JOIN Dvd dvd
ON fi.id = dvd.filmeId