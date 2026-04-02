package persistence;

import java.sql.CallableStatement; 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import model.Aluno;

public class AlunoDao implements ICrud<Aluno>{
	
	private GenericDao gDao;

	public AlunoDao(GenericDao gDao) {
		this.gDao = gDao;
	}
	
	@Override
	public Aluno buscar(Aluno aluno) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "SELECT id, "
				+ "ra, "
				+ "nome, "
				+ "codigoCurso, "
				+ "nomeSocial, "
				+ "nascimento, "
				+ "telefone1, "
				+ "telefone2, "
				+ "email, "
				+ "dataSegundoGrau, "
				+ "nomeInstituicao, "
				+ "pontuacao, "
				+ "posicao, "
				+ "anoIngresso, "
				+ "semestreIngresso, "
				+ "anoLimite, "
				+ "semestreLimite, "
				+ "cpf "
				+ "FROM aluno WHERE id = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, aluno.getId());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			
			aluno.setId(rs.getInt("id"));
			aluno.setRa(rs.getInt("ra"));
			aluno.setNome(rs.getString("nome"));
			aluno.setCodigoCurso(rs.getInt("codigoCurso"));
			aluno.setNomeSocial(rs.getString("nomeSocial"));
			aluno.setNascimento(LocalDate.parse(rs.getString("nascimento")));
			aluno.setTelefone1(rs.getString("telefone1"));
			aluno.setTelefone2(rs.getString("telefone2"));
			aluno.setEmail(rs.getString("email"));
			aluno.setDataSegundoGrau(LocalDate.parse(rs.getString("dataSegundoGrau")));
			aluno.setNomeInstituicao(rs.getString("nomeInstituicao"));
			aluno.setPontuacao(rs.getInt("pontuacao"));
			aluno.setPosicao(rs.getInt("posicao"));
			aluno.setAnoIngresso(rs.getInt("anoIngresso"));
			aluno.setSemestreIngresso(rs.getInt("semestreIngresso"));
			aluno.setAnoLimite(rs.getInt("anoLimite"));
			aluno.setSemestreLimite(rs.getInt("semestreLimite"));
			aluno.setCpf(rs.getString("cpf"));
		}
		rs.close();
		ps.close();
		return aluno;
	}

	@Override
	public List<Aluno> listar() throws SQLException, ClassNotFoundException {
		List<Aluno> alunos = new ArrayList<>();
		Connection c = gDao.getConnection();	
		String sql = "SELECT id, "
				+ "ra ,"
				+ "nome, "
				+ "codigoCurso, "
				+ "nomeSocial, "
				+ "nascimento, "
				+ "telefone1, "
				+ "telefone2, "
				+ "email,"
				+ "dataSegundoGrau, "
				+ "nomeInstituicao, "
				+ "pontuacao, "
				+ "posicao, "
				+ "anoIngresso, "
				+ "semestreIngresso, "
				+ "anoLimite, "
				+ "semestreLimite, "
				+ "cpf "
				+ "FROM aluno ";
		
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while (rs.next()) {
			Aluno aluno = new Aluno();
			
			aluno.setId(rs.getInt("id"));
			aluno.setRa(rs.getInt("ra"));
			aluno.setNome(rs.getString("nome"));
			aluno.setCodigoCurso(rs.getInt("codigoCurso"));
			aluno.setNomeSocial(rs.getString("nomeSocial"));
			aluno.setNascimento(LocalDate.parse(rs.getString("nascimento")));
			aluno.setTelefone1(rs.getString("telefone1"));
			aluno.setTelefone2(rs.getString("telefone2"));
			aluno.setEmail(rs.getString("email"));
			aluno.setDataSegundoGrau(LocalDate.parse(rs.getString("dataSegundoGrau")));
			aluno.setNomeInstituicao(rs.getString("nomeInstituicao"));
			aluno.setPontuacao(rs.getInt("pontuacao"));
			aluno.setPosicao(rs.getInt("posicao"));
			aluno.setAnoIngresso(rs.getInt("anoIngresso"));
			aluno.setSemestreIngresso(rs.getInt("semestreIngresso"));
			aluno.setAnoLimite(rs.getInt("anoLimite"));
			aluno.setSemestreLimite(rs.getInt("semestreLimite"));
			aluno.setCpf(rs.getString("cpf"));
			alunos.add(aluno);
		}
		rs.close();
		ps.close();
		return alunos;
	}

	@Override
	public String inserir(Aluno aluno) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_aluno(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		
		cs.setString(1, "I");
		cs.setInt(2, aluno.getId());
		cs.setString(3, aluno.getNome());
		cs.setInt(4, aluno.getCodigoCurso());
		cs.setString(5, aluno.getNomeSocial());
		cs.setString(6, aluno.getNascimento().toString());
		cs.setString(7, aluno.getTelefone1());
		cs.setString(8, aluno.getTelefone2());
		cs.setString(9, aluno.getEmail());
		cs.setString(10, aluno.getDataSegundoGrau().toString());
		cs.setString(11, aluno.getNomeInstituicao());
		cs.setInt(12, aluno.getPontuacao());
		cs.setInt(13, aluno.getPosicao());
		cs.setInt(14, aluno.getAnoIngresso());
		cs.setInt(15, aluno.getSemestreIngresso());
		cs.setString(16, aluno.getCpf());
		
		cs.registerOutParameter(17, Types.VARCHAR);
	
		cs.execute();
		String saida = cs.getString(17);
		
		cs.close();
		c.close();
		
		return saida;
	}

	@Override
	public String atualizar(Aluno aluno) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_aluno(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		
		cs.setString(1, "U");
		cs.setInt(2, aluno.getId());
		cs.setString(3, aluno.getNome());
		cs.setInt(4, aluno.getCodigoCurso());
		cs.setString(5, aluno.getNomeSocial());
		cs.setString(6, aluno.getNascimento().toString());
		cs.setString(7, aluno.getTelefone1());
		cs.setString(8, aluno.getTelefone2());
		cs.setString(9, aluno.getEmail());
		cs.setString(10, aluno.getDataSegundoGrau().toString());
		cs.setString(11, aluno.getNomeInstituicao());
		cs.setInt(12, aluno.getPontuacao());
		cs.setInt(13, aluno.getPosicao());
		cs.setInt(14, aluno.getAnoIngresso());
		cs.setInt(15, aluno.getSemestreIngresso());
		cs.setString(16, aluno.getCpf());	
		cs.registerOutParameter(17, Types.VARCHAR);
		
		cs.execute();
		String saida = cs.getString(17);	
		cs.close();
		c.close();	
		return saida;
	}

	@Override
	public String excluir(Aluno aluno) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_aluno(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, "D");
		cs.setInt(2, aluno.getId());
		cs.setString(3, aluno.getNome());
		cs.setInt(4, aluno.getCodigoCurso());
		cs.setString(5, aluno.getNomeSocial());
		cs.setNull(6, Types.VARCHAR);
		cs.setString(7, aluno.getTelefone1());
		cs.setString(8, aluno.getTelefone2());
		cs.setString(9, aluno.getEmail());
		cs.setNull(10, Types.VARCHAR);
		cs.setString(11, aluno.getNomeInstituicao());
		cs.setInt(12, aluno.getPontuacao());
		cs.setInt(13, aluno.getPosicao());
		cs.setInt(14, aluno.getAnoIngresso());
		cs.setInt(15, aluno.getSemestreIngresso());
		cs.setString(16, aluno.getCpf());
		cs.registerOutParameter(17, Types.VARCHAR);
		
		cs.execute();
		String saida = cs.getString(17);
		
		cs.close();
		c.close();
		
		return saida;
	
	}
}
