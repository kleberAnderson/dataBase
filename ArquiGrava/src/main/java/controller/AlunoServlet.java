package controller;

import jakarta.servlet.RequestDispatcher; 
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Aluno;
import model.Curso;
import persistence.AlunoDao;
import persistence.CursoDao;
import persistence.GenericDao;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/aluno")
public class AlunoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public AlunoServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String acao = request.getParameter("acao");
		String id = request.getParameter("id");
		
		Aluno a = new Aluno();
		String erro = "";
		
		List<Aluno> alunos = new ArrayList<>();
		List<Curso> cursos = new ArrayList<Curso>();
		
		try {
			if (acao != null) {
				a.setId(Integer.parseInt(id));
				
				GenericDao gDao = new GenericDao();
				
				CursoDao cDao = new CursoDao(gDao);
				AlunoDao aDao = new AlunoDao(gDao);
				cursos = cDao.listar();
				
				if (acao.equalsIgnoreCase("excluir")) {	
					aDao.excluir(a);
					alunos = aDao.listar();
					a = null;
				} else {
					a = aDao.buscar(a);
					alunos = null;
				}
			}
			
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			request.setAttribute("erro", erro);
			request.setAttribute("aluno", a);
			request.setAttribute("alunos", alunos);
			request.setAttribute("cursos", cursos);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("aluno.jsp");
			dispatcher.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String saida = "";
		String erro = "";
		
		List<Aluno> alunos = new ArrayList<Aluno>();
		List<Curso> cursos = new ArrayList<Curso>();
		
		Aluno a = new Aluno();
		String cmd = "";
		
		try {
			GenericDao gcDao = new GenericDao();
			CursoDao cDao = new CursoDao(gcDao);
			
			cursos = cDao.listar();
			request.setAttribute("cursos", cursos);
			
			String id = request.getParameter("id");
			String nome = request.getParameter("nome");
			String codigoCurso = request.getParameter("curso");	
			String nomeSocial = request.getParameter("nomeSocial");
			String nascimento = request.getParameter("nascimento");
			String telefone1 = request.getParameter("telefone1");
			String telefone2 = request.getParameter("telefone2");
			String email = request.getParameter("email");
			String dataSegundoGrau = request.getParameter("dataSegundoGrau");
			String nomeInstituicao = request.getParameter("nomeInstituicao");
			String pontuacao = request.getParameter("pontuacao");
			String posicao = request.getParameter("posicao");
			String anoIngresso = request.getParameter("anoIngresso");
			String semestreIngresso = request.getParameter("semestreIngresso");					
			String cpf = request.getParameter("cpf");
		
			cmd = request.getParameter("botao");
			
			if (!cmd.equalsIgnoreCase("Listar")) {
				a.setId(Integer.parseInt(id));
			}
			if (cmd.equalsIgnoreCase("Inserir") 
				|| 
				cmd.equalsIgnoreCase("Atualizar")) {
	
				a.setNome(nome);
				a.setCodigoCurso(Integer.parseInt(codigoCurso));
				
				a.setNomeSocial(nomeSocial);
				a.setNascimento(LocalDate.parse(nascimento));
				a.setTelefone1(telefone1);
				a.setTelefone2(telefone2);
				a.setEmail(email);
				a.setDataSegundoGrau(LocalDate.parse(dataSegundoGrau));
				a.setNomeInstituicao(nomeInstituicao);
				a.setPontuacao(Integer.parseInt(pontuacao));
				a.setPosicao(Integer.parseInt(posicao));
				a.setAnoIngresso(Integer.parseInt(anoIngresso));
				a.setSemestreIngresso(Integer.parseInt(semestreIngresso));
				a.setCpf(cpf);
			}
			
			GenericDao gDao = new GenericDao();
			AlunoDao aDao = new AlunoDao(gDao);
		
			if (cmd.equalsIgnoreCase("Inserir")) {
				saida = aDao.inserir(a);
			}
			if (cmd.equalsIgnoreCase("Atualizar")) {
				saida = aDao.atualizar(a);
			}
			if (cmd.equalsIgnoreCase("Excluir")) {
				saida = aDao.excluir(a);
			}
			if (cmd.equalsIgnoreCase("Buscar")) {
				a = aDao.buscar(a);
			}
			if (cmd.equalsIgnoreCase("Listar")) {
				alunos = aDao.listar();
			}

		} catch (SQLException | ClassNotFoundException | NumberFormatException e) {
			saida = "";
			erro = e.getMessage();
			if (erro.contains("input string")) {
				erro = "Preencha os campos corretamente";
			}
		} finally {
			
			if (!cmd.equalsIgnoreCase("Buscar")) {
				a = null;
			}
			if (!cmd.equalsIgnoreCase("Listar")) {
				alunos = null;
			}
			request.setAttribute("erro", erro);
			request.setAttribute("saida", saida);
			request.setAttribute("cursos", cursos);
			request.setAttribute("aluno", a);
			request.setAttribute("alunos", alunos);

			RequestDispatcher dispatcher = request.getRequestDispatcher("aluno.jsp");
			dispatcher.forward(request, response);
		}
	}
}
