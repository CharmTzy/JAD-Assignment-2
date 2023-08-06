<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Simple Sidebar - Start Bootstrap Template</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
    </head>
    <body>
    <%

String AdminID = (String) session.getAttribute("sessAdminID");
    String userRole = (String) session.getAttribute("role");
    String loginStatus = (String) session.getAttribute("loginStatus");
    System.out.println((String) session.getAttribute("role"));
    if (AdminID == null ||  !userRole.equals("admin") || loginStatus == null || !loginStatus.equals("success")) {
        response.sendRedirect("../Login.jsp?errCode=invalidLogin");
    }


%>

<style>
        
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
         input[type="file"],
        textarea {
            width: 300px;
            padding: 5px;
            margin-bottom: 10px;
            margin-left:10px;
        }
        input[type="text"],
        textarea {
            width: 300px;
            padding: 5px;
            margin-bottom: 10px;
            margin-left:10px;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            margin-top:20px;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        p {
            color: #999;
        }
        .description-field {
        display: flex;  
        align-items: center;
        }
        .description-field textarea {
        margin-left: 15px;
        }
        .quantity-buttons {
		  display: flex;
		  align-items: center;
		}
		 .button-group {
		  display: flex;
		  flex-direction: column;
		}
		.quantity-buttons form {
		  margin-right: 10px;
		}
		
		.quantity-value {
		  margin: 0 10px;
		}
		
		.quantity-button.plus {
		  margin-bottom: 10px;
		}
		
		.quantity-button.minus {
		  margin-bottom: 10px;
		  
		}
		.value-field{
		margin-top:10px;
		width: 40px;
		}
		
	  .role {
	    display: flex;
	    align-items: center;
	   
	  }
	
	  .role a {
	    display: flex;
	    justify-content: center;
	    width: 50px;
	    border-radius: 5px;
	  }
	
	  .slider-container {
	    display: none;
	    padding: 20px;
	    background-color: #f2f2f2;
	    margin-top: 50px;
	    position: absolute;
	  }
	  .update-profile-btn,
	  .logout-btn {
	    display: inline-block;
	    padding: 10px 20px;
	    background-color: #4caf50;
	    color: #fff;
	    text-decoration: none;
	    border-radius: 4px;
	    font-size: 14px;
	    margin-right: 10px;
	  }
	
	  .update-profile-btn:hover,
	  .logout-btn:hover {
	    background-color: #45a049;
	  }
	  
	  .input-field {
    width: 300px;
    padding: 5px;
    margin-bottom: 10px;
}
	  
    </style>
        <div class="d-flex" id="wrapper">
            <!-- Sidebar-->
            <div class="border-end bg-white" id="sidebar-wrapper">
                <div class="sidebar-heading border-bottom bg-light">Hogwart Library</div>
                <div class="list-group list-group-flush">
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="./displayAdmin.jsp">Dashboard</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="./saleManagement.jsp">Sale Management</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="#!">Overview</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="#!">Events</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="#!">Profile</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="#!">Status</a>
                </div>
            </div>
            <!-- Page content wrapper-->
            <div id="page-content-wrapper">
                <!-- Top navigation-->
                <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
                    <div class="container-fluid">
                        <button class="btn btn-primary" id="sidebarToggle">Toggle Menu</button>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav ms-auto mt-2 mt-lg-0">
                                <li class="nav-item active"><a class="nav-link" href="./displayAdmin.jsp">Home</a></li>
                                <li class="nav-item"><a class="nav-link" href="#!">Link</a></li>
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Dropdown</a>
                                    <div class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                                        <a class="dropdown-item" href="#!">Action</a>
                                        <a class="dropdown-item" href="#!">Another action</a>
                                        <div class="dropdown-divider"></div>
                                        <a class="dropdown-item" href="#!">Something else here</a>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>
                <!-- Page content-->
                <div class="container-fluid">
                      
    <h1>Admin Dashboard</h1>
 

    <%-- Create a new book form --%>
    <h2>Create a new book:</h2>
    <form method="post" action="<%= request.getContextPath() %>/UploadBook" enctype="multipart/form-data">
    	<label>Image:</label>
	    <input type="file" name="image" accept="image/*" required><br><br>
        <label>Title:</label>
        <input type="text" name="title" required><br><br>
        <label>Author:</label>
        <input type="text" name="author" required><br><br>
        <label>Price:</label>
        <input type="text" name="price" required><br><br>
        <label>Quantity:</label>
        <input type="text" name="quantity" required><br><br>
        <label>Publisher:</label>
        <input type="text" name="publisher" required><br><br>
        <label>Publication Date:</label>
        <input type="text" name="publicationDate" required><br><br>
        <label>ISBN:</label>
        <input type="text" name="isbn" required><br><br>
        <label>Genre:</label>
        <input type="text" name="genre" required><br><br>
        <label>Rating:</label>
        <input type="text" name="rating" required><br><br>
        <div class="description-field">
        <label for="description">Description:</label>
           <textarea name="description" id="description" required></textarea>
        </div>
        <input type="submit" value="Create">
    </form>

	


<%-- Display existing books --%>
<h2>Existing books:</h2>
<table>
    <tr>
        <th>Title</th>
        <th>Author</th>
        <th>Inventory</th>
        <th>Actions</th>
        
    </tr>
    <%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String connURL = "jdbc:mysql://localhost/book_db?user=JAD&password=root@123mml&serverTimezone=UTC";
        Connection conn = DriverManager.getConnection(connURL);
        Statement stmt = conn.createStatement();

        String sqlStr = "SELECT * FROM books";
        ResultSet rs = stmt.executeQuery(sqlStr);

        while (rs.next()) {
            String bookId = rs.getString("id");
            String title = rs.getString("title");
            String author = rs.getString("author");
            int inventory = rs.getInt("quantity");
    %>
    <tr>
        <td><%= title %></td>
        <td><%= author %></td>
        <td>
            <div class="quantity-buttons">
            
                <form method="post" action="displayAdmin.jsp">
                    <input type="hidden" name="bookId" value="<%= bookId %>">
                    <input type="hidden" name="currentInventory" value="<%= inventory %>">
                    <button class="quantity-button plus" type="submit" name="addQuantity">+</button>
                </form>
                <div class="value-field">
                <span class="quantity-value"><%= inventory %></span>
              </div>
                <div class="button-group">
                <form method="post" action="displayAdmin.jsp">
                    <input type="hidden" name="bookId" value="<%= bookId %>">
                    <input type="hidden" name="currentInventory" value="<%= inventory %>">
                    <button class="quantity-button minus" type="submit" name="reduceQuantity">-</button>
                </form>
                  </div>
            </div>
        </td>
        <td>
            <a href="editBookForm.jsp?bookId=<%= bookId %>"><button>Edit</button></a>
            <a href="deleteBook.jsp?bookId=<%= bookId %>"><button>Delete</button></a>
        </td>
        
    </tr>
    <% }
        conn.close();
    } catch (Exception e) {
        out.println("Error: " + e);
    }

    // Update book quantity
    if (request.getParameter("addQuantity") != null || request.getParameter("reduceQuantity") != null) {
        String bookId = request.getParameter("bookId");
        int currentInventory = Integer.parseInt(request.getParameter("currentInventory"));

        int newInventory = currentInventory;
        if (request.getParameter("addQuantity") != null) {
            newInventory++;
        } else if (request.getParameter("reduceQuantity") != null) {
            newInventory--;
            if (newInventory < 0) {
                newInventory = 0;
            }
        }

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String connURL = "jdbc:mysql://localhost/book_db?user=JAD&password=root@123mml&serverTimezone=UTC";
            Connection conn = DriverManager.getConnection(connURL);
            PreparedStatement pstmt = conn.prepareStatement("UPDATE books SET quantity = ? WHERE id = ?");
            pstmt.setInt(1, newInventory);
            pstmt.setString(2, bookId);
            pstmt.executeUpdate();
            pstmt.close();
            conn.close();
        } catch (ClassNotFoundException e) {
            out.println("Error: " + e);
        } catch (SQLException e) {
            out.println("Error: " + e);
        }
    }
    
    %>
    
