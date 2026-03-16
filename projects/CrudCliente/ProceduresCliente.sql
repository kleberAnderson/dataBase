CREATE DATABASE spcliente
GO
USE spcliente
GO

CREATE TABLE cliente (
	cpf CHAR(11) NOT NULL,
	nome VARCHAR(100) NOT NULL,
	email VARCHAR(200),
	limite_credito DECIMAL(7,2),
	dt_nascimento DATE NOT NULL

	PRIMARY KEY(cpf)
)

ALTER PROCEDURE insert_cliente (@cod CHAR(1), @cpf CHAR(11), @nome VARCHAR(100), @email VARCHAR(200), @limite_credito DECIMAL(7,2), @dt_nascimento DATE, @saida VARCHAR(100) OUTPUT) 

AS DECLARE @valido_cpf BIT
IF(UPPER(@cod) = 'D')
BEGIN
	DELETE cliente WHERE cpf = @cpf
	SET @saida = 'Pessoa #'+CAST(@nome AS VARCHAR(100)) + ' excluida com sucesso'
END
ELSE
BEGIN
	EXEC sp_cpf @cpf, @valido_cpf OUTPUT
	IF (@valido_cpf = 1)
	BEGIN
		IF (@cod = 'I')
		BEGIN
			INSERT INTO cliente (cpf, nome, email, limite_credito, dt_nascimento)
			VALUES (@cpf, @nome, @email, @limite_credito, @dt_nascimento)
			SET @saida = @nome + ' inserida com sucesso'
		END
		ELSE
		BEGIN
			IF (@cod = 'U')
			BEGIN
				UPDATE cliente
				SET nome = @nome,
					email = @email,
					limite_credito = @limite_credito,
					dt_nascimento = @dt_nascimento
				WHERE cpf = @cpf

				SET @saida = @nome + ' atualizada com sucessso'
			END
			ELSE
			BEGIN
				RAISERROR('Operacao invalida', 16, 1)
			END
		END
	END
	ELSE
	BEGIN
		RAISERROR('Insira um cpf válido', 16, 1)
	END
END

/*excluindo procedure*/
DROP PROCEDURE sp_insert_cliente

/*Método para verificar se o cpf é valido ou não*/
CREATE PROCEDURE sp_cpf (@cpf CHAR(11), @valido BIT OUTPUT)
AS
	IF LEN(REPLACE(@cpf, SUBSTRING(@cpf, 1, 1), '')) = 0
	BEGIN
		SET @valido = 0
	END
	ELSE
	BEGIN
		SET @valido = 1
	END

/*teste da validacao do cpf*/
DECLARE @char1 BIT
EXEC sp_cpf '43063367001', @char1 OUTPUT
PRINT @char1

/*teste de insert de cliente com uso da procedure sp_cpf*/
DECLARE @char2 VARCHAR(100)
EXEC insert_cliente 'I', '11111111101', 'erro', 'erro@gmail.com', 132.20, '1992-10-21', @char2 OUTPUT
PRINT(@char2) 

/*select from*/
SELECT * FROM cliente