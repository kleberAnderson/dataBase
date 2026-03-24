CREATE DATABASE udf_aula
GO
USE udf_aula

CREATE TABLE funcionario (
codigo	INT,
nome	VARCHAR(30),
salario	DECIMAL(7,2)

PRIMARY KEY(codigo)
)

CREATE TABLE dependente (
codigo_dep	INT,
codigo_fun	INT,
nome_dep	VARCHAR(30),
salario_dep	DECIMAL(7,2)
 
PRIMARY KEY(codigo_dep),

FOREIGN KEY(codigo_fun)
REFERENCES funcionario(codigo)
)

INSERT INTO funcionario (codigo, nome, salario) VALUES
(1, 'joao', 1600.00),
(2, 'ana', 1800.00),
(3, 'paulo', 2500.00)

INSERT INTO dependente (codigo_dep, codigo_fun, nome_dep, salario_dep) VALUES
(1, 2, 'junior', 1700.00)
(2, 2, 'maria', 300.00)

SELECT * FROM funcionario
SELECT * FROM dependente

/*
a)Uma Function que Retorne uma tabela:
(Nome_Funcionário, Nome_Dependente, Salário_Funcionário, Salário_Dependente)
*/
CREATE FUNCTION fn_tabela_funcionario_dependente()
RETURNS @tabela TABLE (
nome_func	VARCHAR(30)	NULL,
nome_dep	VARCHAR(30)	NULL,
salario_func	DECIMAL(7,2)	NULL,
salario_dep	DECIMAL(7,2)	NULL
)
AS
BEGIN
	INSERT INTO @tabela (nome_func, nome_dep, salario_func, salario_dep)

		SELECT  f.nome, d.nome_dep, f.salario, d.salario_dep
		FROM funcionario f INNER JOIN dependente d
		ON f.codigo = d.codigo_fun
		RETURN
END

SELECT * FROM fn_tabela_funcionario_dependente()

/*
b) Uma Scalar Function que Retorne a soma dos Salários dos
dependentes, mais a do funcionário.
*/
CREATE FUNCTION fn_soma_salario_dependentes(@codigo_fun INT)
RETURNS DECIMAL(7,2)
AS
BEGIN
	DECLARE @sal_total DECIMAL(7, 2),
		@sal_fun DECIMAL(7, 2),
		@sal_dep DECIMAL(7, 2)

		SET @sal_fun = (SELECT salario FROM funcionario WHERE codigo = @codigo_fun)
		SET @sal_dep = (SELECT SUM(d.salario_dep) FROM funcionario f INNER JOIN dependente d
						ON f.codigo = d.codigo_fun)

		SET @sal_total = @sal_fun + @sal_dep
		RETURN @sal_total
END

SELECT dbo.fn_soma_salario_dependentes(2) AS valor_total


--2. Fazer uma Function que retorne

/*
a) a partir da tabela Produtos (codigo, nome, valor unitário e qtd estoque), quantos produtos
estão com estoque abaixo de um valor de entrada
*/
CREATE TABLE produtos (
	codigo	INT,
	nome	VARCHAR(30),
	valor_unit	DECIMAL(7, 2),
	qtd_estoque	INT
)

INSERT INTO produtos (codigo, nome, valor_unit, qtd_estoque) VALUES
(1, 'mouse', 35.00, 5),
(2, 'teclado', 40.00, 10),
(3, 'monitor', 200.00, 5),
(4, 'processador', 800.00, 1)

--valor de estoque mínimo de 5 uinidades
CREATE FUNCTION fn_qtd_baixo_estoque (@valor INT)
RETURNS INT
AS
BEGIN
	DECLARE @qtd_produto INT

	SET @qtd_produto = (SELECT COUNT(codigo) FROM produtos WHERE qtd_estoque < @valor GROUP BY codigo)

	RETURN @qtd_produto

END

SELECT dbo.fn_qtd_baixo_estoque(5) AS qtd_estoque_baixo

/*
b) Uma tabela com o código, o nome e a quantidade dos produtos que estão com o estoque
abaixo de um valor de entrada
*/
CREATE FUNCTION fn_tabela_produto(@valor INT)
RETURNS @tabela TABLE (
codigo	INT,
nome	VARCHAR(30)	NULL,
qtd_estoque	INT
)
AS
BEGIN
	INSERT INTO @tabela (codigo, nome, qtd_estoque)

		SELECT  p.codigo, p.nome, p.qtd_estoque
		FROM produtos p
		WHERE P.qtd_estoque < @valor
	RETURN
END

SELECT * FROM fn_tabela_produto(5)

/*
3. Criar, uma UDF, que baseada nas tabelas abaixo, retorne
Nome do Cliente, Nome do Produto, Quantidade e Valor Total, Data de hoje
Tabelas iniciais:
Cliente (Codigo, nome)
Produto (Codigo, nome, valor)
*/
CREATE TABLE cliente (
	codigo	INT,
	nome	VARCHAR(30)
	
	PRIMARY KEY(codigo)
)
GO
CREATE TABLE produto (
	codigo	INT,
	nome	VARCHAR(30),
	valor	DECIMAL(7, 2)

	PRIMARY KEY(codigo)
)
GO
CREATE TABLE cliente_produto (
	clienteCodigo	INT,
	produtoCodigo	INT,

	PRIMARY KEY(clienteCodigo, produtoCodigo),

	FOREIGN KEY(clienteCodigo)
	REFERENCES cliente(codigo),

	FOREIGN KEY(produtoCodigo)
	REFERENCES produto(codigo)
)
GO
INSERT INTO cliente (codigo, nome) VALUES
(1, 'sandra'),
(2, 'paula'),
(3, 'Ryan')
GO
INSERT INTO produto (codigo, nome, valor) VALUES
(1, 'teclado', 30.50),
(2, 'mouse', 30.00),
(3, 'monitor', 100.00)
GO
INSERT INTO cliente_produto (clienteCodigo, produtoCodigo) VALUES
(1, 2),
(1, 3),
(2, 3)
GO
CREATE FUNCTION fn_tabela_cliente_prod()
RETURNS @tabela TABLE (
nome_cliente	VARCHAR(30),
nome_produto	VARCHAR(30),
quantidade		INT,
valor_total	DECIMAL(7, 2),
data_registrado	DATE
)
AS
BEGIN
	INSERT INTO @tabela(nome_cliente, nome_produto, quantidade, valor_total, data_registrado)
	SELECT  c.nome, p.nome, COUNT(p.codigo), SUM(p.valor), GETDATE()
		FROM cliente c 
		INNER JOIN cliente_produto clientp
		ON c.codigo = clientp.clienteCodigo
		INNER JOIN produto p
		ON clientp.produtoCodigo = p.codigo
		GROUP BY c.nome, p.nome, p.codigo
		RETURN

END

SELECT * FROM fn_tabela_cliente_prod()