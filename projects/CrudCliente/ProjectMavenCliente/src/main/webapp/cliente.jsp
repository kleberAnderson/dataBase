<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cliente</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>

</head>
<body>
	<br />
	<div class="centeiner" align="center">
		<h1>Cadastro de Cliente</h1>
		<br />
		<form action="cliente" method="post">
			<table>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="3"><input type="text" name="cpf" id="cpf"
						placeholder="CPF" value='<c:out value="${cliente.cpf}" />'></td>
					<td><input type="submit" id="botao" name="botao"
						value="Buscar" class="btn btn-dark"></td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4"><input type="text" name="nome" id="nome"
						placeholder="Nome" value='<c:out value="${cliente.nome}" />'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4"><input type="date" name="nascimento"
						id="nascimento" value='<c:out value="${cliente.dt_nascimento}" />'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4"><input type="text" name="email" id="email"
						placeholder="E-mail" value='<c:out value="${cliente.email}" />'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4"><input type="number" name="lmtcredito"
						id="lmtcredito" step="0.01" required placeholder="Limite de Crédito"
						value='<c:out value="${cliente.limite_credito}" />'></td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td><input style="margin: 0 2px;" type="submit" id="botao" name="botao"
						value="Inserir" class="btn btn-dark"></td>
					<td><input style="margin: 0 2px;" type="submit" id="botao" name="botao"
						value="Atualizar" class="btn btn-dark"></td>
					<td><input style="margin: 0 2px;" type="submit" id="botao" name="botao"
						value="Excluir" class="btn btn-dark"></td>
					<td><input style="margin: 0 2px;" type="submit" id="botao" name="botao"
						value="Listar" class="btn btn-dark"></td>
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
		<c:if test="${not empty clientes }">
			<table class="table table-dark table-striped-columns">
				<thead>
					<tr>
						<th>CPF</th>
						<th>Nome</th>
						<th>Data de Nascimento</th>
						<th>E-mail</th>
						<th>Limite de Credito</th>
						<th></th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="c" items="${clientes }">
						<tr>
							<td>${c.cpf }</td>
							<td>${c.nome }</td>
							<td>${c.dt_nascimento }</td>
							<td>${c.email }</td>
							<td>${c.limite_credito }</td>
							<td><a href="${pageContext.request.contextPath }/cliente?acao=editar&cpf=${c.cpf}">EDITAR</a></td>
							<td><a href="${pageContext.request.contextPath }/cliente?acao=excluir&cpf=${c.cpf}">EDITAR</a></td>
							
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
	
</body>
</html>