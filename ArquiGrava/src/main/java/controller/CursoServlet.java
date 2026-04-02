package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Curso;
import persistence.CursoDao;
import persistence.GenericDao;

@WebServlet("/curso")
public class CursoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CursoServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String acao = request.getParameter("acao");
		String codigo = request.getParameter("codigo");
		
		Curso c = new Curso();
		String erro = "";
		List<Curso> cursos = new ArrayList<>();
		
		try {
			if (acao != null) {
				c.setCodigo(Integer.parseInt(codigo));
				
				GenericDao gDao = new GenericDao();
				CursoDao cDao = new CursoDao(gDao);
				
				if (acao.equalsIgnoreCase("excluir")) {
					cDao.excluir(c);
					cursos = cDao.listar();
					c = null;
				} else {
					c = cDao.buscar(c);
					cursos = null;
				}
			}
			
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			request.setAttribute("erro", erro);
			request.setAttribute("curso", c);
			request.setAttribute("cursos", cursos);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("curso.jsp");
			dispatcher.forward(request, response);
		}
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String saida = "";
		String erro = "";
		
		List<Curso> cursos = new ArrayList<Curso>();
		Curso c = new Curso();
		String cmd = "";
		
		try {
			String codigo = request.getParameter("codigo");
			String nome = request.getParameter("nome");
			String sigla = request.getParameter("sigla");
			String cargaHoraria = request.getParameter("cargaHoraria");
			String notaEnade = request.getParameter("notaEnade");
			cmd = request.getParameter("botao");
			
			if (!cmd.equalsIgnoreCase("Listar")) {
				c.setCodigo(Integer.parseInt(codigo));
			}
			if (cmd.equalsIgnoreCase("Inserir") || 
					cmd.equalsIgnoreCase("Atualizar")) {
				c.setNome(nome);
				c.setSigla(sigla);
				c.setCargaHoraria(Integer.parseInt(cargaHoraria));
				c.setNotaEnade(Integer.parseInt(notaEnade));
			}
			
			GenericDao gDao = new GenericDao();
			CursoDao cDao = new CursoDao(gDao);
			
		
			if (cmd.equalsIgnoreCase("Inserir")) {
				saida = cDao.inserir(c);
			}
			if (cmd.equalsIgnoreCase("Atualizar")) {
				saida = cDao.atualizar(c);
			}
			if (cmd.equalsIgnoreCase("Excluir")) {
				saida = cDao.excluir(c);
			}
			if (cmd.equalsIgnoreCase("Buscar")) {
				c = cDao.buscar(c);
			}
			if (cmd.equalsIgnoreCase("Listar")) {
				cursos = cDao.listar();
			}

		} catch (SQLException | ClassNotFoundException | NumberFormatException e) {
			saida = "";
			erro = e.getMessage();
			if (erro.contains("input string")) {
				erro = "Preencha os campos corretamente";
			}
		} finally {
			if (!cmd.equalsIgnoreCase("Buscar")) {
				c = null;
			}
			if (!cmd.equalsIgnoreCase("Listar")) {
				cursos = null;
			}
			request.setAttribute("erro", erro);
			request.setAttribute("saida", saida);
			request.setAttribute("curso", c);
			request.setAttribute("cursos", cursos);

			RequestDispatcher dispatcher = 
					request.getRequestDispatcher("curso.jsp");
			dispatcher.forward(request, response);
		}
	}

}
