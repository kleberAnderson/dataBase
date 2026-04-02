CREATE DATABASE aulamaven02
GO
USE aulamaven02
GO

USE master
DROP DATABASE aulamaven02

--CURSO
CREATE TABLE curso (
codigo INT	NOT NULL,
nome VARCHAR(100)	NOT NULL,
sigla	VARCHAR(100)	NOT NULL,
cargaHoraria	INT	NOT NULL,
notaEnade	INT	NOT NULL
PRIMARY KEY(codigo)
)

--ALUNO
CREATE TABLE aluno (
id INT NOT NULL,
ra INT NOT NULL,
nome VARCHAR(100) NOT NULL,
codigoCurso INT NOT NULL,

nomeSocial	VARCHAR(100),
nascimento	DATE	NOT NULL,
telefone1	VARCHAR(11),
telefone2	VARCHAR(11),
email	VARCHAR(100)	NOT NULL,
dataSegundoGrau	DATE	NOT NULL,
nomeInstituicao	VARCHAR(100)	NOT NULL,
pontuacao	INT	NOT NULL,
posicao		INT	NOT NULL,
anoIngresso	INT NOT NULL,
semestreIngresso	INT NOT NULL,
anoLimite	INT	NOT NULL,
semestreLimite	INT NOT NULL,

cpf	VARCHAR(11) NOT NULL

PRIMARY KEY(ra),
FOREIGN KEY(codigoCurso)
REFERENCES curso(codigo)
)

--CRUD CURSO
CREATE PROCEDURE sp_curso (@cod CHAR(1), @codigo INT, @nome VARCHAR(100), @sigla VARCHAR(100), @cargaHoraria INT, @notaEnade INT, @saida VARCHAR(100) OUTPUT)
AS
	IF (UPPER(@cod) = 'D' AND @codigo IS NOT NULL)
	BEGIN
		DELETE curso WHERE codigo = @codigo
		SET @saida = 'Curso de ' + @nome + ' excluida'
	END
	ELSE
	BEGIN
		IF (UPPER(@cod) = 'D' AND @codigo IS NULL)
		BEGIN
			RAISERROR('Insira um código válido', 16, 1)
		END
		IF (UPPER(@cod) = 'I')
		BEGIN
			INSERT INTO curso (codigo, nome, sigla, cargaHoraria, notaEnade) VALUES 
			(@codigo, @nome, @sigla, @cargaHoraria, @notaEnade)
			SET @saida = 'curso de ' + @nome + ' adicionado com sucesso'
		END
		ELSE
		BEGIN
			IF(UPPER(@cod) = 'U')
			BEGIN
				UPDATE curso
				SET codigo = @codigo, nome = @nome, sigla = @sigla, cargaHoraria = @cargaHoraria, notaEnade = @notaEnade WHERE codigo = @codigo
				SET @saida = @nome + ' atualizado'
			END
			ELSE
			BEGIN
				RAISERROR(' Operacao invalida', 16, 1)
			END
		END
	END

DROP TABLE aluno

--VALIDAÇÃO DE CPF
CREATE PROCEDURE sp_cpf (@cpf VARCHAR(11), @valido BIT OUTPUT)
AS
	DECLARE @soma INT,
	@resto INT,
	@contador INT,
	@digito1 INT,
	@digito2 INT

	IF (@cpf = REPLICATE(SUBSTRING(@cpf,1,1),11))
	BEGIN
		SET @valido = 0
		RETURN
	END

	SET @contador = 1
	SET @soma = 0

	WHILE @contador <= 9
	BEGIN
		SET @soma = @soma + (CAST(SUBSTRING(@cpf, @contador, 1) AS INT) * (11 - @contador))
		SET @contador = @contador + 1
	END

	SET @resto = (@soma * 10) % 11
	IF (@resto = 10 OR @resto = 11) SET @resto = 0
	SET @digito1 = @resto

	SET @contador = 1
	SET @soma = 0

	WHILE (@contador <= 10)
	BEGIN
		SET @soma = @soma + (CAST(SUBSTRING(@cpf,@contador,1) AS INT) * (12 - @contador))
        SET @contador = @contador + 1
	END

	SET @resto = (@soma * 10) % 11
	IF (@resto = 10 OR @resto = 11) SET @resto = 0
	SET @digito2 = @resto

	IF (@digito1 = CAST(SUBSTRING(@cpf, 10, 1) AS INT) 
		AND
		@digito2 = CAST(SUBSTRING(@cpf, 11, 1) AS INT))
		SET @valido = 1
	ELSE
		SET @valido = 0

