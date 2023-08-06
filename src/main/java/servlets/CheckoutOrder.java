package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Book;

@WebServlet("/checkout")
public class CheckoutOrder extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        ArrayList<Book> cart = (ArrayList<Book>) session.getAttribute("cart");

        System.out.println(cart);
        if (cart != null && !cart.isEmpty()) {
            // Database connection code, you should replace this with your database connection setup.
            try  {
                Class.forName("com.mysql.jdbc.Driver");

                // Step 2: Define Connection URL
                String connURL = "jdbc:mysql://localhost/book_db?user=JAD&password=root@123mml&serverTimezone=UTC";

                // Step 3: Establish connection to URL
                Connection conn = DriverManager.getConnection(connURL);

              
                String insertOrderQuery = "INSERT INTO orders (customer_id, subtotal, gst_amount, total_amount) VALUES (?, ?, ?, ?)";

                
                int customerIDString = (int) session.getAttribute("sessCustomerid");
                System.out.println(customerIDString);
                
                
                float totalAmountValue = 0;
                for (Book book : cart) {
                    totalAmountValue += (book.getQuantity() * book.getPrice());
                }
                float gstAmountValue = totalAmountValue * 0.08f; 
                float realAmountValue = totalAmountValue + gstAmountValue;

                try (PreparedStatement stmt = conn.prepareStatement(insertOrderQuery,
                        PreparedStatement.RETURN_GENERATED_KEYS)) {
                    stmt.setInt(1, customerIDString);
                    stmt.setFloat(2, totalAmountValue);
                    stmt.setFloat(3, gstAmountValue);
                    stmt.setFloat(4, realAmountValue);

                    int rowsAffected = stmt.executeUpdate();

                    if (rowsAffected == 0) {
                        response.sendRedirect("error.jsp");
                        return;
                    }

                    // Retrieve the auto-generated order ID for the new order.
                    try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            int orderId = generatedKeys.getInt(1);

                            // Step 2: Insert order items into the 'order_items' table
                            String insertOrderItemsQuery = "INSERT INTO order_items (order_id, book_id, quantity, price) VALUES (?, ?, ?, ?)";
                            try (PreparedStatement stmtOrderItems = conn
                                    .prepareStatement(insertOrderItemsQuery)) {
                                for (Book book : cart) {
                                    stmtOrderItems.setInt(1, orderId);
                                    stmtOrderItems.setInt(2, book.getId());
                                    stmtOrderItems.setInt(3, book.getQuantity());
                                    stmtOrderItems.setFloat(4, book.getPrice());
                                    stmtOrderItems.addBatch(); // Use batch insert for efficiency
                                }
                                stmtOrderItems.executeBatch(); // Execute batch insert
                            }

                            // Step 3: Clear the cart as the order has been successfully placed
                            session.removeAttribute("cart");

                            // Redirect to displayMember.jsp with success message and purchased books info
                            String successMessage = "You have purchased the following books successfully:\n";
                            for (Book book : cart) {
                                successMessage += "Title: " + book.getTitle() + ", Quantity: " + book.getQuantity()
                                        + "\n";
                            }
                            successMessage += "Total Amount: $" + realAmountValue;

                            // Set the success message in the request attribute to display on the page.
                            request.setAttribute("successMessage", successMessage);
                            
                            response.sendRedirect("./Member/displayMember.jsp?orderStatus=true");
                            return;
                        }
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle database-related errors and redirect to an error page.
                System.out.println("1");
                response.sendRedirect("checkout.jsp");
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
                // Handle database-related errors and redirect to an error page.
                System.out.println("2");
                response.sendRedirect("checkout.jsp");
            }
        } else {
            // If the cart is empty, handle the error or redirect to a cart-empty page.
        	System.out.println("3");
            response.sendRedirect("./Member/checkout.jsp");
        }
    }
}
