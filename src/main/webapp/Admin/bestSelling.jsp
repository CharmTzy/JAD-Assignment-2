<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Book" %>
<!DOCTYPE html>
<html>
<head>
    <title>Best Selling Books</title>
</head>
<body>

<%

String AdminID = (String) session.getAttribute("sessAdminID");
String userRole = (String) session.getAttribute("role");
String loginStatus = (String) session.getAttribute("loginStatus");
System.out.println((String) session.getAttribute("role"));
if (AdminID == null ||  !userRole.equals("admin") || loginStatus == null || !loginStatus.equals("success")) {
    response.sendRedirect("../Login.jsp?errCode=invalidLogin");
}
%>

    <h1>Best Selling Books</h1>
    <%
        // Assuming you have already set the "bestSellers" attribute in the servlet
        List<Book> bestSellers = (List<Book>) request.getAttribute("bestSellers");

        if (bestSellers != null && !bestSellers.isEmpty()) {
            for (Book book : bestSellers) {
    %>
                <p><%= book.getTitle() %></p>
    <%
            }
        } else {
    %>
        <p>No best-selling books found.</p>
    <%
        }
    %>
</body>
</html>