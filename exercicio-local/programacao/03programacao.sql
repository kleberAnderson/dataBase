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
SET @valor_c = 6

SET @delta = ( ( @valor_b * @valor_b ) - ( 4 * @valor_a * @valor_c ) )

IF (@delta >= 0)
BEGIN
	IF (@delta > 0)
	BEGIN
		PRINT('existe duas raízes')
		DECLARE @raiz1 FLOAT,
				@raiz2 FLOAT
		PRINT ('1ª raiz -> ' + CAST( (-@valor_b + POWER(@delta, 0.5)) / (2 * @valor_a) AS VARCHAR) )
		PRINT ('2º raiz -> ' + CAST( (-@valor_b - POWER(@delta, 0.5)) / (2 * @valor_a) AS VARCHAR) )
	END
	ELSE
	BEGIN
		PRINT('existe uma raíz')
		PRINT ('1ª raiz -> ' + CAST(-@valor_b / (2 * @valor_a) AS VARCHAR) )
	END
END
ELSE
BEGIN
	PRINT('não existe raiz')
END

--c) Calcule e mostre quantos anos serão necessários para que Ana seja maior que Maria sabendo
--que Ana tem 1,10 m e cresce 3 cm ao ano e Maria tem 1,5 m e cresce 2 cm ao ano.
DECLARE @altura_maria FLOAT,
		@altura_ana	FLOAT,
		@anos INT

SET @altura_ana = 1.1
SET @altura_maria = 1.5
SET @anos = 0

WHILE (@altura_ana < @altura_maria)
BEGIN
		SET @altura_maria = @altura_maria + 0.02
		SET @altura_ana = @altura_ana + 0.03
		SET @anos = @anos + 1
END
PRINT(@anos)

--d) Seja a seguinte série: 1, 4, 4, 2, 5, 5, 3, 6, 6, 4, 7, 7, ...
--Escreva uma aplicação que a escreva N termos
DECLARE @num_termo INT,
		@var_inicio INT,
		@var_valor INT

SET @num_termo = 12
SET @var_inicio = 0
SET @var_valor = 3

WHILE (@var_inicio < @num_termo)
BEGIN
	IF (@var_inicio % 3 = 0)
	BEGIN
		PRINT( (@var_inicio / 3) + 1 )
		SET @var_valor = @var_valor + 1
	END
	ELSE
	BEGIN
		PRINT(@var_valor)
	END
		SET @var_inicio = @var_inicio + 1
END

--e) Considerando a tabela abaixo, gere uma database, a tabela e crie um algoritmo para inserir
--uma massa de dados, com 50 registros, para fins de teste, com as regras estabelecidas (Não
--usar constraints na criação da tabela)
--Produto
--Codigo Nome Valor Vencimento
--INT (PK) VARCHAR(30) DECIMAL(7,2) DATE

--• Código inicia em 50001 e incrementa de 1 em 1
--• Nome segue padrão simples: Produto 1, Produto 2, Produto 3, etc.
--• Valor, gerar um número aleatório* entre 10.00 e 100.00
--• Vencimento, gerar um número aleatório* entre 3 e 7 e, usando a função específica para
--soma de datas no SQL Server, somar o valor gerado à data de hoje.

--* Função RAND() gera números aleatórios entre 0 e 0,9999...
CREATE DATABASE loja
GO
USE loja

CREATE TABLE produto (
	codigo INT,
	nome VARCHAR(30),
	valor DECIMAL(7,2),
	vencimento DATE
)

DECLARE @codigo INT,
		@contador INT,
		@valor DECIMAL(7,2),
		@dias INT

SET @codigo = 50001
SET @contador = 1

WHILE (@contador <= 50)
BEGIN
	SET @valor = CAST(( (RAND() * 90) + 10) AS INT)
	SET @dias = CAST(((RAND() * 5) + 3 ) AS INT)
	
	INSERT INTO produto VALUES (
	@codigo, 
	'produto ' + CAST(@contador AS VARCHAR), 
	@valor, 
	DATEADD(DAY, @dias, GETDATE())
	)

	SET @codigo = @codigo + 1
	SET @contador = @contador + 1
END

select * from produto

--f) Considerando a tabela abaixo, gere uma database, a tabela e crie um algoritmo para inserir
--uma massa de dados, com 50 registros, para fins de teste, com as regras estabelecidas (Não
--usar constraints na criação da tabela)
--Livro
--ID Título Qtd_Páginas Qtd_Estoque
--INT (PK) VARCHAR(30) INT INT
--• Código inicia em 981101 e incrementa de 1 em 1
--• Título segue padrão simples: Livro 981101, Livro 981102, Livro 981103, etc.
--• Qtd_paginas deve ser um número aleatório entre 100 e 400
--• Qtd_Estoque deve ser um número aleatório entre 2 e 20
CREATE DATABASE livraria
GO
USE livraria

CREATE TABLE livro (
	id INT,
	titulo VARCHAR(30),
	qtd_paginas INT,
	qtd_estoque INT
)

DECLARE @contador INT,
		@codigo INT,
		@qtd_paginas_livro INT,
		@qtd_estoque_livro INT

SET @codigo = 981101
SET @contador = 1

WHILE (@contador <= 50)
BEGIN
	SET @qtd_paginas_livro = CAST( ( (RAND() * 300) + 100 ) AS INT)
	SET @qtd_estoque_livro = CAST( ( (RAND() * 19) + 2 ) AS INT)

	INSERT INTO livro VALUES (
	@codigo,
	'Livro ' + CAST( @codigo AS VARCHAR ),
	@qtd_paginas_livro,
	@qtd_estoque_livro
	)

	SET @codigo = @codigo + 1
	SET @contador = @contador + 1
END

SELECT * FROM livro

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