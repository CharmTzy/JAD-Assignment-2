<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Base64"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
	integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
	integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
	integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
	crossorigin="anonymous"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>

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
		<h1>Hogwarts Library</h1>
		<ul>
			<li><a href="Guest.jsp"><i class="fas fa-home"></i>Home</a></li>
			<li><a href="./Genre.jsp"><i class="fas fa-book"></i>Genre</a></li>
			<li><a href="mailto:wai71308@gmail.com"><i class="fas fa-comment-alt"></i>Contact</a></li>
			<li><a href="../Login.jsp"><i class="fas fa-sign-out-alt"></i>Log out</a></li>
			<li><img src="../image/default.png" width="30" height="30"></li>
			
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
				String connURL = "jdbc:mysql://localhost/book_db?user=JAD&password=root@123mml&serverTimezone=UTC";

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

					String imagePath = rs.getString("image");
					String imageUrl = "../image/" + imagePath;

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

					 <div class="modal fade" id="exampleModalCenter<%=rs.getString("id")%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
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
				                        <h5 class="card-title"><%=title%></h5>
				                        <p class="card-text">Author: <%=author%></p>
				                        <p class="card-text">Price: <%=price%></p>
				                        <p class="card-text">Quantity: <%=quantity%></p>
				                        <p class="card-text">Publisher: <%=publisher%></p>
				                        <p class="card-text">Publishing Date: <%=publicationDate%></p>
				                        <p class="card-text">ISBN: <%=isbn%></p>
				                        <p class="card-text">Rating: <%=rating%></p>
				                        <p class="card-text">Description: <%=description%></p>
				                        <p class="card-text">Genre  <%=genre%></p>
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
			<img src="../image/SP.jpeg" width="110" height="40">
			</div>
			<p>&copy; 2023 Hogwarts Library. All rights reserved.</p>
		</div>
	</footer>


	<script>
		function showBookDetails(title, author, price, quantity, publisher,
				publicationDate, isbn, genre, rating, description) {
			var details = "Title: " + title + "\n" + "Author: " + author + "\n"
					+ "Price: " + price + "\n" + "Quantity: " + quantity + "\n"
					+ "Publisher: " + publisher + "\n" + "Publication Date: "
					+ publicationDate + "\n" + "ISBN: " + isbn + "\n"
					+ "Genre: " + genre + "\n" + "Rating: " + rating + "\n"
					+ "Description: " + description;

			alert(details);
		}
	</script>
</body>

</html>
