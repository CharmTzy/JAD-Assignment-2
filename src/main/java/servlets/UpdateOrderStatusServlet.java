package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dbaccess.*;


import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.client.Entity;
import jakarta.ws.rs.client.Invocation;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

/**
 * Servlet implementation class UpdateOrderStatusServlet
 */
@WebServlet("/UpdateOrderStatusServlet")
public class UpdateOrderStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateOrderStatusServlet() {
        super();
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        int orderId = Integer.parseInt(request.getParameter("order_id"));

        String status = request.getParameter("status");
        System.out.println("Order ID: " + orderId);
        System.out.println("Status: " + status);

        // Call the method to update the order status
        boolean updated = updateOrderStatus(orderId, status);

        if (updated) {
            System.out.println("Order status updated successfully.");
            // Redirect back to the saleManagement.jsp after updating the status
            response.sendRedirect("Admin/saleManagement.jsp");
        } else {
            System.out.println("Failed to update order status.");
            // Handle the case when the update fails
            String url = "errorPage.jsp";
            request.setAttribute("error", "Failed to update order status.");
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
    }

    private boolean updateOrderStatus(int orderId, String status) {
        try {
            Client client = ClientBuilder.newClient();
            String restUrl = "http://localhost:8081/user-ws/updateOrderStatus/" + orderId;
            WebTarget target = client.target(restUrl);
            Invocation.Builder invocationBuilder = target.request(MediaType.APPLICATION_JSON);

            // Prepare the request entity with status in the request body
            Entity<String> requestEntity = Entity.entity("{\"status\":\"" + status + "\"}", MediaType.APPLICATION_JSON);

            // Perform the POST request to update the order status
            Response response = invocationBuilder.post(requestEntity);

            if (response.getStatus() == Response.Status.OK.getStatusCode()) {
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
            System.out.println("Exception: " + e);
            return false;
        }
    }
}
