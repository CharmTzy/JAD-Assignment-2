package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Book;
import dbaccess.BookDAO;

@WebServlet("/Admin/bestSelling")
public class bestSelling extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public bestSelling() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Book> bestSellers = null;
        try {
            bestSellers = BookDAO.getBestSellingBooks(5);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("bestSellers", bestSellers);
        request.getRequestDispatcher("/Admin/bestSelling.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
