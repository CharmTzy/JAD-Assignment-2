<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.List" %>
<%@page import="model.Book" %>
<%@page import="dbaccess.BookDAO" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Least Selling Books</title>
    <style>
        /* Inline CSS for demonstration purposes */
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
        }

        h1 {
            margin-bottom: 20px;
        }

        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>

<h1>Least Selling Books</h1>
<% 
        try {
            int limit = 10; // Set the number of top-selling books to display

            // Get the best selling books using the BookDAO
            List<Book> leastSellingBooks = BookDAO.getLeastSellingBooks(limit);
    %>

    <% if (!leastSellingBooks.isEmpty()) { %>
    <table>
        <tr>
            <th>Title</th>
            <th>Author</th>
        </tr>
        <% for (Book book : leastSellingBooks) { %>
        <tr>
            <td><%= book.getTitle() %></td>
            <td><%= book.getAuthor() %></td>
            
        </tr>
        <% } %>
    </table>
    <% } else { %>
    <p>No best selling books found.</p>
    <% } %>

    <% } catch (Exception e) { %>
    <p>Error fetching least selling books: <%= e.getMessage() %></p>
    <% } %>

</body>
</html>
