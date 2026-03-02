CREATE DATABASE ex9
GO
USE ex9
GO
CREATE TABLE editora (
codigo INT NOT NULL,
nome VARCHAR(30) NOT NULL,
site VARCHAR(40) NULL
PRIMARY KEY (codigo)
)
GO
CREATE TABLE autor (
codigo INT NOT NULL,
nome VARCHAR(30) NOT NULL,
biografia VARCHAR(100) NOT NULL
PRIMARY KEY (codigo)
)
GO
CREATE TABLE estoque (
codigo INT NOT NULL,
nome VARCHAR(100) NOT NULL UNIQUE,
quantidade INT NOT NULL,
valor DECIMAL(7,2) NOT NULL CHECK(valor > 0.00),
codEditora INT NOT NULL,
codAutor INT NOT NULL
PRIMARY KEY (codigo)
FOREIGN KEY (codEditora) REFERENCES editora (codigo),
FOREIGN KEY (codAutor) REFERENCES autor (codigo)
)
GO
CREATE TABLE compra (
codigo INT NOT NULL,
codEstoque INT NOT NULL,
qtdComprada INT NOT NULL,
valor DECIMAL(7,2) NOT NULL,
dataCompra DATE NOT NULL
PRIMARY KEY (codigo, codEstoque, dataCompra)
FOREIGN KEY (codEstoque) REFERENCES estoque (codigo)
)
GO
INSERT INTO editora VALUES
(1,'Pearson','www.pearson.com.br'),
(2,'Civilização Brasileira',NULL),
(3,'Makron Books','www.mbooks.com.br'),
(4,'LTC','www.ltceditora.com.br'),
(5,'Atual','www.atualeditora.com.br'),
(6,'Moderna','www.moderna.com.br')
GO
INSERT INTO autor VALUES
(101,'Andrew Tannenbaun','Desenvolvedor do Minix'),
(102,'Fernando Henrique Cardoso','Ex-Presidente do Brasil'),
(103,'Diva Marilia Flemming','Professora adjunta da UFSC'),
(104,'David Halliday','Ph.D. da University of Pittsburgh'),
(105,'Alfredo Steinbruch','Professor de Matematica da UFRS e da
PUCRS'),
(106,'Willian Roberto Cereja','Doutorado em Linguistica Aplicada e
Estudos da Linguagem'),
(107,'William Stallings','Doutorado em Ciencias da Computacão pelo
MIT'),
(108,'Carlos Morimoto','Criador do Kurumin Linux')
GO
INSERT INTO estoque VALUES
(10001,'Sistemas Operacionais Modernos ',4,108.00,1,101),
(10002,'A Arte da Política',2,55.00,2,102),
(10003,'Calculo A',12,79.00,3,103),
(10004,'Fundamentos de Fisica I',26,68.00,4,104),
(10005,'Geometria Analitica',1,95.00,3,105),
(10006,'Gramática Reflexiva',10,49.00,5,106),
(10007,'Fundamentos de Fisica III',1,78.00,4,104),
(10008,'Calculo B',3,95.00,3,103)
GO
INSERT INTO compra VALUES
(15051,10003,2,158.00,'04/07/2024'),
(15051,10008,1,95.00,'04/07/2024'),
(15051,10004,1,68.00,'04/07/2024'),
(15051,10007,1,78.00,'04/07/2024'),
(15052,10006,1,49.00,'05/07/2024'),
(15052,10002,3,165.00,'05/07/2024'),
(15053,10001,1,108.00,'05/07/2024'),
(15054,10003,1,79.00,'06/08/2024'),
(15054,10008,1,95.00,'06/08/2024')

--Exercício SQL
--Pede-se:
--1) Consultar nome, valor unitário, nome da editora e nome do autor dos livros do
--estoque que foram vendidos. Não pode haver repetições.
GO
SELECT DISTINCT ed.nome, es.valor, ed.nome, at.nome
FROM autor at INNER JOIN estoque es
ON at.codigo = es.codAutor
INNER JOIN editora ed
ON ed.codigo = es.codEditora
INNER JOIN compra cp
ON cp.codEstoque = es.codigo

--2) Consultar nome do livro, quantidade comprada e valor de compra da compra 15051
GO
SELECT es.nome AS nome_livro, es.quantidade, co.valor AS valor_compra
FROM estoque es INNER JOIN compra co
ON es.codigo = co.codEstoque
WHERE co.codigo = 15051

--3) Consultar Nome do livro e site da editora dos livros da Makron books (Caso o site 
--tenha mais de 10 dígitos, remover o www.).
GO
SELECT es.nome, 
	CASE WHEN (LEN(ed.site) > 10)
		THEN SUBSTRING(ed.site, 5, 40)
		ELSE ed.site
		END AS site
FROM editora ed INNER JOIN estoque es
ON ed.codigo = es.codEditora
WHERE ed.nome = 'Makron Books'

