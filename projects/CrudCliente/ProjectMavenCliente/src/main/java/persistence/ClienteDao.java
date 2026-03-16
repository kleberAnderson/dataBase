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

import model.Cliente;

public class ClienteDao implements ICrud<Cliente>{

	private GenericDao gDao;
	
	public ClienteDao(GenericDao gDao) {
		this.gDao = gDao;
	}
	
	@Override
	public Cliente buscar(Cliente cliente) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "SELECT cpf, nome, email, limite_credito, dt_nascimento FROM cliente WHERE cpf = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1,cliente.getCpf());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			cliente.setCpf(rs.getString("cpf"));
			cliente.setNome(rs.getString("nome"));
			cliente.setEmail(rs.getString("email"));
			cliente.setLimite_credito(rs.getFloat("limite_credito"));
			cliente.setDt_nascimento(LocalDate.parse(rs.getString("dt_nascimento")));
		}
		rs.close();
		ps.close();
		return cliente;
	}

	@Override
	public List<Cliente> listar() throws SQLException, ClassNotFoundException {
		List<Cliente> clientes = new ArrayList<>();
		Connection c = gDao.getConnection();
		String sql = "SELECT cpf, nome, email, limite_credito"
				+ " CONVERT(CHAR(10), dt_nascimento, 103) AS dtNasc "
				+ " FROM cliente";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Cliente cliente = new Cliente();
			cliente.setCpf(rs.getString("cpf"));
			cliente.setNome(rs.getString("nome"));
			cliente.setEmail(rs.getString("email"));
			cliente.setLimite_credito(rs.getFloat("limite_credito"));
			cliente.setDt_nascimento(LocalDate.parse(rs.getString("dt_nascimento")));
			
			clientes.add(cliente);
		}
		rs.close();
		ps.close();
		return clientes;
	}

	@Override
	public String inserir(Cliente cliente) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL insert_cliente(?,?,?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, "I");
		cs.setString(2, cliente.getCpf());
		cs.setString(3, cliente.getNome());
		cs.setString(4, cliente.getEmail());
		cs.setFloat(5, cliente.getLimite_credito());
		cs.setString(6, cliente.getDt_nascimento().toString());
		cs.registerOutParameter(7, Types.VARCHAR);
		
		cs.execute();
		String saida = cs.getString(7);
		
		cs.close();
		c.close();
		return saida;
	}

	@Override
	public String atualizar(Cliente cliente) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL insert_cliente(?,?,?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, "U");
		cs.setString(2, cliente.getCpf());
		cs.setString(3, cliente.getNome());
		cs.setString(4, cliente.getEmail());
		cs.setFloat(5, cliente.getLimite_credito());
		cs.setString(6, cliente.getDt_nascimento().toString());
		cs.registerOutParameter(7, Types.VARCHAR);
		
		cs.execute();
		String saida = cs.getString(7);
		
		cs.close();
		c.close();
		return saida;
	}

	@Override
	public String excluir(Cliente cliente) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL insert_cliente(?,?,?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, "D");
		cs.setString(2, cliente.getCpf());
		cs.setNull(3, Types.VARCHAR);
		cs.setNull(4, Types.VARCHAR);
		cs.setNull(5, Types.VARCHAR);
		cs.setNull(6, Types.VARCHAR);
		cs.registerOutParameter(7, Types.VARCHAR);
		
		cs.execute();
		String saida = cs.getString(7);
		
		cs.close();
		c.close();
		return saida;
	}
	

}
