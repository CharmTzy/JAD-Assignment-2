package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dbaccess.Sale;
import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.client.Invocation;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.GenericType;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
/**
 * Servlet implementation class GetUserList
 */
@WebServlet("/GetSaleList")
public class GetSaleList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetSaleList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		PrintWriter out = response.getWriter();
		
		Client client = ClientBuilder.newClient();
		String restUrl = "http://localhost:8081/user-ws/getAllSale";
		WebTarget target = client.target(restUrl);
		Invocation.Builder invocationBuilder = target.request(MediaType.APPLICATION_JSON);
		Response resp = invocationBuilder.get();
		System.out.println("status:"+resp.getStatus());
		
		if(resp.getStatus() == Response.Status.OK.getStatusCode()) {
			System.out.println("Success");
			
			ArrayList<Sale> al = resp.readEntity(new GenericType<ArrayList<Sale>>() {});
			for(Sale sale :al) {
				System.out.println(sale.getOrder_id());
				
				 request.setAttribute("saleArray", al);
			        System.out.println("...requestObj set...forwarding...");
			        System.out.println(al);
			        String url = "Admin/saleManagement.jsp";
			        RequestDispatcher rd = request.getRequestDispatcher(url);
			        rd.forward(request, response);
		        
			}
			request.setAttribute("saleArray", al);
			System.out.println("...requestObj set...forwarding...");
			String url = "Admin/saleManagement.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(url);
			
		}else {
			System.out.println("failed");
			String url = "Admin/saleManagement.jsp";
			request.setAttribute("err", "NotFound");
			RequestDispatcher rd = request.getRequestDispatcher(url);
		}
	}
	
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
