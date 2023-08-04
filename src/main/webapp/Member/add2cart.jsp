<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Base64"%>
<%@page import="java.sql.*"%>
<%@ page import="java.util.Base64"%>
<%@page import="java.io.*"%>
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

<title>Hogwart Library</title>
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
			 display: flex; /* Use flex to align icon and text horizontally */
		    align-items: center; 
		    margin-right:20px;
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
		
		
		.dropdown-content {
		    display: none;
		    position: absolute;
		    background-color: #f9f9f9;
		    min-width: 160px;
		    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
		    z-index: 1;
		    right: 0;
		    padding: 10px;
		    border-radius: 4px;
		    padding: 10px;
		    border-radius: 4px;	
		    
		}
		
	
		.dropdown-content a {
		    color: #333;
		    text-decoration: none;
		    display: block;
		    padding: 8px;
		    transition: background-color 0.3s;
		}
		.dropdown-content a i {
		    margin-right: 5px; 
		}
		
		.dropdown-content a:hover {
		    background-color: #f1f1f1;
		}
		
		
		.profile-dropdown img {
		
		    border-radius: 50%; 
		    
		    
		}
		
		
		.profile-dropdown::after {
		    
		    font-family: "Font Awesome 5 Free";
		    font-weight: 900;
		    position: absolute;
		    right: 30px;
		    top: 50%;
		    transform: translateY(-50%);
		    font-size: 12px;
		}
		
		.show {
		    display: block;
		}
		
		h1{
		margin-left:40px;
		}
		
	 	.cart-item {
        display: flex;
        align-items: center;
        border: 1px solid #ddd;
        border-radius: 5px;
        padding: 10px;
        margin-bottom: 10px;
    	}
    	
	 	.cart-item img {
	        flex-shrink: 0;
	        width: 300px;
	        height: 450px; 
	        margin-right: 10px;
	        overflow: hidden;
	        object-fit: cover;
        	border-radius: 15px;
        	margin-left:40px;
	    }

         .item-details {
        display: flex;
        flex-direction: column;
        margin-left: 100px; 
	    }
	
	    .item-details h3 {
	        margin-top: 0;
	        margin-bottom: 25px;
	    }
	
	    .item-details p {
	        margin: 0;
	        margin-bottom: 24px;
	    }
	
	    .total {
	        font-weight: bold;
	        font-size: 18px;
	        margin-left: 40px;
	    }
	
	    .delete-button {
	        display: inline-block;
	        padding: 5px 10px;
	        background-color: #FF0000;
	        color: #FFFFFF;
	        text-decoration: none;
	        border-radius: 4px;
	        position: absolute;
    		right: 40px;
	    }
	
	    .delete-button:hover {
	        background-color: #CC0000;
	    }
		
		  .delete-button:hover {
		    background-color: #CC0000;
		  }
		  .total-container {
	        display: flex;
	        justify-content: space-between;
	        align-items: center;
	        margin-top: 20px; 
	    }
	
	    .total-text {
	        margin: 0;
	    }
	
	    .checkout-button {
	        background-color: #D3A625;
	        border: none;
	        color: white;
	        padding: 10px;
	        border-radius: 4px;
	        cursor: pointer;
	        text-decoration: none;
	        margin-right: 20px; 
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
%>
	<div class="navbar">
		<h1>Hogwart Library</h1>
		<ul>
			<li><a href="./displayMember.jsp"><i class="fas fa-home"></i>Home</a></li>
			<li><a href="../Genre.jsp"><i class="fas fa-book"></i>Genre</a></li>
			<li><a href="./add2cart.jsp"><i class="fas fa-shopping-cart"></i>Cart</a></li>
			<li><a href="mailto:wai71308@gmail.com"><i class="fas fa-comment-alt"></i>Contact</a></li>
			
			<li class="profile-dropdown">
			    <img src="../image/default.png" width="35" height="35" onclick="toggleDropdown()">
			    <div class="dropdown-content" id="profileDropdown" >
			        <!-- Add the user's name or any other relevant information -->
			        
			        <a href="./updateMember.jsp" style = "color:black"><i class="fas fa-edit"></i>Edit Profile</a>
			        <a href="#" style = "color:black"><i class="fas fa-image"></i>Change Avatar</a>
			        <a href="./Login.jsp" style = "color:black"><i class="fas fa-sign-out-alt"></i>Log out</a>
			    </div>
			</li>
			
		</ul>
	</div>

 <h1>Books Cart</h1>
     <% 
        ArrayList<Book> cart = (ArrayList<Book>) session.getAttribute("cart");
        if(cart != null && !cart.isEmpty()) {
            float total = 0;
            for(int i = 0; i < cart.size(); i++) {
            	out.println("<div class='cart-item'>");
                out.println("<img class = 'book-img' src='"+cart.get(i).getImage()+"'>");
                out.println("<div class='item-details'>");
                out.println("<h3>Title: " + cart.get(i).getTitle() + "</h3>");
                out.println("<p>ID: " + cart.get(i).getId() + "</p>");
                out.println("<p>Author: " + cart.get(i).getAuthor() + "</p>");
                out.println("<p>Price: $" + cart.get(i).getPrice() + "</p>");
                out.println("<p>Quantity: " + cart.get(i).getIsbn() + "</p>");
                out.println("<form action='"+request.getContextPath() + "/UpdateQuantityCart' method='post'>");
                out.println("<input type='hidden' name='id' value='" + cart.get(i).getId() + "'>");
                out.println("<div class='quantity'>");
                out.println("<button id='minus-btn' class='minus-btn' type='submit' name='action' value='minus'>-</button>");
                out.println("<input id='quantity-input" + cart.get(i).getId() + "' type='text' class='quantity-input' name='quantity' value='" + cart.get(i).getQuantity() + "'>");
                out.println("<button id='plus-btn' class='plus-btn' type='submit' name='action' value='plus'>+</button>");
                out.println("</div>");
                out.println("</div>");
                out.println("</form>");
                
                String deleteUrl = request.getContextPath() + "/DeleteCart?id=" + cart.get(i).getId();
                out.println("<a href='" + deleteUrl + "' class='delete-button'><i class='fa fa-trash' aria-hidden='true'></i></a>");
                out.println("</div>");
                total += (cart.get(i).getQuantity() * cart.get(i).getPrice());
            }
            out.println("<div class='total-container'>");
            out.println("<p class='total'>Total: $" + total + "</p>");
            out.println("<a href='" + request.getContextPath() + "/Member/checkout.jsp' class='checkout-button'>Checkout</a>");
            out.println("</div><br><br>");
            
        }
    %>
    
	

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
			<p>&copy; 2023 Hogwarts Library. All rights reserved.</p>
		</div>
	</footer>

<script>

function toggleDropdown() {
    const dropdown = document.getElementById('profileDropdown');
    dropdown.classList.toggle('show');
}

// Close the dropdown if the user clicks outside of it
window.onclick = function(event) {
    if (!event.target.matches('.profile-dropdown img')) {
        const dropdowns = document.getElementsByClassName('dropdown-content');
        for (let i = 0; i < dropdowns.length; i++) {
            const openDropdown = dropdowns[i];
            if (openDropdown.classList.contains('show')) {
                openDropdown.classList.remove('show');
            }
        }
    }
}


</script>

</body>

</html>
