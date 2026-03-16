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

--a) Fazer um algoritmo que leia 1 número e mostre se são múltiplos de 2,3,5 ou nenhum deles
DECLARE @numero INT

SET @numero = 1

IF (@numero % 2 = 0)
BEGIN
	PRINT('multiplo de 2')
END
IF (@numero % 3 = 0)
BEGIN
	PRINT('multiplo de 3')
END
IF (@numero % 5 = 0)
BEGIN
	PRINT('multiplo de 5')
END
IF (@numero % 2 <> 0 AND @numero % 3 <> 0 AND @numero % 5 <> 0)
BEGIN
	PRINT('O número ' + CAST((@numero) AS VARCHAR) + ' nao é multiplo de 2, 3 e 5.')
END

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

--c) Fazer um algoritmo que calcule os 15 primeiros termos da série
--1,1,2,3,5,8,13,21,...
--E calcule a soma dos 15 termos
DECLARE @a INT,
		@b INT,
		@c INT,
		@cont INT,
		@soma INT

SET @a = 1
SET @b = 1
SET @cont = 2
SET @soma = @a + @b

PRINT(@a)
PRINT(@b)

WHILE (@cont < 15)
BEGIN
	SET @c = @a + @b
	PRINT (@c)

	SET @soma = @soma + @c

	SET @a = @b
	SET @b = @c

	SET @cont = @cont + 1
END

PRINT ('Soma dos 15 primeiros termos -> ' + CAST(@soma AS VARCHAR))

--d) Fazer um algoritmo que separa uma frase, colocando todas as letras em maiúsculo e em
--minúsculo (Usar funções UPPER e LOWER)
DECLARE @frase VARCHAR(30)

SET @frase = ('FaTeC zOnA LeSTe')

PRINT ('Maiusculo -> ' + UPPER(@frase))
PRINT ('Minusculo -> ' + LOWER(@frase))

--e) Fazer um algoritmo que inverta uma palavra (Usar a função SUBSTRING)
DECLARE @palavra VARCHAR(30)
DECLARE @palavra_invertida VARCHAR(30)
DECLARE @num_palavra INT

SET @palavra = 'FATEC ZONA LESTE'
SET @palavra_invertida = ''
SET @num_palavra = LEN(@palavra)

WHILE (@num_palavra > 0)
BEGIN
	SET @palavra_invertida = @palavra_invertida + SUBSTRING(@palavra, @num_palavra, 1)
	SET @num_palavra = @num_palavra - 1
END

PRINT('Palavra invertida -> ' + @palavra_invertida)
/*
f) Considerando a tabela abaixo, gere uma massa de dados, com 100 registros, para fins de teste
com as regras estabelecidas (Não usar constraints na criação da tabela)
Computador
ID Marca QtdRAM TipoHD QtdHD FreqCPU
INT (PK) VARCHAR(40) INT VARCHAR(10) INT DECIMAL(7,2)

• ID incremental a iniciar de 10001
• Marca segue o padrão simples, Marca 1, Marca 2, Marca 3, etc.
• QtdRAM é um número aleatório* dentre os valores permitidos (2, 4, 8, 16)
• TipoHD segue o padrão:
o Se o ID dividido por 3 der resto 0, é HDD
o Se o ID dividido por 3 der resto 1, é SSD
o Se o ID dividido por 3 der resto 2, é M2 NVME
• QtdHD segue o padrão:
o Se o TipoHD for HDD, um valor aleatório* dentre os valores permitidos (500, 1000 ou 2000)
o Se o TipoHD for SSD, um valor aleatório* dentre os valores permitidos (128, 256, 512)
• FreqHD é um número aleatório* entre 1.70 e 3.20

* Função RAND() gera números aleatórios entre 0 e 0,9999...
*/
CREATE TABLE computador (
id INT,
marca VARCHAR(30),
qtd_ram INT,
tipo_hd VARCHAR(30),
qtd_hd INT,
frq_cpu DECIMAL(7,2)
)

DECLARE @id INT,
		@contador INT,
		@marca VARCHAR(30),
		@qtdram INT,
		@tipohd VARCHAR(30),
		@qtdhd INT,
		@freqcpu DECIMAL(7,2)

SET @id = 10001
SET @contador = 1

WHILE (@contador <= 100)
BEGIN
	SET @marca = 'Marca ' + CAST(@contador AS VARCHAR)
	SET @qtdram = CASE FLOOR(RAND()  * 4)
					WHEN 0 THEN 2
					WHEN 1 THEN 4
					WHEN 2 THEN 8
					WHEN 3 THEN 16
					ELSE 16
					END
	SET @tipohd = CASE (@id % 3)
					WHEN 0 THEN 'HDD'
					WHEN 1 THEN 'SSD'
					WHEN 2 THEN 'M2 NVME'
					END
	IF (@tipohd = 'HDD')
	BEGIN
		SET @qtdhd = CASE FLOOR(RAND() * 3)
						WHEN 0 THEN 500
						WHEN 1 THEN 1000
						WHEN 2 THEN 2000
						ELSE 500
						END
	END
	ELSE
	BEGIN
		SET @qtdhd = CASE FLOOR(RAND() * 3)
						WHEN 0 THEN 128
						WHEN 1 THEN 256
						WHEN 2 THEN 512
						ELSE 128
						END
	END

	SET @freqcpu = 1.70 + (RAND() * (3.20 - 1.70))

	INSERT INTO computador VALUES(
	@id, @marca, @qtdram, @tipohd, @qtdhd, @freqcpu)

	SET @id = @id + 1
	SET @contador = @contador + 1
END

SELECT * FROM computador
