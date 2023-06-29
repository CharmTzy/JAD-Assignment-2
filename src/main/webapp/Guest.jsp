<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Base64" %>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>

<title>Hogwarts Library</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<style>
body, html {
	height: 100%;
	margin: 0;
	font-family: "Bodoni MT Black";
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

.container {
	background-image: url("./image/hogwarts_night.jpg");
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


</style>
</head>
<body>

	<div class="navbar">
		<h1>Hogwarts Library</h1>
		<ul>
			<li><a href="#">Home</a></li>
			<li><a href="#">Books</a></li>
			<li><a href="#">About</a></li>
			<li><a href="#">Contact</a></li>
		</ul>
	</div>

	<div class="container">
		<div class="content">
			<h2>Welcome to Hogwarts Library!</h2>
			<p>Explore our vast collection of magical books and embark on a
				journey of knowledge and adventure.</p>

			<div class="search-container">
				<input class="search-input" type="text" placeholder="Search">
				<select class="dropdown">
					<option value="title">Title</option>
					<option value="author">Author</option>
				</select>
				<button class="search-button" onclick="search()">
					<i class="fas fa-search"></i> Search
				</button>
			</div>
		</div>
	</div>





   <footer class="footer">
    <div class="footer-container">
      <div class="social-icons">
        <a href="https://www.facebook.com/profile.php?id=100025060720474" class="icon"><i class="fab fa-facebook"></i></a>
        <a href="https://www.instagram.com/stay_free04/" class="icon"><i class="fab fa-instagram"></i></a>
        <a href="mailto:wai71308@gmail.com" class="icon"><i class="far fa-envelope"></i></a>
        <a href="https://github.com/CharmTzy/JAD-Assignment-2" class="icon"><i class="fab fa-github"></i></a>
      </div>
      <p>&copy; 2023 Hogwarts Library. All rights reserved.</p>
    </div>
  </footer>
  
	<script>
  function search() {
    var searchInput = document.querySelector('.search-input').value;
    var dropdownValue = document.querySelector('.dropdown').value;
    alert("Searching for " + dropdownValue + ": " + searchInput);
  }

  function showBookDetails(title, author, price, quantity, publisher, publicationDate, isbn, genre, rating, description) {
    var details = "Title: " + title + "\n" +
                  "Author: " + author + "\n" +
                  "Price: " + price + "\n" +
                  "Quantity: " + quantity + "\n" +
                  "Publisher: " + publisher + "\n" +
                  "Publication Date: " + publicationDate + "\n" +
                  "ISBN: " + isbn + "\n" +
                  "Genre: " + genre + "\n" +
                  "Rating: " + rating + "\n" +
                  "Description: " + description;

    alert(details);
  }



  </script>
</body>

</html>
