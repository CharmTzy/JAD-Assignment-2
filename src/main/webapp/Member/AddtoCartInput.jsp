<%@page import="model.Book"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Add to Cart</title>
</head>
<body>
    <%@ page import="java.sql.*"%>
    <%
    String image = request.getParameter("image");
    String title = request.getParameter("title");
    String author = request.getParameter("author");
    String idParam = request.getParameter("id");
    String priceParam = request.getParameter("price");
    String isbn = request.getParameter("isbn");
    String quantityParam = request.getParameter("quantity");

    // Initialize integer variables to hold the parsed values
    int id = 0;
    float price = 0.0f;
    int quantity = 0;

    try {
        // Check if the id parameter is not null or empty before parsing
        if (idParam != null && !idParam.isEmpty()) {
           id=Integer.parseInt(idParam);
           out.println(id);
            
        }

        // Check if the price parameter is not null or empty before parsing
        if (priceParam != null && !priceParam.isEmpty()) {
            price = Float.parseFloat(priceParam);
            out.println(price);
        }

        // Check if the quantity parameter is not null or empty before parsing
        if (quantityParam != null && !quantityParam.isEmpty()) {
            quantity = Integer.parseInt(quantityParam);
            out.println(quantity);
        }

        HttpSession cartsession = request.getSession();
        cartsession.setAttribute("image",image);
        cartsession.setAttribute("title", title);
        cartsession.setAttribute("id", id);
        cartsession.setAttribute("author", author);
        cartsession.setAttribute("price", price);
        cartsession.setAttribute("isbn", isbn);
        cartsession.setAttribute("quantity", quantity);
		
		ArrayList<Book> Test = (ArrayList<Book>)cartsession.getAttribute("cart");
		boolean condition = true;
		if(Test != null && !Test.isEmpty()) {
			for(int i = 0; i < Test.size(); i++) {
				if(Test.get(i).getId() == id) {
					condition = false;
					Test.get(i).setQuantity(quantity + Test.get(i).getQuantity());
					break;
				}
			}
			if(condition){ 
				Book book = new Book();
				book.setImage(image);
				book.setId(id);
				book.setTitle(title);
				book.setAuthor(author);
				book.setPrice(price);
				book.setIsbn(isbn);
				book.setQuantity(quantity);
				Test.add(book);
			}
		}
		else {
			Test = new ArrayList<Book>();
			Book book = new Book();
			book.setImage(image);
			book.setId(id);
			book.setTitle(title);
			book.setAuthor(author);
			book.setPrice(price);
			book.setIsbn(isbn);
			book.setQuantity(quantity);
			Test.add(book);
		}
		cartsession.setAttribute("cart", Test);
        response.sendRedirect("./displayMember.jsp");
    } catch (NumberFormatException e) {
        // Handle the exception gracefully (e.g., display an error message)
        out.println("Invalid input: Please provide valid values for id, price, and quantity.");
    }
    %>
</body>
</html>
