package dbaccess;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	
	public static Connection getConnection() {
		String dbUrl = "jdbc:mysql://hogwartlibrary.cq8iljpqenuc.us-east-1.rds.amazonaws.com:3306/book_db?user=admin&password=JwaHOknEhIk0NoiTC1oH&serverTimezone=UTC";
		String dbUser = "admin";
		String dbPassword = "JwaHOknEhIk0NoiTC1oH";
		String dbClass = "com.mysql.jdbc.Driver";
		
		Connection connection = null;
		try {
			Class.forName(dbClass);
			
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
		try {
			connection = DriverManager.getConnection(dbUrl,dbUser,dbPassword);
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return connection;
		
	}
}