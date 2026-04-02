package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import model.Curso;


public class CursoDao implements ICrud<Curso>{
	private GenericDao gDao;

	public CursoDao(GenericDao gDao) {
		this.gDao = gDao;
	}
	@Override
	public Curso buscar(Curso curso) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "SELECT codigo, nome, sigla, cargaHoraria, notaEnade FROM curso WHERE codigo = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, curso.getCodigo());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			curso.setCodigo(rs.getInt("codigo"));
			curso.setNome(rs.getString("nome"));
			curso.setSigla(rs.getString("sigla"));
			curso.setCargaHoraria(rs.getInt("cargaHoraria"));
			curso.setNotaEnade(rs.getInt("notaEnade"));
		}
		rs.close();
		ps.close();
		return curso;
	}

	@Override
	public List<Curso> listar() throws SQLException, ClassNotFoundException {
		List<Curso> cursos = new ArrayList<>();
		Connection c = gDao.getConnection();
		String sql = "SELECT codigo, nome, sigla, cargaHoraria, notaEnade FROM curso";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while (rs.next()) {
			Curso curso = new Curso();
			
			curso.setCodigo(rs.getInt("codigo"));
			curso.setNome(rs.getString("nome"));
			curso.setSigla(rs.getString("sigla"));
			curso.setCargaHoraria(rs.getInt("cargaHoraria"));
			curso.setNotaEnade(rs.getInt("notaEnade"));
			
			cursos.add(curso);
		}
		rs.close();
		ps.close();
		return cursos;
	}

	@Override
	public String inserir(Curso curso) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_curso(?,?,?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, "I");
		cs.setInt(2, curso.getCodigo());
		cs.setString(3, curso.getNome());
		cs.setString(4, curso.getSigla());
		cs.setInt(5, curso.getCargaHoraria());
		cs.setInt(6, curso.getNotaEnade());
		cs.registerOutParameter(7, Types.VARCHAR);
		
		cs.execute();
		String saida = cs.getString(7);
		
		cs.close();
		c.close();
		
		return saida;
	}

	@Override
	public String atualizar(Curso curso) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_curso(?,?,?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, "U");
		cs.setInt(2, curso.getCodigo());
		cs.setString(3, curso.getNome());
		cs.setString(4, curso.getSigla());
		cs.setInt(5, curso.getCargaHoraria());
		cs.setInt(6, curso.getNotaEnade());
		cs.registerOutParameter(7, Types.VARCHAR);
		
		cs.execute();
		String saida = cs.getString(7);
		
		cs.close();
		c.close();
		
		return saida;
	}

	@Override
	public String excluir(Curso curso) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_curso(?,?,?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, "D");
		cs.setInt(2, curso.getCodigo());
		cs.setString(3, curso.getNome());
		cs.setString(4, curso.getSigla());
		cs.setInt(5, curso.getCargaHoraria());
		cs.setInt(6, curso.getNotaEnade());
		cs.registerOutParameter(7, Types.VARCHAR);
		
		cs.execute();
		String saida = cs.getString(7);
		
		cs.close();
		c.close();
		
		return saida;
	}

}
