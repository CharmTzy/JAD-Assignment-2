<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Base64"%>
<%@page import="java.sql.*"%>
<%@ page import="java.util.List" %>
<%@ page import="dbaccess.*" %>
<%@ page import="servlets.*" %>
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
	color: white;
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



.cart {
        display: inline-block;
    }

    .btn-primary {
        margin-left: 50px; /* Adjust the value as needed */
    }
/* Style the dropdown content */
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

/* Style the links inside the dropdown */
.dropdown-content a {
    color: #333;
    text-decoration: none;
    display: block;
    padding: 8px;
    transition: background-color 0.3s;
}
.dropdown-content a i {
    margin-right: 5px; /* Adjust the value to control the spacing */
}
/* Change link color on hover */
.dropdown-content a:hover {
    background-color: #f1f1f1;
}


.profile-dropdown img {

    border-radius: 50%; /* Make the image appear as a circle */
    
    
}

/* Position the dropdown arrow caret icon */
.profile-dropdown::after {
    
    font-family: "Font Awesome 5 Free";
    font-weight: 900;
    position: absolute;
    right: 30px;
    top: 50%;
    transform: translateY(-50%);
    font-size: 12px;
}

/* Show the dropdown content when the image is clicked */
.show {
    display: block;
}

/* Style the table */
table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
  border: 1px solid #ddd;
}

th, td {
  border: 1px solid #ddd;
  padding: 8px;
  text-align: left;
}

th {
  background-color: #f2f2f2;
}

/* Add some spacing between table cells */
tbody td {
  padding: 10px;
}

/* Alternate row background color for better readability */
tbody tr:nth-child(even) {
  background-color: #f2f2f2;
}

/* Hover effect on rows */
tbody tr:hover {
  background-color: #ddd;
}

</style>
</head>
<body>
	
<%

String CustomerID = (String) session.getAttribute("sessCustomerID");
String userRole = (String) session.getAttribute("role");
String loginStatus = (String) session.getAttribute("loginStatus");
System.out.println((String) session.getAttribute("role"));
if ( CustomerID == null || !userRole.equals("member") || !loginStatus.equals("success")){
	response.sendRedirect("../Login.jsp?errCode=invalidLogin");
}
%>
	<div class="navbar">
		<h1>Hogwart Library</h1>
		<ul>
			<li><a href="./Member/displayMember.jsp"><i class="fas fa-home"></i>Home</a></li>
			<li><a href="../Genre.jsp"><i class="fas fa-book"></i>Genre</a></li>
			<li><a href="./add2cart.jsp"><i class="fas fa-shopping-cart"></i>Cart</a></li>
			<li><a href="mailto:wai71308@gmail.com"><i class="fas fa-comment-alt"></i>Contact</a></li>
			
			<li class="profile-dropdown">
			    <img src="../image/default.png" width="35" height="35" onclick="toggleDropdown()">
			    <div class="dropdown-content" id="profileDropdown" >
			        <!-- Add the user's name or any other relevant information -->
			        
			        <a href="./updateMember.jsp" style = "color:black"><i class="fas fa-edit"></i>Edit Profile</a>
			        <a href="#" style = "color:black"><i class="fas fa-image"></i>Change Avatar</a>
			        <a href="../Login.jsp" style = "color:black"><i class="fas fa-sign-out-alt"></i>Log out</a>
			    </div>
			</li>
			
		</ul>
	</div>
<table border="1">
        <thead>
            <tr>
                
                <th>Book Title</th>
                <th>Quantity</th>
                <th>Order Date</th>
                <th>Total Amount</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <% 
                // Fetch order data from the JSON API
                List<Order> orderList = OrderDataFetcher.fetchOrdersData();

                // Get the logged-in account ID from the session
                int customerId = (int) session.getAttribute("sessCustomerid");

                // Display the order details in the table for the logged-in account
                for (Order order : orderList) {
                    if (order.getCustomer_id() == customerId) {
            %>
            <tr>
                
                <td><%= order.getTitle() %></td>
                <td><%= order.getQuantity() %></td>
               <td><%= order.getOrder_date() %></td>
                <td><%= order.getTotal_amount() %></td>
                <td><%= order.getStatus() %></td>
            </tr>
            <% 
                    }
                }
            %>
        </tbody>
    </table>
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
