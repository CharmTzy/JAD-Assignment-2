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
    <title>Delete Book</title>
</head>
<body>
<%
String bookId = request.getParameter("bookId");

try {
    Class.forName("com.mysql.jdbc.Driver");
    String connURL = "jdbc:mysql://localhost/book_db?user=JAD&password=root@123mml&serverTimezone=UTC";
    Connection conn = DriverManager.getConnection(connURL);
    PreparedStatement pstmt = conn.prepareStatement("DELETE FROM books WHERE id = ?");
    pstmt.setString(1, bookId);
    int count = pstmt.executeUpdate();

    pstmt.close();
    conn.close();

    response.sendRedirect("displayAdmin.jsp?successMsg=Book deleted successfully.");
} catch (Exception e) {
    out.println("Error: " + e);
}
%>
</body>
</html>
