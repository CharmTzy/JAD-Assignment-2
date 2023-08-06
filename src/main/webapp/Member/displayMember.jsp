<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Base64"%>
<%@page import="java.sql.*"%>
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

.quantity {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
    justify-content: center;
}

.quantity-input {
    width: 40px;
    height: 30px;
    text-align: center;
    border: 1px solid #ccc;
    border-radius: 4px;
    margin: 0 5px;
}

.minus-btn,
.plus-btn {
    width: 30px;
    height: 30px;
    border: none;
    background-color: #f1f1f1;
    cursor: pointer;
}

.minus-btn:hover,
.plus-btn:hover {
    background-color: #ddd;
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

	<div class="container-fluid welcome">
		<div class="row">
			<div class="col-lg-12 col-md-12 col-sm-12">
				<div class="content">
					<h2>Welcome to Hogwarts Library!</h2>
					<p>Explore our vast collection of magical books and embark on a
						journey of knowledge and adventure.</p>

					<form method="get" action="displayMember.jsp">
						<div class="search-container">
							<input class="search-input" type="text" placeholder="Search By Title or Author"
								name="search">

							<button type="submit" class="search-button">
								<i class="fas fa-search"></i> Search
							</button>
						</div>
					</form>

				</div>
			</div>

		</div>
	</div>

	<div class="container-fluid"
		style="margin: auto; text-align: center; margin-top: 20px;">

		<div class="row">
			<%
			String searchQuery = request.getParameter("search");
			boolean hasResults = false;

			try {
				// Step 1: Load JDBC Driver
				Class.forName("com.mysql.jdbc.Driver");

				// Step 2: Define Connection URL
				String connURL = "jdbc:mysql://hogwartlibrary.cq8iljpqenuc.us-east-1.rds.amazonaws.com:3306/book_db?user=admin&password=JwaHOknEhIk0NoiTC1oH&serverTimezone=UTC";

				// Step 3: Establish connection to URL
				Connection conn = DriverManager.getConnection(connURL);

				// Step 4: Create Statement object
				Statement stmt = conn.createStatement();

				// Step 5: Execute SQL Query
				String sqlStr = "SELECT books.*, genre.genre FROM books INNER JOIN genre ON books.genre_id = genre.id";

				// If search query is provided, modify the SQL query to filter results
				if (searchQuery != null && !searchQuery.trim().isEmpty()) {
					sqlStr += " WHERE title LIKE '%" + searchQuery + "%' OR author LIKE '%" + searchQuery + "%'";
				}

				ResultSet rs = stmt.executeQuery(sqlStr);

				// Step 6: Process Result
				while (rs.next()) {
					hasResults = true;
					int id = rs.getInt("id");
					String imagePath = rs.getString("image");
					String imageUrl = imagePath;
					String title = rs.getString("title");
					String author = rs.getString("author");
					double price = rs.getDouble("price");
					int quantity = rs.getInt("quantity");
					String publisher = rs.getString("publisher");
					String publicationDate = rs.getString("publication_date");
                    String isbn = rs.getString("isbn");
                    String genre = rs.getString("genre");
                    double rating = rs.getDouble("rating");
                    String description = rs.getString("description");
					
			%>
			<div class="col-lg-3 col-md-6 col-sm-12 books">
				<div class="card" data-toggle="modal" data-target="#exampleModalCenter<%=rs.getString("id")%>">
					<img class="card-img-top" src="<%=imageUrl%>" width="300"
						height="500" alt="Book Image">
					<div class="card-body">
						<h5 class="card-title"><%=title%></h5>
						<p class="card-text">
							Author:
							<%=author%></p>
						<p class="card-text">
							Price:
							<%=price%></p>
					</div>

					 <div class="modal fade" id="exampleModalCenter<%=rs.getString("id")%>" role="dialog" aria-labelledby="exampleModalCenterTitle" data-backdrop="static" data-keyboard="false">
					<script>
					 var modal = document.getElementById('exampleModalCenter<%=rs.getString("id")%>');
					    modal.addEventListener('click', function(event) {
					        event.stopPropagation();
					    });
					    </script>
				    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
				        <div class="modal-content">
				            <div class="modal-header">
				                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				                    <span aria-hidden="true">&times;</span>
				                </button>
				            </div>
				            <div class="modal-body" >
				                <div class="row">
				                    <div class="col-lg-6">
				                        <img class="card-img-top" src="<%=imageUrl%>" width="500" height="500" alt="Book Image">
				                    </div>
				                    <div class="col-lg-6">
										
											<h5 class="card-title" id="title"><%=title%></h5>
											<p class="card-text" id="author">Author: <%=author%></p>
											<p class="card-text" id="price">Price: <%=price%></p>
											<p class="card-text"><%=quantity%> Books Left</p>
											<p class="card-text">Publisher: <%=publisher%></p>
											<p class="card-text">Publishing Date: <%=publicationDate%></p>
											<p class="card-text">ISBN: <%=isbn%></p>
											<p class="card-text">Rating: <%=rating%></p>
											<p class="card-text">Description: <%=description%></p>
											<p class="card-text">Genre:  <%=genre%></p>
											
											<div class="quantity">
												<button id="minus-btn" class="minus-btn" onclick="minusButtonClick(<%= id %>)" type="button">-</button>
												<input id="quantity-input<%= id %>" type="text" class="quantity-input"  value="1">
												<button id="plus-btn" class="plus-btn" onclick="plusButtonClick(<%= id %>)" type="button">+</button>
											</div>
											<form method="post" action="AddtoCartInput.jsp" class="d-inline" onsubmit="return addToCart(<%=id%>, <%=quantity%>)">
												<input type="text" name="image" value="<%=imageUrl %>" style="display:none;">
												<input type="text" name="title" value="<%=title%>" style="display: none;">
												<input type="text" name="id" value="<%=id%>" style="display: none;">
												<input type="text" name="author" value="<%=author%>" style="display: none;">
												<input type="text" name="isbn" value="<%=isbn%>" style="display: none;">
												<input type="text" name="price" value="<%=price%>" style="display: none;">
												<input type="text" name="quantity" id="quantity-value<%= id %>" value="1" style="display: none;">
												
												<div class = "cart">
													<button type="submit"><i class="fas fa-shopping-cart"></i></button>
												</div>
											</form>
											
											<p id="error-message<%=id%>" style="color: red; text-align: center; display: none;">Not enough number of books</p>
				                    </div>
				                </div>
				            </div>
				        </div>
				    </div>
				</div>


				</div>
			</div>

			<%
			}

				
			// Step 7: Close connection
			rs.close();
			stmt.close();
			conn.close();

			} catch (ClassNotFoundException e) {
			e.printStackTrace();
			} catch (SQLException e) {
			e.printStackTrace();
			}

			if (!hasResults) {
			%>
			<p>No books found.</p>
			<%
			}
			%>
		</div>

	</div>



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


	// Function to handle the plus button click
	function plusButtonClick(id) {
		let quantityInput = document.getElementById("quantity-input" + id);
		let quantity = Number(quantityInput.value) + 1;
		quantityInput.value = quantity;
		document.getElementById("quantity-value" + id).value = quantity;
	}
    // Function to handle the minus button click
    function minusButtonClick(id) {
        let quantityInput = document.getElementById("quantity-input" + id);
        let quantity = Number(quantityInput.value)-1;
     
        if (quantity >= 1) {
            quantityInput.value = quantity;
			document.getElementById("quantity-value" + id).value = quantity;
        }
    }

    function addToCart(id, quantityLeft) {
        let quantityInput = document.getElementById("quantity-input" + id);
        var quantity = parseInt(quantityInput.value);

        if (quantity <= quantityLeft) {
            // Hide the error message when the quantity is valid
            var errorMessage = document.getElementById("error-message" + id);
            errorMessage.style.display = "none";

            // Submit the form when the quantity is valid
            document.querySelector('form').submit();
        } else {
            // Show the error message
            var errorMessage = document.getElementById("error-message" + id);
            errorMessage.style.display = "block";
            
            // Prevent form submission when the quantity is invalid
            event.preventDefault();
        }
    }



    const urlParams = new URLSearchParams(window.location.search);
    const orderStatus = urlParams.get('orderStatus');

    
    if (orderStatus === 'true') {
        alert('You have bought the books successfully!');
    }

</script>

</body>

</html>
