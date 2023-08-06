package dbaccess;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {

    public static List<User> getMembersByStreet(String streetCode) throws SQLException {
        Connection conn = DBConnection.getConnection();
        
        String sql = "SELECT * FROM user WHERE role = 'member' AND address LIKE '%" + streetCode + "%'";
        
        Statement stmt = conn.createStatement(); 
        ResultSet rs = stmt.executeQuery(sql);
        
        List<User> members = new ArrayList<>();
        while (rs.next()) {
            // Get user data from row
            int id = rs.getInt("id");
            String username = rs.getString("username");
            String email = rs.getString("email");
            String address = rs.getString("address");
            String phnumber = rs.getString("phnumber");
            
            User user = new User();
            user.setId(id);
            user.setUsername(username);
            user.setEmail(email);
            user.setAddress(address);
            user.setPhnumber(phnumber);
            
            members.add(user); 
        }

        return members;
    }
}