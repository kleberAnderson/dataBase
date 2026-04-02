<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>Cadastro Aluno Curso</title>
</head>
<body>
	<br />
	<div class="container" align="center">
	<h1>Cadastro de Aluno(a) e Curso</h1>
	<br />
	<form action="aluno" method="post">
		<table>
			<tr>
				<td>
					<input type="number" min="1" step="1"
					id="id" name="id" placeholder="#ID"
					value='<c:out value="${aluno.id }"/>'
					class="input-group input-group-lg" >
				</td>
				<td colspan="1">
					<input type="submit"
					id="botao" name="botao" value="Buscar"
					class="btn btn-dark">
				</td>
			</tr>
			<tr>
				<td> CPF: </td>
				<td colspan="4">
					<input type="text" 
					id="cpf" name="cpf" placeholder="000.000.000-00"
					value='<c:out value="${aluno.cpf }"/>'
					class="input-group input-group-lg">
				</td>
			</tr>
			<tr>
				<td>Nome do Aluno: </td>
				<td colspan="4">
					<input type="text" 
					id="nome" name="nome"
					value='<c:out value="${aluno.nome }"/>'
					class="input-group input-group-lg">
				</td>
				
				
			</tr>
			<tr>
				<td>Nome Social: </td>
				<td colspan="4">
					<input type="text" 
					id="nomeSocial" name="nomeSocial"
					value='<c:out value="${aluno.nomeSocial }"/>'
					class="input-group input-group-lg">
				</td>
			</tr>
			<tr>
				<td>Data de Nascimento: </td>
				<td>
					<input type="date" 
					id="nascimento" name="nascimento"
					value='<c:out value="${aluno.nascimento }"/>'
					class="input-group input-group-lg">
				</td>
			</tr>
			<tr>
				<td>Telefone 1: </td>
				<td colspan="4">
					<input type="text" 
					id="telefone1" name="telefone1" placeholder="(11) 99999-9999"
					value='<c:out value="${aluno.telefone1 }"/>'
					class="input-group input-group-lg">
				</td>
			</tr>
			<tr>
				<td>Telefone 2: </td>
				<td colspan="4">
					<input type="text" 
					id="telefone2" name="telefone2" placeholder="(11) 99999-9999"
					value='<c:out value="${aluno.telefone2 }"/>'
					class="input-group input-group-lg">
				</td>
			</tr>
			<tr>
				<td>Email: </td>
				<td colspan="4">
					<input type="text" 
					id="email" name="email" placeholder="E-mail@"
					value='<c:out value="${aluno.email }"/>'
					class="input-group input-group-lg">
				</td>
			</tr>
			<tr>
				<td>Conclusão do 2º Grau  </td>
				<td>
					<input type="date" 
					id="dataSegundoGrau" name="dataSegundoGrau"
					value='<c:out value="${aluno.dataSegundoGrau }"/>'
					class="input-group input-group-lg">
				</td>
			</tr>
			<tr>
				<td>Nome da Instituição: </td>
				<td colspan="4">
					<input type="text" 
					id="nomeInstituicao" name="nomeInstituicao"
					value='<c:out value="${aluno.nomeInstituicao }"/>'
					class="input-group input-group-lg">
				</td>
			</tr>
			<tr>
				<td>Pontuação: </td>
				<td>
					<input type="number" min="1" step="1"
					id="pontuacao" name="pontuacao"
					value='<c:out value="${aluno.pontuacao }"/>'
					class="input-group input-group-lg" >
				</td>
			</tr>
			<tr>
				<td>Posição: </td>
				<td>
					<input type="number" min="1" step="1"
					id="posicao" name="posicao"
					value='<c:out value="${aluno.posicao }"/>'
					class="input-group input-group-lg" >
				</td>
			</tr>
			<tr>
				<td>Ano de Ingresso</td>
				<td>
					<input type="number" min="1" step="1"
					id="anoIngresso" name="anoIngresso" placeholder="Ano de Ingresso"
					value='<c:out value="${aluno.anoIngresso }"/>'
					class="input-group input-group-lg" >
				</td>
				<td>Semestre de Ingresso</td>
				<td>
					<input type="number" min="1" step="1"
					id="semestreIngresso" name="semestreIngresso" placeholder="Semestre de Ingresso"
					value='<c:out value="${aluno.semestreIngresso }"/>'
					class="input-group input-group-lg" >
				</td>
			</tr>
			<tr>
				<td>RA do Aluno(a):  </td>
				<td>
					<c:out value="${aluno.ra }" />
				</td>
			</tr>
			<tr>
				<td>Ano Limite </td>
				<td>
					<c:out value="${aluno.anoLimite }" />
				</td>
				
				<td>Semestre Limite </td>
				<td>
					<c:out value="${aluno.semestreLimite }" />
				</td>
			</tr>
			<tr>
    			<td>Cursos</td>
    			<td colspan="3">
      				<select name="curso" class="form-select form-select-lg">
    				<option value="">Curso</option>
    					<c:forEach var="c" items="${cursos}">
        					<option value="${c.codigo}">${c.nome}</option>
						</c:forEach>
					</select>
    			</td>
			</tr>
			<tr>
				<td>
					<input type="submit"
					id="botao" name="botao" value="Inserir"
					class="btn btn-dark">
				</td>								
				<td>
					<input type="submit"
					id="botao" name="botao" value="Atualizar"
					class="btn btn-dark">
				</td>								
				<td>
					<input type="submit"
					id="botao" name="botao" value="Excluir"
					class="btn btn-dark">
				</td>								
				<td>
					<input type="submit"
					id="botao" name="botao" value="Listar"
					class="btn btn-dark">
				</td>
			</tr>
		</table>
	</form>
	</div>
	<br />
	<div class="conteiner" align="center">
		<c:if test="${not empty saida }">
			<h2 style="color: blue;"><c:out value="${saida }" /></h2>
		</c:if>
	</div>
	<div class="conteiner" align="center">
		<c:if test="${not empty erro }">
			<h2 style="color: red;"><c:out value="${erro }" /></h2>
		</c:if>
	</div>
	<div class="conteiner" align="center">
		<c:if test="${not empty alunos }">
			<table class="table table-dark table-striped">
				<thead>
					<tr>
						<th>RA</th>
						<th>Nome</th>
						<th>Curso</th>
						<th></th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="a" items="${alunos }">
						<tr>
							<td>${a.ra }</td>
							<td>${a.nome }</td>
							<td>${a.codigoCurso }</td>
							<td><a href="${pageContext.request.contextPath }/aluno?acao=editar&id=${a.id }">EDITAR</a></td>
							<td><a href="${pageContext.request.contextPath }/aluno?acao=excluir&id=${a.id }">EXCLUIR</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
</body>
</html>