</table>

<h2>Create a new user:</h2>
<form method="post" action="displayAdmin.jsp">
    <label>Username:</label>
    <input type="text" name="username" class="input-field" required><br><br>
    <label>Email:</label>
    <input type="email" name="email" class="input-field" required><br><br>
    <label>Password:</label>
    <input type="password" name="password" class="input-field" required><br><br>
    <label>Phone number:</label>
    <input type="text" name="phoneNumber" class="input-field" required><br><br>
    <input type="submit" value="Create">
</form>


<%-- Insert new user data into the database --%>
<%
    
    if (request.getParameter("username") != null) {
        // Retrieve form field values
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phoneNumber = request.getParameter("phoneNumber");
        String role = "member";
        

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String connURL = "jdbc:mysql://hogwartlibrary.cq8iljpqenuc.us-east-1.rds.amazonaws.com:3306/book_db?user=admin&password=JwaHOknEhIk0NoiTC1oH&serverTimezone=UTC";
            Connection conn = DriverManager.getConnection(connURL);
            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO user (username, email, password, phnumber, role) VALUES (?, ?, ?, ?, ?)");
            pstmt.setString(1, username);
            pstmt.setString(2, email);
            pstmt.setString(3, password);
            pstmt.setString(4, phoneNumber);
            pstmt.setString(5, role);
            
            pstmt.executeUpdate();
            pstmt.close();
            conn.close();
        } catch (ClassNotFoundException e) {
            out.println("Error: " + e);
        } catch (SQLException e) {
            out.println("Error: " + e);
        } 
        
    }
