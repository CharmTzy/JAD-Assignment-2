<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"%>
<%@page import = "dbaccess.*" %>
<%@page import = "java.util.ArrayList" %>

<%@page import = "java.util.Iterator" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <title>Admin DashBoard</title>
</head>
<body>
<%

String AdminID = (String) session.getAttribute("sessAdminID");
String loginStatus = (String) session.getAttribute("loginStatus");
if ( AdminID == null || !loginStatus.equals("success")){
	response.sendRedirect("../Login.jsp?errCode=invalidLogin");
}

%>

<style>
       body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .container {
		  display: flex;
		  align-items: center;
		}
        
        h1 {
            color: #333;
             display: inline-block;
        }
        h2 {
            color: #666;
            margin-top: 50px;
        }
        form {
            margin-top: 20px;
            margin-left: 20px;
        }
        label {
            display: inline-block;
            width: 200px;
        }
	    .user-details {
	      border: 1px solid #ddd;
	      padding: 10px;
	    }
	
	    .user-details h3 {
	      margin-top: 0;
	      margin-bottom: 10px;
	    }
	
	    .user-details p {
	      margin: 0;
	    }
	  
    </style>
    
    <h2>Get User By User ID</h2>
	  <form action="<%= request.getContextPath() %>/GetUserById">
	    <p>Enter User ID: <input type="text" name="uid"></p>
	    <button>Submit</button>
	  </form><br>
	
	  <% 
	  // Display user details if available
	  User user = (User) request.getAttribute("user");
	  if (user != null) {  
	  %>
	  <div class="user-details">
	    <h3>User Details</h3>
	    <p><strong>User ID:</strong> <%= user.getId() %></p>
	    <p><strong>User name:</strong> <%= user.getUsername() %></p>
	    <p><strong>Email:</strong> <%= user.getEmail() %></p>
	    <p><strong>Address:</strong> <%= user.getAddress() %></p>
	    <p><strong>Phone Number:</strong> <%= user.getPhnumber() %></p>
	  </div>
	  <% } %>
</body>
</html>