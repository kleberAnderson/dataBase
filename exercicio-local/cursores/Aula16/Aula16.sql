CREATE DATABASE cursoresAula16
GO
USE cursoresAula16
GO
CREATE TABLE Vendedor (
id_vendedor			INT				NOT NULL,
nome				VARCHAR(100)	NOT NULL,
total_vendas_ano	DECIMAL(7,2)	NOT NULL,
categoria			VARCHAR(20)		NOT NULL,
PRIMARY KEY (id_vendedor)
)
GO
CREATE TABLE Historico_Bonus (
id_bonus			INT				NOT NULL,
id_vendedor			INT				NOT NULL,
valor_bonus			DECIMAL(7,2)	NOT NULL,
data_processamento	DATE			NOT NULL
PRIMARY KEY (id_bonus)

FOREIGN KEY (id_vendedor) 
REFERENCES Vendedor(id_vendedor)
)
GO
CREATE PROCEDURE sp_insert_vendedor
AS
	DECLARE @indice	INT,
			@nome	VARCHAR(100),
			@vendas	DECIMAL(7,2),
			@categoria	VARCHAR(20)
	
	SET @indice = (SELECT ISNULL(MAX(id_vendedor), 0) + 1 FROM Vendedor)
	WHILE @indice <= 45
	BEGIN
		IF @indice <= 15
			BEGIN
				SET @categoria = 'Junior'
				SET @vendas = CAST((RAND() * 30000 + 20000) AS DECIMAL(7,2))
			END
			ELSE IF @indice <= 30
			BEGIN
				SET @categoria = 'Pleno'
				SET @vendas = CAST((RAND() * 40000 + 80000) AS DECIMAL(7,2))
			END
			ELSE
			BEGIN
				SET @categoria = 'Senior'
				SET @vendas = CAST((RAND() * 170000 + 80000) AS DECIMAL(7,2))
			END

			SET @nome = @categoria + ' Vendedor ' + CAST(@indice AS VARCHAR(10))
			
			INSERT INTO Vendedor (id_vendedor, nome, total_vendas_ano, categoria)
			VALUES(@indice, @nome, @vendas, @categoria)
			SET @indice = @indice + 1
		END
GO
CREATE PROCEDURE sp_Bonus
AS
	DECLARE @id_vendedor		INT,
			@total_vendas_ano	DECIMAL(7, 2),
			@categoria			VARCHAR(20),
			@valor_bonus		DECIMAL(7,2),
			@proximo_id_bonus	INT

	DECLARE c CURSOR FOR
		SELECT id_vendedor, total_vendas_ano, categoria 
		FROM Vendedor

	OPEN c

	FETCH NEXT FROM c
	INTO @id_vendedor, @total_vendas_ano, @categoria

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @valor_bonus =
		CASE @categoria
			WHEN 'Senior' THEN @total_vendas_ano * 0.15
			WHEN 'Pleno' THEN @total_vendas_ano * 0.10
			WHEN 'Junior' THEN @total_vendas_ano * 0.05
			ELSE 0
		END

		SET @proximo_id_bonus = (SELECT ISNULL(MAX(id_bonus), 0) + 1 FROM Historico_Bonus)
		INSERT INTO Historico_Bonus (id_bonus, id_vendedor, valor_bonus, data_processamento)
		VALUES (@proximo_id_bonus, @id_vendedor, @valor_bonus, GETDATE())

		FETCH NEXT FROM c
		INTO @id_vendedor, @total_vendas_ano, @categoria
	END
	CLOSE c
	DEALLOCATE c

	--EXECUTANDO PROCEDURES

--Populando 45 novos registros
exec sp_insert_vendedor

--Realizando calculo de bonus
exec sp_Bonus

select * from Historico_Bonus