--4) Consultar nome do livro e Breve Biografia do David Halliday
SELECT es.nome AS nome_livro, au.biografia
FROM autor au INNER JOIN estoque es
ON au.codigo = es.codAutor
WHERE au.nome = 'David Halliday'

--5) Consultar código de compra e quantidade comprada do livro Sistemas Operacionais
--Modernos
GO
SELECT co.codigo, co.qtdComprada
FROM estoque es INNER JOIN compra co
ON es.codigo = co.codEstoque
WHERE es.nome = 'Sistemas Operacionais Modernos'

--6) Consultar quais livros não foram vendidos
GO
SELECT es.nome AS livro_nao_Vend
FROM estoque es LEFT OUTER JOIN compra co
ON es.codigo = co.codEstoque
WHERE co.codEstoque IS NULL

--7) Consultar quais livros foram vendidos e não estão cadastrados. Caso o nome dos
--livros termine com espaço, fazer o trim apropriado.
--GO
--SELECT *
--FROM 

--8) Consultar Nome e site da editora que não tem Livros no estoque (Caso o site tenha
--mais de 10 dígitos, remover o www.)
GO 
SELECT ed.nome,
	CASE WHEN (LEN(ed.site) > 10)
		THEN SUBSTRING(ed.site, 5, 40)
		ELSE ed.site
		END AS site
FROM editora ed LEFT OUTER JOIN estoque es
ON ed.codigo = es.codEditora
WHERE es.codigo IS NULL

--9) Consultar Nome e biografia do autor que não tem Livros no estoque (Caso a
--biografia inicie com Doutorado, substituir por Ph.D.)
GO
SELECT au.nome,
	CASE WHEN au.biografia LIKE 'Doutorado%'
		THEN 'Ph.D.' + SUBSTRING(au.biografia, 10, 100)
		ELSE au.biografia
		END AS biografia
FROM autor au LEFT OUTER JOIN estoque es
ON au.codigo = es.codAutor
WHERE es.codigo IS NULL

--10) Consultar o nome do Autor, e o maior valor de Livro no estoque. Ordenar por valor
--descendente
GO
SELECT au.nome, MAX(es.valor)
FROM autor au INNER JOIN estoque es
ON au.codigo = es.codAutor
GROUP BY au.nome
ORDER BY MAX(es.valor) DESC

--11) Consultar o código da compra, o total de livros comprados e a soma dos valores
--gastos. Ordenar por Código da Compra ascendente.
GO
SELECT co.codigo, COUNT(co.qtdComprada), SUM(co.valor) AS valor_gasto 
FROM compra co
GROUP BY co.codigo
ORDER BY co.codigo DESC

--12) Consultar o nome da editora e a média de preços dos livros em estoque. Ordenar
--pela Média de Valores ascendente.
GO
SELECT ed.nome, CAST(AVG(es.valor) AS DECIMAL(4,1)) AS media_preco
FROM editora ed INNER JOIN estoque es
ON ed.codigo = es.codEditora
GROUP BY ed.nome
ORDER BY media_preco ASC

--13) Consultar o nome do Livro, a quantidade em estoque o nome da editora, o site da
--editora (Caso o site tenha mais de 10 dígitos, remover o www.), criar uma coluna
--status onde:
--Caso tenha menos de 5 livros em estoque, escrever Produto em Ponto de Pedido
--Caso tenha entre 5 e 10 livros em estoque, escrever Produto Acabando
--Caso tenha mais de 10 livros em estoque, escrever Estoque Suficiente
--A Ordena��o deve ser por Quantidade ascendente


--14) Para montar um relatório, é necessário montar uma consulta com a seguinte saída:
--Código do Livro, Nome do Livro, Nome do Autor, Info Editora (Nome da Editora + Site)
--de todos os livros
--Só pode concatenar sites que não são nulos
GO
SELECT CAST(es.codigo AS varchar(5)) + ', ' + es.nome AS info_livro,
au.nome AS nome_autor, ed.nome + ' ' + ed.site AS info_edit
FROM autor au INNER JOIN estoque es
ON au.codigo = es.codAutor
INNER JOIN editora ed
ON ed.codigo = es.codEditora

--15) Consultar Codigo da compra, quantos dias da compra até hoje e quantos meses da
--compra até hoje
GO
SELECT cp.codigo, DATEDIFF(DAY, cp.dataCompra, GETDATE()) AS dias,
				DATEDIFF(MONTH, cp.dataCompra, GETDATE()) AS mes
FROM compra cp 

--16) Consultar o código da compra e a soma dos valores gastos das compras que somam
--mais de 200.00
GO
SELECT co.codigo, SUM(co.valor) AS valor_gasto
FROM compra co
GROUP BY co.codigo
HAVING SUM(co.valor) > 200.0