%>



<h2>Existing members:</h2>
<table>
    <tr>
        <th>Member ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Actions</th>
    </tr>
    <%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String connURL = "jdbc:mysql://localhost/book_db?user=JAD&password=root@123mml&serverTimezone=UTC";
        Connection conn = DriverManager.getConnection(connURL);
        Statement stmt = conn.createStatement();

        String sqlStr = "SELECT * FROM user WHERE role='member'";
        ResultSet rs = stmt.executeQuery(sqlStr);

        while (rs.next()) {
            int memberId = rs.getInt("id");
            String name = rs.getString("username");
            String email = rs.getString("email");
    %>
    <tr>
        <td><%= memberId %></td>
        <td><%= name %></td>
        <td><%= email %></td>
        <td>
            <a href="editMember.jsp?memberId=<%= memberId %>"><button>Edit</button></a>
            <a href="deleteMember.jsp?memberId=<%= memberId %>"><button>Delete</button></a>
        </td>
    </tr>
    <% }
        conn.close();
    } catch (Exception e) {
        out.println("Error: " + e);
    }
    %>
</table>
                </div>
            </div>
        </div>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        
        <script>
        window.addEventListener('DOMContentLoaded', event => {

            // Toggle the side navigation
            const sidebarToggle = document.body.querySelector('#sidebarToggle');
            if (sidebarToggle) {
                // Uncomment Below to persist sidebar toggle between refreshes
                // if (localStorage.getItem('sb|sidebar-toggle') === 'true') {
                //     document.body.classList.toggle('sb-sidenav-toggled');
                // }
                sidebarToggle.addEventListener('click', event => {
                    event.preventDefault();
                    document.body.classList.toggle('sb-sidenav-toggled');
                    localStorage.setItem('sb|sidebar-toggle', document.body.classList.contains('sb-sidenav-toggled'));
                });
            }

        });
        </script>
    </body>
</html>
