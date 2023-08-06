<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Book" %>
<%@ page import="dbaccess.BookDAO" %>

<!DOCTYPE html>
<html>
<head>
    <title>Best Selling Books</title>
    <style>
        /* Add your CSS styles here */
        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1>Best Selling Books</h1>

    <% 
        try {
            int limit = 10; // Set the number of top-selling books to display

            // Get the best selling books using the BookDAO
            List<Book> bestSellingBooks = BookDAO.getBestSellingBooks(limit);
    %>

    <% if (!bestSellingBooks.isEmpty()) { %>
    <table>
        <tr>
            <th>Title</th>
            <th>Author</th>
        </tr>
        <% for (Book book : bestSellingBooks) { %>
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
    <p>Error fetching best selling books: <%= e.getMessage() %></p>
    <% } %>

</body>
</html>