--VALIDAÇÃO DE IDADE
CREATE PROCEDURE sp_idade (@nascimento DATE, @valido BIT OUTPUT)
AS
	DECLARE @idade INT
	SET @idade = DATEDIFF(YEAR, @nascimento, GETDATE())

	IF (DATEADD(YEAR, @idade, @nascimento) > GETDATE())
		SET @idade = @idade - 1
	IF(@idade >= 16)
		SET @valido = 1
	ELSE
		SET @valido = 0

--ANO E SEMESTRE LIMITE
CREATE PROCEDURE sp_limitegraducao (@anoIngresso INT, 
									@semestreIngresso INT, 
									@anoLimite INT OUTPUT,
									@semestreLimite INT OUTPUT)
AS
	DECLARE @totalSemestre INT
	SET @totalSemestre = ((@anoIngresso * 2) + @semestreIngresso) + 10
	SET @anoLimite = @totalSemestre / 2
	SET @semestreLimite = @totalSemestre % 2
	IF (@semestreLimite = 0)
	BEGIN
		SET @semestreLimite = 2
		SET @anoLimite = @anoLimite - 1
	END

--PROCEDURE PARA COLOCAR RA
CREATE PROCEDURE sp_ra(@anoIngresso INT,
						@semestreIngresso INT,
						@ra VARCHAR(9) OUTPUT)
AS
	DECLARE @random INT
	
	SET @random = FLOOR(RAND() * 9000) + 1000

	SET @ra = CAST(@anoIngresso AS VARCHAR) +
			  CAST(@semestreIngresso AS VARCHAR)+
			  CAST(@random AS VARCHAR)

--sp_aluno
alter PROCEDURE sp_aluno (@cod CHAR(1),
								@id INT,
								--@ra INT, 
								@nome VARCHAR(100), 
								@codigoCurso INT,
								
								@nomeSocial VARCHAR(100),
								@nascimento DATE,
								@telefone1 VARCHAR(11),
								@telefone2 VARCHAR(11),
								@email	VARCHAR(100),
								@dataSegundoGrau DATE,
								@nomeInstituicao VARCHAR(100),
								@pontuacao INT,
								@posicao INT,
								@anoIngresso INT,
								@semestreIngresso INT,
								--@anoLimite INT,
								--@semestreLimite	INT,

								@cpf VARCHAR(11),

								@saida VARCHAR(100) OUTPUT)

								
