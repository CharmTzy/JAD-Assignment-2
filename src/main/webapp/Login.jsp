<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Hogwart Library</title>
<style>
body, html {
	height: 100%;
	margin: 0;
	font-family: "Bodoni MT Black";
}

.bg {
	/* The image used */
	background-image: url("./image/hogwarts_night.jpg");
	height: 100%;
	background-position: center;
	background-repeat: no-repeat;
	background-size: cover;
	display: flex;
	justify-content: center;
	align-items: center;
}

.container {
	background-color: #222;
	width: 70%;
	display: flex;
	align-items: center;
}

.left-side {
	flex: 1;
	padding-right: 20px;
}

.left-side img {
	width: 100%;
}

.right-side {
	flex: 1;
	padding-left: 20px;
}

.right-side h1 {
	color: #D3A625;
	margin-top: 0;
}

.right-side input {
	width: 80%;
	margin-bottom: 10px;
	padding: 10px;
	font-size: 16px;
	border-radius: 4px;
	border: none;
}

.right-side .guest-button, .right-side .register-button, .right-side .submit-button
	{
	width: 100%;
	max-width: 250px;
	padding: 10px;
	background-color: #1A472A; /* Slytherin Green */
	color: white;
	border: none;
	cursor: pointer;
	font-size: 16px;
	border-radius: 4px;
	transition: background-color 0.3s;
}

.right-side .guest-button:hover, .right-side .register-button:hover,
	.right-side .submit-button:hover {
	background-color: #45a049;
}

.register-button-container
,
{
margin-top:20px;
}
.right-side a {
	color: #FFFF99;
}

.right-side p {
	color: #D3A625;
}
</style>
</head>
<body>

	<div class="bg">

		<div class="container">
			<div class="left-side">
				<img src="./image/Hogward_library.jpg" alt="Hogwart Library">
			</div>
			<div class="right-side">
				<h1>Hogwarts Library</h1>

				<%
				String logout = request.getParameter("logout");

				if (logout != null && logout.equals("true")) {
					// Invalidate the session to log out the user
					session.invalidate();
					response.sendRedirect("Login.jsp");
					return;
				}

				String errCode = request.getParameter("errCode");
				if (errCode != null && errCode.equals("invalidLogin")) {
					out.println("<p style='color: red; text-align: center;'>You have entered an invalid ID/Password</p>");
				}
				%>

				
				<form method="post" action="Verify.jsp">
					<input type="text" name="usernameOrEmail"
						pattern="[a-zA-Z0-9\s@.]+"
						title="Only characters and numbers are allowed"
						placeholder="Username or Email" required> 
						
					<input
						type="password" name="password" placeholder="Password" required>

				
				
				<div class="guest-button-container">
					<p>
						Continue as <a href="Guest.jsp">Guest</a>
					</p>
				</div>

				<div class="register-button-container">
					<p>
						Don't have an account? <a href="Member/customer_registration.jsp">Register</a>
					</p>
				</div>
				<button class="submit-button" type="submit" value="Login">Submit</button>
				</form>
			</div>	
		</div>
	</div>
</body>
</html>
