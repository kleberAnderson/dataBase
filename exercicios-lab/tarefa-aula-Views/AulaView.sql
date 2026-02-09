CREATE DATABASE aula0revisao
GO
USE aula0revisao
 
CREATE TABLE alunos(
ra INT NOT NULL,
nome VARCHAR(100) NOT NULL,
idade INT NOT NULL
PRIMARY KEY (RA))
 
CREATE TABLE disciplinas(
codigo INT NOT NULL,
nome VARCHAR(200) NOT NULL,
carga_horaria INT NOT NULL
PRIMARY KEY (codigo))
 
CREATE TABLE professor(
registro INT NOT NULL,
nome VARCHAR(100) NOT NULL,
titulacao VARCHAR(30) NOT NULL
PRIMARY KEY (registro))
 
CREATE TABLE curso(
codigo INT NOT NULL,
nome VARCHAR(100) NOT NULL,
area VARCHAR(50) NOT NULL
PRIMARY KEY (codigo))
 
CREATE TABLE aluno_disciplina(
codigo_disciplina INT NOT NULL,
ra_aluno INT NOT NULL
PRIMARY KEY (codigo_disciplina, ra_aluno)
FOREIGN KEY (codigo_disciplina) REFERENCES disciplinas (codigo),
FOREIGN KEY (ra_aluno) REFERENCES alunos (ra))
 
CREATE TABLE disciplina_professor(
codigo_disciplina INT NOT NULL,
registro_professor INT NOT NULL
PRIMARY KEY (codigo_disciplina, registro_professor)
FOREIGN KEY (codigo_disciplina) REFERENCES disciplinas(codigo),
FOREIGN KEY (registro_professor) REFERENCES professor(registro))
 
CREATE TABLE disciplina_curso(
codigo_disciplina INT NOT NULL,
codigo_curso INT NOT NULL
PRIMARY KEY (codigo_disciplina, codigo_curso)
FOREIGN KEY (codigo_disciplina) REFERENCES disciplinas(codigo),
FOREIGN KEY (codigo_curso) REFERENCES curso(codigo))
 
-- Fazer as queries e criar views para todas:

-- Como fazer as listas de chamadas, com RA e nome por disciplina ?	
CREATE VIEW lista_chamada_view AS
SELECT d.nome AS disciplina, a.ra AS ra_aluno, a.nome as nome_aluno
FROM alunos a
JOIN aluno_disciplina ad
ON a.ra = ad.ra_aluno
JOIN disciplinas d
ON ad.codigo_disciplina = d.codigo;
										
-- Fazer uma pesquisa que liste o nome das disciplinas e o nome dos professores que as ministram	
CREATE VIEW lista_disciplina_professor AS
SELECT d.nome AS disciplina, p.nome AS professor
FROM disciplinas d
JOIN disciplina_professor dp
ON d.codigo = dp.codigo_disciplina
JOIN professor p
ON dp.registro_professor = p.registro;

-- Fazer uma pesquisa que , dado o nome de uma disciplina, retorne o nome do curso
CREATE VIEW lista_nome_curso AS
SELECT d.nome AS disciplina, c.nome AS curso
FROM disciplinas d
JOIN disciplina_curso dc
ON d.codigo = dc.codigo_disciplina
JOIN curso c
ON dc.codigo_curso = c.codigo;	
												
-- Fazer uma pesquisa que , dado o nome de uma disciplina, retorne sua área				
CREATE VIEW lista_nome_curso AS
SELECT d.nome AS disciplina, c.area AS area_curso
FROM disciplinas d
JOIN disciplina_curso dc
ON d.codigo = dc.codigo_disciplina
JOIN curso c
ON dc.codigo_curso = c.codigo;

-- Fazer uma pesquisa que , dado o nome de uma disciplina, retorne o título do professor que a ministra
CREATE VIEW titulo_professor AS
SELECT d.nome AS disciplina, p.nome AS professor_adm, p.titulacao AS titulo_professor 
FROM disciplinas d
JOIN disciplina_professor dp
ON d.codigo = dp.codigo_disciplina
JOIN professor p
ON dp.registro_professor = p.registro;
 
-- Fazer uma pesquisa que retorne o nome da disciplina e quantos alunos est o matriculados em cada uma delas
CREATE VIEW qtde_alunos_disciplina AS
SELECT d.nome
FROM disciplinas d
JOIN aluno_disciplina ad
ON d.codigo = ad.codigo_disciplina
GROUP BY d.nome;
 
-- Fazer uma pesquisa que, dado o nome de uma disciplina, retorne o nome do professor.  
 
-- Só deve retornar de disciplinas que tenham, no mínimo, 5 alunos matriculados