<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Low Stock Report</title>
</head>
<body>
    <%@ page import="java.sql.*" %>
    <%@ page import="model.LowStockBook" %>
    <%@ page import="java.util.List" %>
    <%@ page import="java.util.ArrayList" %>

    <% 
    // List to store low stock books
    List<LowStockBook> lowStockBooks = new ArrayList<>();
    
    try {
        // Step1: Load JDBC Driver
        Class.forName("com.mysql.jdbc.Driver");

        // Step 2: Define Connection URL
        String connURL = "jdbc:mysql://localhost/book_db?user=root&password=waiyan04&serverTimezone=UTC";

        // Step 3: Establish connection to URL
        Connection conn = DriverManager.getConnection(connURL);

        // Step 4: Create Statement object
        Statement stmt = conn.createStatement();

        // Step 5: Execute SQL Command
        String sqlStr = "SELECT * FROM books WHERE quantity <= 3";
        ResultSet rs = stmt.executeQuery(sqlStr);

        // Step 6: Process Result
        while (rs.next()) {
            String image = rs.getString("image");
            int id = rs.getInt("id");
            String title = rs.getString("title");
            String author = rs.getString("author");
            double price = rs.getDouble("price");
            String isbn = rs.getString("isbn");
            int quantity = rs.getInt("quantity");

            LowStockBook book = new LowStockBook(image, id, title, author, price, isbn, quantity);
            lowStockBooks.add(book);
        }

        // Step 7: Close connection
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    %>

    <h1 style="color: #0053a1;">Books with Low Stock</h1>

    <% if (!lowStockBooks.isEmpty()) { %>
        <table style="border-collapse: collapse; width: 100%; margin-top: 20px;">
            <tr>
                <th style="background-color: #0053a1; color: #fff; border: 1px solid #ccc; padding: 8px;">Title</th>
                <th style="background-color: #0053a1; color: #fff; border: 1px solid #ccc; padding: 8px;">Author</th>
                <th style="background-color: #0053a1; color: #fff; border: 1px solid #ccc; padding: 8px;">Price</th>
                <th style="background-color: #0053a1; color: #fff; border: 1px solid #ccc; padding: 8px;">ISBN</th>
                <th style="background-color: #0053a1; color: #fff; border: 1px solid #ccc; padding: 8px;">Quantity</th>
            </tr>

            <% for (LowStockBook book : lowStockBooks) { %>
                <tr>
                    <td style="border: 1px solid #ccc; padding: 8px;"><%= book.getTitle() %></td>
                    <td style="border: 1px solid #ccc; padding: 8px;"><%= book.getAuthor() %></td>
                    <td style="border: 1px solid #ccc; padding: 8px;"><%= book.getPrice() %></td>
                    <td style="border: 1px solid #ccc; padding: 8px;"><%= book.getIsbn() %></td>
                    <td style="border: 1px solid #ccc; padding: 8px;"><%= book.getQuantity() %></td>
                </tr>
            <% } %>
        </table>
    <% } else { %>
        <p style="color: #0053a1;">No books with low stock found.</p>
    <% } %>
</body>
</html>