package servlets;

import model.Book;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DeleteCart
 */
@WebServlet("/DeleteCart")
public class DeleteCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteCart() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		int itemId = Integer.parseInt(request.getParameter("id"));

        ArrayList<Book> cart = (ArrayList<Book>) request.getSession().getAttribute("cart");
        if (cart != null && !cart.isEmpty()) {
            Book itemToRemove = null;
            for (Book book : cart) {
                if (book.getId() == itemId) {
                    itemToRemove = book;
                    break;
                }
            }
            if (itemToRemove != null) {
                cart.remove(itemToRemove);
            }
        }

        response.sendRedirect(request.getContextPath() + "/Member/add2cart.jsp");
    }
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
