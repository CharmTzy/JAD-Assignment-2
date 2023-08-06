<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<%--
	- Author 			: Wai Yan Aung
	- Date 				: 19/06/2023
	- Description 		: JAD Assignment 1
	- Admission no		: P2234993
	- Class 			: DIT/FT/2A/02
--%>
    <%--
	- Author 			: Zayar Hpoun Myint
	- Date 				: 19/06/2023
	- Description 		: JAD Assignment 1
	- Admission no		: P2235080
	- Class 			: DIT/FT/2A/02
--%>
    <meta charset="UTF-8">
    <title>Update Admin Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f1f1f1;
            margin: 0;
            padding: 20px;
        }

        h1 {
        	text-align: center;
            color: #333;
        }

        form {
            max-width: 400px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-bottom: 10px;
        }

        input[type="text"],
        input[type="email"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }

        input[type="submit"] {
            background-color: #4caf50;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        .error-message {
            color: red;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<%

String AdminID = (String) session.getAttribute("sessAdminID");
String userRole = (String) session.getAttribute("role");
String loginStatus = (String) session.getAttribute("loginStatus");
System.out.println((String) session.getAttribute("role"));
if (AdminID == null ||  !userRole.equals("admin") || loginStatus == null || !loginStatus.equals("success")) {
    response.sendRedirect("../Login.jsp?errCode=invalidLogin");
}else {
	String email = "";
    String address = "";
    String phnumber = "";
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String connURL = "jdbc:mysql://hogwartlibrary.cq8iljpqenuc.us-east-1.rds.amazonaws.com:3306/book_db?user=admin&password=JwaHOknEhIk0NoiTC1oH&serverTimezone=UTC";
        Connection conn = DriverManager.getConnection(connURL);

        String sql = "SELECT email, address, phnumber FROM user WHERE username = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, AdminID);

        ResultSet rs = pstmt.executeQuery();
        

        if (rs.next()) {
            email = rs.getString("email");
            address = rs.getString("address");
            phnumber = rs.getString("phnumber");
        }

        rs.close();
        pstmt.close();
        conn.close();
    }catch(ClassNotFoundException | SQLException e) {
        response.sendRedirect("../Login.jsp?update=error");
    	
    	}

%>


<h1>Update Admin Profile</h1>
<form action="updateAdmin.jsp" method="POST">
    <label for="username">Username:</label>
<input type="text" id="username" name="username" value="<%= AdminID %>" readonly><br><br>

<label for="email">Email:</label>
<input type="email" id="email" name="email" value="<%= email %>" required><br><br>

<label for="address">Address:</label>
<input type="text" id="address" name="address" value="<%= address %>" required><br><br>

<label for="phnumber">Phone Number:</label>
<input type="text" id="phnumber" name="phnumber" value="<%= phnumber %>" required><br><br>
<input type="submit" value="Update">
</form>
<%} %>




<% 

    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String address = request.getParameter("address");
    String phnumber = request.getParameter("phnumber");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        String connURL = "jdbc:mysql://hogwartlibrary.cq8iljpqenuc.us-east-1.rds.amazonaws.com:3306/book_db?user=admin&password=JwaHOknEhIk0NoiTC1oH&serverTimezone=UTC";
        Connection conn = DriverManager.getConnection(connURL);

        String sql = "UPDATE user SET email = ?, address = ?, phnumber = ? WHERE username = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, email);
        pstmt.setString(2, address);
        pstmt.setString(3, phnumber);
        pstmt.setString(4, username);

        int rowsAffected = pstmt.executeUpdate();
        pstmt.close();
        conn.close();

        if (rowsAffected > 0) {
            response.sendRedirect("displayAdmin.jsp?update=success");
        } 
    } catch (ClassNotFoundException | SQLException e) {
        response.sendRedirect("../Login.jsp?update=error");
    }
    
%>
</body>
</html>