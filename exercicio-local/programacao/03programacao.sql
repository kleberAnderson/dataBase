--03 PROGRAMAÇÃO SQL
--a) Dado um número inteiro. Calcule e mostre o seu fatorial. (Não usar entrada superior a 12)
DECLARE @var INT,
		@res INT
SET @var = 11
SET @res = 1
WHILE (@var > 1)
BEGIN
	SET @res = @res * @var
	SET @var = @var - 1
END 
PRINT (@res)

--b) Dados A, B, e C de uma equação do 2o grau da fórmula AX2+BX+C=0. Verifique e mostre a
--existência de raízes reais e se caso exista, calcule e mostre. Caso não existam, exibir mensagem.
DECLARE @valor_a FLOAT,
		@valor_b FLOAT,
		@valor_c FLOAT,
		@delta FLOAT
SET @valor_a = 1
SET @valor_b = 5
SET @valor_c = -6

SET @delta = ( ( @valor_b * @valor_b ) - ( 4 * @valor_a * @valor_c ) )
PRINT(@delta)

IF (@delta >= 0)
BEGIN
	IF (@delta > 0)
	BEGIN
		PRINT('existe duas raízes')
		DECLARE @raiz1 FLOAT,
				@raiz2 FLOAT

		SET @raiz1 = (-@valor_b + POWER(@delta, 0.5)) / (2 * @valor_a)
		SET @raiz2 = (-@valor_b - POWER(@delta, 0.5)) / (2 * @valor_a)
		PRINT(@raiz1)
		PRINT(@raiz2)
	END
	ELSE
	BEGIN
		PRINT('existe uma raíz')
	END
END
ELSE
BEGIN
	PRINT('não existe raiz')
END

--04 PROGRAMAÇÃO SQL
--b) Fazer um algoritmo que leia 3 números e mostre o maior e o menor
DECLARE @numero1 INT,
		@numero2 INT,
		@numero3 INT,

		@maior_num INT,
		@menor_num INT

SET @numero1 = 21
SET @numero2 = 1
SET @numero3 = 3

--maior número
SET @maior_num = @numero1
IF( @numero2 > @maior_num ) BEGIN SET @maior_num = @numero2 END
IF( @numero3 > @maior_num ) BEGIN SET @maior_num = @numero3 END

--menor número
SET @menor_num = @numero1
IF( @numero2 < @menor_num ) BEGIN SET @menor_num = @numero2 END
IF( @numero3 < @menor_num ) BEGIN SET @menor_num = @numero3 END

SELECT @maior_num AS maior, @menor_num AS menor