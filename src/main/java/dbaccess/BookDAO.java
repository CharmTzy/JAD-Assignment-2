package dbaccess;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.Book;

public class BookDAO {
    public static List<Book> getBestSellingBooks(int limit) throws SQLException {
        Connection conn = DBConnection.getConnection();
        Statement stmt = conn.createStatement();

        String sql = "SELECT book_id, COUNT(book_id) AS total_sold " + "FROM order_items " + "GROUP BY book_id "
                + "ORDER BY total_sold DESC " + "LIMIT " + limit;

        System.out.println("SQL Query: " + sql); // Print the SQL query for debugging
        ResultSet rs = stmt.executeQuery(sql);

        List<Book> topBooks = new ArrayList<>();
        while (rs.next()) {
            int bookId = rs.getInt("book_id");
            int totalSold = rs.getInt("total_sold");
            System.out.println("Book ID: " + bookId + ", Total Sold: " + totalSold);

            // Fetch book details using bookId and add to topBooks list
            Book book = fetchBookDetails(bookId);
            if (book != null) {
                topBooks.add(book);
            }
        }

        conn.close();

        return topBooks;
    }

    public static Book fetchBookDetails(int bookId) throws SQLException {
        Connection conn = DBConnection.getConnection();
        Statement stmt = conn.createStatement();

        String sql = "SELECT * FROM books WHERE id = " + bookId;

        ResultSet rs = stmt.executeQuery(sql);

        Book book = null;
        if (rs.next()) {
            String title = rs.getString("title");
            String author = rs.getString("author");
            float price = rs.getFloat("price");
            String isbn = rs.getString("isbn");
            int quantity = rs.getInt("quantity");

            book = new Book();
            book.setId(bookId);
            book.setTitle(title);
            book.setAuthor(author);
            book.setPrice(price);
            book.setIsbn(isbn);
            book.setQuantity(quantity);
        }

        conn.close();

        return book;
 
    
    }

    
    public static List<Book> getLeastSellingBooks(int limit) throws SQLException {
        Connection conn = DBConnection.getConnection();
        Statement stmt = conn.createStatement();

        String sql = "SELECT book_id, COUNT(book_id) AS total_sold " +
                     "FROM order_items " +
                     "GROUP BY book_id " +
                     "ORDER BY total_sold ASC " + // Ascending order for least-selling
                     "LIMIT " + limit;

        System.out.println("SQL Query: " + sql); // Print the SQL query for debugging
        ResultSet rs = stmt.executeQuery(sql);

        List<Book> leastSellingBooks = new ArrayList<>();
        while (rs.next()) {
            int bookId = rs.getInt("book_id");
            int totalSold = rs.getInt("total_sold");
            System.out.println("Book ID: " + bookId + ", Total Sold: " + totalSold);

            // Fetch book details using bookId and add to leastSellingBooks list
            Book book = fetchBookDetails(bookId);
            if (book != null) {
                book.setTotalSold(totalSold); // Set the total sold count in the Book object
                leastSellingBooks.add(book);
            }
        }

        conn.close();

        return leastSellingBooks;
    }
}
