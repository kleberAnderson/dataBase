CREATE DATABASE cursoresAula15
GO
USE cursoresAula15
GO
CREATE TABLE curso (
codigo		INT			NOT NULL,
nome		VARCHAR(50)	NOT NULl,
duracao		INT			NOT NULL
PRIMARY KEY (codigo)
)
GO
INSERT INTO curso VALUES
(48, 'Análise e Desenvolvimento de Sistemas', 2880),
(51, 'Logistica', 2880),
(67, 'Polímeros',  2880),
(73, 'Comércio Exterior', 2600),
(94, 'Gestão Empresarial', 2600)
GO
CREATE TABLE disciplinas (
codigo			CHAR(6)		NOT NULL,
nome			VARCHAR(50)	NOT NULL,
carga_horaria	INT			NOT NULL
PRIMARY KEY (codigo)
)
GO
INSERT INTO disciplinas VALUES
('ALG001', 'Algoritmos', 80),
('ADM001', 'Administração', 80),
('LHW010', 'Laboratório de Hardware', 40),
('LPO001', 'Pesquisa Operacional', 80),
('FIS003', 'Física I', 80),
('FIS007', 'Físico Química', 80),
('CMX001', 'Comércio Exterior', 80),
('MKT002', 'Fundamentos de Marketing', 80),
('INF001', 'Informática', 40),
('ASI001', 'Sistemas de Informação', 80)
GO
CREATE TABLE disciplina_curso (
disciplinaCodigo	CHAR(6)	NOT NULL,
cursoCodigo			INT NOT NULL,
PRIMARY KEY(disciplinaCodigo, cursoCodigo),

FOREIGN KEY(disciplinaCodigo)
REFERENCES disciplinas(codigo),

FOREIGN KEY(cursoCodigo)
REFERENCES curso(codigo)
)
GO
INSERT INTO disciplina_curso VALUES
('ALG001',48),
('ADM001',48),
('ADM001',51),
('ADM001',73),
('ADM001',94),
('LHW010',48),
('LPO001',51),
('FIS003',67),
('FIS007',67),
('CMX001',51),
('CMX001',73),
('MKT002',51),
('MKT002',94),
('INF001',51),
('INF001',73),
('ASI001',48),
('ASI001',94)
GO
CREATE FUNCTION fn_info(@codigo INT)
RETURNS @tabela TABLE (
codigo_disciplina	CHAR(6),
nome_disciplina		VARCHAR(50),
carga_horaria		INT,
nome_curso			VARCHAR(50)
)
AS
BEGIN
	DECLARE @codigo_disciplina	CHAR(6),
			@nome_disciplina	VARCHAR(50),
			@carga_horaria		INT,
			@nome_curso			VARCHAR(50)
	DECLARE c CURSOR
		FOR SELECT d.codigo, d.nome, d.carga_horaria, c.nome FROM curso c INNER JOIN disciplina_curso dc
			ON c.codigo = dc.cursoCodigo
			INNER JOIN disciplinas d
			ON d.codigo = dc.disciplinaCodigo
			WHERE c.codigo = @codigo
			OPEN c
			FETCH NEXT FROM c INTO	@codigo_disciplina, 
									@nome_disciplina,
									@carga_horaria,
									@nome_curso
			WHILE @@FETCH_STATUS = 0
			BEGIN 
				INSERT INTO @tabela VALUES (@codigo_disciplina, @nome_disciplina, @carga_horaria, @nome_curso)
				FETCH NEXT FROM c INTO	@codigo_disciplina, 
										@nome_disciplina,
										@carga_horaria,
										@nome_curso
			END
			CLOSE c
			DEALLOCATE c
	RETURN
END
--exemplo para o curso de codigo 48 (Analise e Desenvolvimento de Sistemas)
SELECT * from fn_info(48)