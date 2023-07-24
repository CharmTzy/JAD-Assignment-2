package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.client.Invocation;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

/**
 * Servlet implementation class GetCheckoutInfo
 */
@WebServlet("/GetCheckoutInfo")
public class GetCheckoutInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetCheckoutInfo() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uid = request.getParameter("uid");
		Client client = ClientBuilder.newClient();
		String restUrl = "http://localhost:8081/user-ws/getUser/"+uid;
		WebTarget target = client.target(restUrl);
		Invocation.Builder invocationBuilder = target.request(MediaType.APPLICATION_JSON);
		Response resp = invocationBuilder.get();
		System.out.println("status:"+resp.getStatus());
		
		if(resp.getStatus() == Response.Status.OK.getStatusCode()) {
			System.out.println("Success");
			User user = resp.readEntity(User.class);
		
			String url = "pract8/testweb.jsp";
	        request.setAttribute("user", user);
	        RequestDispatcher rd = request.getRequestDispatcher(url);
	        rd.forward(request, response);
			  
		}else {
			System.out.println("failed");
			String url = "pract8/testweb.jsp";
			request.setAttribute("err", "NotFound");
			RequestDispatcher rd = request.getRequestDispatcher(url);
		}
	}
}