AS
	DECLARE @valido_cpf BIT,
			@valido_idade BIT

	IF (UPPER(@cod) = 'D' AND @id IS NOT NULL)
	BEGIN
		DELETE aluno WHERE id = @id
		SET @saida = 'Aluno ' + @nome + ' removido do sistema'
	END
	ELSE
	BEGIN
		IF (UPPER(@cod) = 'D' AND @id IS NULL)
		BEGIN
			RAISERROR('Insira um Id válido', 16, 1)
		END
		EXEC sp_cpf @cpf, @valido_cpf OUTPUT
		EXEC sp_idade @nascimento, @valido_idade OUTPUT

		IF (@valido_cpf = 1 AND @valido_idade = 1)
		BEGIN
			IF (UPPER(@cod) = 'I')
			BEGIN

				DECLARE @ra VARCHAR(9)
				EXEC sp_ra @anoIngresso, @semestreIngresso, @ra OUTPUT

				DECLARE @anoLimite INT
				DECLARE @semestreLimite	INT 
				EXEC sp_limitegraducao @anoIngresso, @semestreIngresso, @anoLimite OUTPUT, @semestreLimite OUTPUT

				INSERT INTO aluno (
							id,
							ra, 
							nome, 
							codigoCurso,

							nomeSocial,
							nascimento,
							telefone1,
							telefone2,
							email,
							dataSegundoGrau,
							nomeInstituicao,
							pontuacao,
							posicao,
							anoIngresso,
							semestreIngresso,
							anoLimite,
							semestreLimite,

							cpf) VALUES 
					(
					@id,
					@ra, 
					@nome, 
					@codigoCurso,
					@nomeSocial,
					@nascimento,
					@telefone1,
					@telefone2,
					@email,
					@dataSegundoGrau,
					@nomeInstituicao,
					@pontuacao,
					@posicao,
					@anoIngresso,
					@semestreIngresso,
					@anoLimite,
					@semestreLimite,
					@cpf
					)
					SET @saida = 'Aluno ' + @nome + ' adicionado com sucesso'
			END
			ELSE
			BEGIN
				IF(UPPER(@cod) = 'U')
				BEGIN

				EXEC sp_limitegraducao @anoIngresso, @semestreIngresso, @anoLimite OUTPUT, @semestreLimite OUTPUT

							UPDATE aluno
							SET id = @id, 
							nome = @nome, 
							codigoCurso = @codigoCurso, 

							nomeSocial = @nomeSocial,
							nascimento = @nascimento,
							telefone1 = @telefone1,
							telefone2 = @telefone2,
							email = @email,
							dataSegundoGrau = @dataSegundoGrau,
							nomeInstituicao = @nomeInstituicao,
							pontuacao = @pontuacao,
							posicao = @posicao,
							anoIngresso = @anoIngresso,
							semestreIngresso = @semestreIngresso,
							anoLimite = @anoLimite,
							semestreLimite = @semestreLimite,
							
							cpf = @cpf 
				
							WHERE id = @id
							SET @saida = 'Aluno(a) ' + @nome + ' atualizado com sucesso'
				END
				ELSE
				BEGIN
						RAISERROR(' Operacao invalida', 16, 1)
				END
			END
		END
		ELSE
		BEGIN
			IF (@valido_cpf = 0 AND @valido_idade = 1)
			BEGIN
				RAISERROR('Insira um CPF válido', 16, 1)
			END
			ELSE
				BEGIN
				IF(@valido_cpf = 1 AND @valido_idade = 0)
				BEGIN
					RAISERROR('Aluno com menos de 16 anos', 16, 1)		
				END
				ELSE
					BEGIN
						IF (@valido_cpf = 0 AND @valido_idade = 0)
						BEGIN
							RAISERROR('CPF e idade inválido', 16, 1)
						END
					END
			END
				--RAISERROR('CPF e idade inválido', 16, 1)
			END
		END

--CURSO
CREATE TABLE curso (
codigo INT	NOT NULL,
nome VARCHAR(100)	NOT NULL,
sigla	VARCHAR(100)	NOT NULL,
cargaHoraria	INT	NOT NULL,
notaEnade	INT	NOT NULL
PRIMARY KEY(codigo)
)


--Testing sp_curso
DECLARE @saida3 VARCHAR(100)
EXEC sp_curso 'I', 1, 'Analise e Desenv', 'ADS', 1000, 100, @saida3 OUTPUT
PRINT @saida3

--Testing INSERT sp_aluno
DECLARE @saida1 VARCHAR(100)
EXEC sp_aluno 'I', 
				76, 
				'Jose Fer', 
				1,
				'F', 
				'2000-12-02', 
				'11983292232', 
				'11983293333', 
				'felipe@gmail.com', 
				'2019-11-21', 
				'Escola Julio', 
				100, 
				2, 
				2024, 
				1,
				'38991945007', 
				@saida1 OUTPUT
PRINT @saida1

--Testing sp_idade
DECLARE @saida1 VARCHAR(100)
EXEC sp_idade '2003-11-21', @saida1 OUTPUT
PRINT @saida1

--Testing sp_limitegraducao
DECLARE @ano INT
DECLARE @semestre INT
EXEC sp_limitegraducao 2023, 1, @ano OUTPUT, @semestre OUTPUT
PRINT @ano 
PRINT @semestre

--testing sp_ra
DECLARE @ra VARCHAR(9)
EXEC sp_ra 2024, 1, @ra OUTPUT
PRINT @ra

select * from aluno
select * from curso


