<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="dbaccess.User" %>
<%@ page import="dbaccess.UserDAO" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 20px;
        }

        h1 {
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #dddddd;
            padding: 8px;
            text-align: left;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        form {
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
        }

        input[type="text"] {
            padding: 6px;
        }

        input[type="submit"] {
            padding: 6px 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        .message {
            margin-top: 10px;
            color: #666666;
        }

    </style>
</head>
<body>
    <h1>Customer List</h1>

    <!-- Form for filtering by city -->
    <form action="customerList.jsp" method="get">
        <label for="city">Filter by City:</label>
        <input type="text" id="city" name="city">
        <input type="submit" value="Filter">
    </form>

    <%-- Display the filtered users --%>
    <%
    String cityFilter = request.getParameter("city");
    List<User> filteredUsers = null;

    try {
        if (cityFilter != null && !cityFilter.isEmpty()) {
            // Fetch users based on the selected city
            filteredUsers = UserDAO.getUserByCity(cityFilter);
        } else {
            // Fetch all users if no city filter is provided
            filteredUsers = UserDAO.getAllUsers();
        }
        
    } catch (SQLException e) {
        e.printStackTrace();
    }
    %>

    <% if (filteredUsers != null && !filteredUsers.isEmpty()) { %>
        <table>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Email</th>
                <th>City</th>
                <th>Phone Number</th>
            </tr>
            <% for (User user : filteredUsers) { %>
                <tr>
                    <td><%= user.getId() %></td>
                    <td><%= user.getUsername() %></td>
                    <td><%= user.getEmail() %></td>
                    <td><%= user.getCity() %></td>
                    <td><%= user.getPhnumber() %></td>
                </tr>
            <% } %>
        </table>
    <% } else { %>
        <p>No users found.</p>
    <% } %>

</body>
</html>
