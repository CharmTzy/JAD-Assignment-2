package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Book;
import java.util.ArrayList;
/**
 * Servlet implementation class UpdateQuantityCart
 */
@WebServlet("/UpdateQuantityCart")
public class UpdateQuantityCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateQuantityCart() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int itemId = Integer.parseInt(request.getParameter("id"));
      
        String action = request.getParameter("action");

        // Get the cart from the session
        ArrayList<Book> cart = (ArrayList<Book>) request.getSession().getAttribute("cart");
        if (cart != null && !cart.isEmpty()) {
            for (Book book : cart) {
                if (book.getId() == itemId) {
                    if ("plus".equals(action)) {
                        book.setQuantity(book.getQuantity() + 1);
                    } else if ("minus".equals(action)) {
                        
                        if (book.getQuantity() > 1) {
                            book.setQuantity(book.getQuantity() - 1);
                        }
                    }
                    break;
                }
            }
        }

        response.sendRedirect(request.getContextPath() + "/Member/add2cart.jsp");
    }
}
