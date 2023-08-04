<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Base64"%>
<%@page import="java.sql.*"%>
<%@page import="model.Book"%>
<%@page import="java.util.List"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>
	
	<script src="https://js.braintreegateway.com/web/dropin/1.39.0/js/dropin.js"></script>
		

<title>Hogwarts Library</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<style>
body, html {
	height: 100%;
	margin: 0;
}

.navbar {
	background-color: #222;
	color: white;
	padding: 10px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.navbar h1 {
	color: #D3A625;
	margin: 0;
}

.navbar ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
	display: flex;
}

.navbar ul li {
	margin-left: 10px;
}

.navbar ul li a {
	color: white;
	text-decoration: none;
}

.welcome {
	background-image: url("../image/hogwarts_night.jpg");
	height: 100%;
	background-position: center;
	background-repeat: no-repeat;
	background-size: cover;
	display: flex;
	justify-content: center;
	align-items: center;
}

.content {
	background-color: rgba(0, 0, 0, 0.7);
	padding: 20px;
	border-radius: 8px;
	color: white;
}

.search-container {
	display: flex;
	align-items: center;
	justify-content: center;
	margin-top: 20px;
}

.search-input {
	padding: 10px;
	font-size: 16px;
	border: none;
	border-radius: 4px 0 0 4px;
}

.dropdown {
	padding: 10px;
	font-size: 16px;
	border: none;
	border-radius: 0 4px 4px 0;
}

.search-button {
	background-color: #D3A625;
	border: none;
	color: white;
	padding: 10px;
	border-radius: 4px;
	cursor: pointer;
}

.search-button i {
	margin: 0 5px;
}

.footer {
	background-color: #222;
        color: #fff;
        padding: 10px;
        position: fixed;
        bottom: 0;
        left: 0;
        width: 100%;
}

.footer-container {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.social-icons {
	display: flex;
}

.icon {
	color: white;
	font-size: 20px;
	margin-right: 10px;
}

.footer p {
	margin: 0;
}

.books .card {
	height: 650px;
}



.search-input {
padding: 10px;
  width: 300px;
  font-size: 16px;
}


.container {
	margin-top: 20px;
}

.books .card {
	height: 650px;
}

.checkout-item {
	display: flex;
	align-items: center;
	border: 1px solid #ddd;
	border-radius: 5px;
	padding: 10px;
	margin-bottom: 10px;
}

.checkout-item img {
	flex-shrink: 0;
	width: 150px;
	height: 225px;
	margin-right: 10px;
	overflow: hidden;
	object-fit: cover;
	border-radius: 5px;
}

.item-details {
	display: flex;
	flex-direction: column;
}

.item-details h3 {
	margin-top: 0;
	margin-bottom: 10px;
}

.item-details p {
	margin: 0;
	margin-bottom: 5px;
}

.subtotal,.tax,.real-total {
	font-weight: bold;
	font-size: 18px;
}

/* Button Styles */
.button {
	cursor: pointer;
	font-weight: 500;
	left: 3px;
	line-height: inherit;
	position: relative;
	text-decoration: none;
	text-align: center;
	border-style: solid;
	border-width: 1px;
	border-radius: 3px;
	-webkit-appearance: none;
	-moz-appearance: none;
	display: inline-block;
	margin-top:13px;
}

.button--small {
	padding: 10px 20px;
	font-size: 0.875rem;
}

.button--green {
	outline: none;
	background-color: #64d18a;
	border-color: #64d18a;
	color: white;
	transition: all 200ms ease;
}

.button--green:hover {
	background-color: #8bdda8;
	color: white;
}
</style>
</head>
<body>
<%

String CustomerID = (String) session.getAttribute("sessCustomerID");
String loginStatus = (String) session.getAttribute("loginStatus");

if ( CustomerID == null || !loginStatus.equals("success")){
	response.sendRedirect("../Login.jsp?errCode=invalidLogin");
}
ArrayList<Book> cart = (ArrayList<Book>) session.getAttribute("cart");

    // Calculate the total price
    float subtotal = 0;
    if (cart != null && !cart.isEmpty()) {
        for (Book book : cart) {
            subtotal += (book.getQuantity() * book.getPrice());
        }
    }
    float gstRate = 0.08f; 
    float gstAmount = subtotal * gstRate;
    String formattedGstAmount = String.format("%.2f", gstAmount);
	float realTotal = subtotal + gstAmount;
	String formattedRealTotal = String.format("%.2f", realTotal);
%>

	<div class="navbar">
		<h1>Hogwart Library Checkout</h1>
		<ul>
			<li><a href="Guest.jsp"><i class="fas fa-home"></i>Home</a></li>
			<li><a href="../Genre.jsp"><i class="fas fa-book"></i>Genre</a></li>
			<li><a href="mailto:wai71308@gmail.com"><i class="fas fa-comment-alt"></i>Contact</a></li>
			<li><a href="../Login.jsp"><i class="fas fa-sign-out-alt"></i>Log out</a></li>
			<li><img src="../image/default.png" width="30" height="30"></li>
			
		</ul>
	</div>

 <div class="container">
        <div class="row">
        <div class="col-lg-6">
				<form action="<%=request.getContextPath()%>/checkout" method="post">
               	<div id="dropin-container" ></div>
             
				<button id="submit-button" class="button button--small button--green">Purchase</button>
				</form>
            </div>
           
            <div class="col-lg-6">
                <h2>Order Summary</h2>
   
            <% if (cart != null && !cart.isEmpty()) { %>
                <% for (Book book : cart) { %>
                    <div class="checkout-item">
                        <img class="book-img" src="<%= book.getImage() %>">
                        <div class="item-details">
                            <h3>Title: <%= book.getTitle() %></h3>
                            <p>ISBN: <%= book.getIsbn() %></p>
                            <p>Author: <%= book.getAuthor() %></p>
                            <p>Price: $<%= book.getPrice() %></p>
                            <p>Quantity: <%= book.getQuantity() %></p>
                            </div>
                    </div>
                <% } %>
            <% } else { %>
                <p>No items in the checkout.</p>
            <% } %>
            <p class="subtotal">Subtotal: 	$<%= subtotal %></p>
			<p class="tax">GST (8%):	 $<%= formattedGstAmount %></p>
			<p class="real-total">Total (including GST): $<%= formattedRealTotal %></p>
        
            </div>
            
        </div>
    </div><br><br>
    
    

	<footer class="footer">
		<div class="footer-container">
			<div class="social-icons">
				<a href="https://www.facebook.com/profile.php?id=100025060720474"
					class="icon"><i class="fab fa-facebook"></i></a> <a
					href="https://www.instagram.com/stay_free04/" class="icon"><i
					class="fab fa-instagram"></i></a> <a href="mailto:wai71308@gmail.com"
					class="icon"><i class="far fa-envelope"></i></a> <a
					href="https://github.com/CharmTzy/JAD-Assignment-2" class="icon"><i
					class="fab fa-github"></i></a>
			</div>
			<div class="img-footer">
			<img src="../image/SP.png" width="110" height="40">
			</div>
			<p>&copy; 2023 Hogwart Library. All rights reserved.</p>
		</div>
	</footer>


	<script>
	var button = document.querySelector('#submit-button');

	braintree.dropin.create({
	  authorization: 'sandbox_g42y39zw_348pk9cgf3bgyw2b',
	  selector: '#dropin-container'
	}, function (err, instance) {
	  button.addEventListener('click', function () {
	    instance.requestPaymentMethod(function (err, payload) {
	      // Submit payload.nonce to your server
	    });
	  })
	});
	

	
	</script>
	

</body>

</html>
