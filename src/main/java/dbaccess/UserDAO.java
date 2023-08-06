package dbaccess;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;

public class UserDAO {

	
	public static List<User> getAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT u.*, a.block_number, a.street_name, a.floor, a.postal_code, a.city " +
                     "FROM user u " +
                     "LEFT JOIN address a ON u.address_id = a.id";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);

        while (rs.next()) {
            User user = new User();
            user.setId(rs.getInt("id"));
            user.setUsername(rs.getString("username"));
            user.setEmail(rs.getString("email"));
            user.setRole(rs.getString("role"));
            user.setFloor(rs.getString("floor"));
            user.setPostalCode(rs.getString("postal_code"));
            user.setCity(rs.getString("city"));
            user.setPhnumber(rs.getString("phnumber"));
            users.add(user);
        }

        conn.close();
        return users;
    }
	
	public static List<User> getUserByCity(String city) throws SQLException {
        List<User> users = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT u.*, a.block_number, a.street_name, a.floor, a.postal_code, a.city " +
                     "FROM user u " +
                     "LEFT JOIN address a ON u.address_id = a.id " +
                     "WHERE a.city = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, city);
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            User user = new User();
            user.setId(rs.getInt("id"));
            user.setUsername(rs.getString("username"));
            user.setEmail(rs.getString("email"));
            user.setRole(rs.getString("role"));
            user.setFloor(rs.getString("floor"));
            user.setPostalCode(rs.getString("postal_code"));
            user.setCity(rs.getString("city"));
            user.setPhnumber(rs.getString("phnumber"));
            users.add(user);
        }

        conn.close();
        return users;
    }
}

