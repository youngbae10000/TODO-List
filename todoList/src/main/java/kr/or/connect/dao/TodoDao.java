package kr.or.connect.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.or.connect.dto.TodoDto;

public class TodoDao {

	private static final String dbUrl = "jdbc:mysql://localhost:3306/connectdb";
	private static final String dbUser = "root";
	private static final String dbPassword = "4573";

	private PreparedStatement ps = null;
	private ResultSet rs = null;
	private Connection conn = null;

	private static TodoDao instance = new TodoDao();

	public static TodoDao getInstance() {
		return instance;
	}

	public Connection getConnection() throws Exception {

		Class.forName("com.mysql.jdbc.Driver");

		return DriverManager.getConnection(dbUrl, dbUser, dbPassword);
	}

	// select
	public List<TodoDto> getTodos() {

		List<TodoDto> list = new ArrayList<TodoDto>();

		try {

			final String sql = "select id, title, name, sequence, type, regdate from todo order by regdate asc;";

			TodoDao dao = TodoDao.getInstance();
			conn = dao.getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()) {
				TodoDto dto = new TodoDto();
				dto.setId(rs.getLong("id"));
				dto.setName(rs.getString("name"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setSequence(rs.getInt("sequence"));
				dto.setTitle(rs.getString("title"));
				dto.setType(rs.getString("type"));
				list.add(dto);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			doesConnections(rs, ps, conn);
		}

		return list;
	}

	// insert
	public int addTodo(TodoDto dto) {
		
		final String sql = String.format("insert into todo(title, name, sequence) values ('%s','%s',%d);",dto.getTitle(),dto.getName(),dto.getSequence());

		try {

			TodoDao dao = TodoDao.getInstance();
			conn = dao.getConnection();
			ps = conn.prepareStatement(sql);
			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			doesConnections(rs, ps, conn);
		}

		return 0;
	}

	// update
	public boolean updateTodo(TodoDto dto) {

		try {
			String sql = String.format("update todo set type = '%s' where id = %d;", dto.getType(), dto.getId());

			TodoDao dao = TodoDao.getInstance();
			conn = dao.getConnection();
			ps = conn.prepareStatement(sql);
			ps.executeUpdate();

			return true;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			doesConnections(rs, ps, conn);
		}

		return false;
	}

	private void doesConnections(ResultSet rs, PreparedStatement ps, Connection conn) {

		try {
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
}
