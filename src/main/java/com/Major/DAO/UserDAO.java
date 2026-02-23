package com.Major.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.Major.Entity.UserEntity;
import com.Major.config.Databaseconfig;

public class UserDAO {
	public boolean registration(UserEntity user, String role) throws Exception {
		String sql;
		boolean isUser = "user".equals(role);

		if (isUser) {

			sql = "INSERT INTO admin (name, email, passcode, phone, state, status) VALUES (?, ?, ?, ?, ?, ?)";
		} else {
			sql = "INSERT INTO admin (name, email, passcode, phone, state) VALUES (?, ?, ?, ?, ?)";
		}

		int rowsAffected = 0;

		try (Connection con = Databaseconfig.getConnection(); PreparedStatement stmt = con.prepareStatement(sql)) {

			stmt.setString(1, user.getName());
			stmt.setString(2, user.getEmail());
			stmt.setString(3, user.getPasscode());
			stmt.setString(4, user.getPhone());
			stmt.setString(5, user.getState());

			if (isUser) {
				stmt.setInt(6, 3);
			}

			rowsAffected = stmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return rowsAffected > 0;
	}

	public UserEntity validateUser(String email, String passcode) {
		UserEntity valUser = null;
		String sql = "SELECT * FROM admin WHERE email = ? AND passcode = ? AND status IN (1, 2, 3)";
		try {
			Connection con = Databaseconfig.getConnection();
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setString(1, email);
			stmt.setString(2, passcode);

			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				valUser = new UserEntity();
				valUser.setStatus(rs.getInt("status"));
				valUser.setName(rs.getString("name"));
				valUser.setId(rs.getInt("id"));
				valUser.setAdminId(rs.getInt("id"));
				valUser.setEmail(rs.getNString("email"));
				
			}

		} catch (Exception e) {
			e.getStackTrace();
		}
		return valUser;

	}

	public boolean AddScheme(UserEntity user) {
		String sql = "INSERT INTO schemes (title, state, start_date, end_date,author,url,description,admin_id) VALUES (?, ?, ?, ?, ?, ?, ?,?)";
		int rowAffected = 0;
		try (Connection con = Databaseconfig.getConnection(); PreparedStatement stmt = con.prepareStatement(sql)) {

			// Set query parameters
			stmt.setString(1, user.getTitle());
			stmt.setString(2, user.getState());
			stmt.setString(3, user.getStart_date());
			stmt.setString(4, user.getEnd_date());
			stmt.setString(5, user.getAuthor());
			stmt.setString(6, user.getUrl());
			stmt.setString(7, user.getDescription());
			stmt.setInt(8, user.getAdminId());

			rowAffected = stmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return rowAffected > 0;
	}

	public List<UserEntity> getAllScheme(int adminId) {
		List<UserEntity> schemes = new ArrayList<>();
		try {
			Connection conn = Databaseconfig.getConnection();
			String sql;
			PreparedStatement stmt;

			if (adminId == 1) {
				sql = "SELECT * FROM schemes WHERE status = 1";
				stmt = conn.prepareStatement(sql);
			} else {
				sql = "SELECT * FROM schemes WHERE status = 1 AND admin_id = ?";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, adminId);
			}

			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				UserEntity scheme = new UserEntity();
				scheme.setId(rs.getInt("id"));
				scheme.setTitle(rs.getString("title"));
				scheme.setState(rs.getString("state"));
				scheme.setUrl(rs.getString("url"));
				scheme.setDescription(rs.getString("description"));
				scheme.setAuthor(rs.getString("author"));
				scheme.setStart_date(rs.getString("start_date"));
				scheme.setEnd_date(rs.getString("end_date"));
				schemes.add(scheme);
			}

			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return schemes;
	}

	public UserEntity detailScheme(String id) {
		UserEntity scheme = new UserEntity();
		try {
			Connection conn = Databaseconfig.getConnection();
			String sql = "SELECT * FROM schemes where id = ? ";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				scheme.setTitle(rs.getString("title"));
				scheme.setState(rs.getString("state"));
				scheme.setUrl(rs.getString("url"));
				scheme.setDescription(rs.getString("description"));
				scheme.setAuthor(rs.getString("author"));
				scheme.setStart_date(rs.getString("start_date"));
				scheme.setEnd_date(rs.getString("end_date"));
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return scheme;
	}

	public List<UserEntity> filterScheme(String state) {
		List<UserEntity> schemes = new ArrayList<UserEntity>();
		try {
			Connection conn = Databaseconfig.getConnection();
			String sql;
			PreparedStatement stmt;

			// Check if the state is "all"
			if ("all".equalsIgnoreCase(state)) {
				sql = "SELECT * FROM schemes";
				stmt = conn.prepareStatement(sql);
			} else {
				sql = "SELECT * FROM schemes WHERE state = ?";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, state);
			}

			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				UserEntity scheme = new UserEntity();
				scheme.setId(rs.getInt("id"));
				scheme.setTitle(rs.getString("title"));
				scheme.setState(rs.getString("state"));
				scheme.setUrl(rs.getString("url"));
				scheme.setDescription(rs.getString("description"));
				scheme.setAuthor(rs.getString("author"));
				scheme.setStart_date(rs.getString("start_date"));
				scheme.setEnd_date(rs.getString("end_date"));
				schemes.add(scheme);
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return schemes;
	}

	public boolean terminateScheme(String id) {
		try {
			Connection conn = Databaseconfig.getConnection();
			// updatequery instead of delete query.
			String sql = "UPDATE admin SET status = 0 WHERE id = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			int rowsAffected = stmt.executeUpdate();
			conn.close();
			return rowsAffected > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public List<UserEntity> teamMember() {
		List<UserEntity> ListMember = new ArrayList<UserEntity>();
		try {
			Connection conn = Databaseconfig.getConnection();
			String sql = "SELECT * FROM admin";
			PreparedStatement stmt = conn.prepareStatement(sql);
			;
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				UserEntity member = new UserEntity();
				member.setId(rs.getInt("id"));
				member.setName(rs.getString("name"));
				member.setEmail(rs.getString("email"));
				member.setPhone(rs.getString("phone"));
				member.setState(rs.getString("state"));
				member.setStatus(rs.getInt("status"));
				ListMember.add(member);
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ListMember;
	}

	public boolean updateUser(String id) {
		Connection conn = null;
		PreparedStatement stmt = null;
		boolean isUpdated = false;

		try {
			conn = Databaseconfig.getConnection();
			String sql = "UPDATE admin SET status = 1 WHERE id = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			int rowsUpdated = stmt.executeUpdate();
			if (rowsUpdated > 0) {
				isUpdated = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isUpdated;
	}

	public boolean terminateUser(String id) {
		Connection conn = null;
		PreparedStatement stmt = null;
		boolean isUpdated = false;

		try {
			conn = Databaseconfig.getConnection();
			String sql = "UPDATE admin SET status = 0 WHERE id = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			int rowsUpdated = stmt.executeUpdate();
			if (rowsUpdated > 0) {
				isUpdated = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isUpdated;
	}

}
