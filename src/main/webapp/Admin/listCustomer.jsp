<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="dbaccess.User" %>
<%@ page import="dbaccess.CustomerDAO" %>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>List Customer By Street Code</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
   
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f1f1f1;
            margin: 0;
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: #333;
        }

        form {
            max-width: 400px;
            margin: 20px auto;
        }

        label {
            display: block;
            margin-bottom: 10px;
        }

        input[type="text"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }

        input[type="submit"] {
            background-color: #4caf50;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        p {
            text-align: center;
            color: #555;
        }

        table {
            width: 100%;
            border-collapse: collapse;
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

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
    </style>
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

<div class="d-flex" id="wrapper">
            <!-- Sidebar-->
            <div class="border-end bg-white" id="sidebar-wrapper">
                <div class="sidebar-heading border-bottom bg-light">Hogwart Library</div>
                <div class="list-group list-group-flush">
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="./displayAdmin.jsp">Dashboard</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="./saleManagement.jsp">Sale Management</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="./bestSelling.jsp">Best Selling Book</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="./leastSelling.jsp">Least Selling Book</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="./LowStockBook.jsp">Low Stock Book</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="./listCustomer.jsp">Customer Residential</a>
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
                                <li class="nav-item"><a class="nav-link" href="../Login.jsp">Logout</a></li>
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
    <h1>List Customers by Street Code</h1>
    
    <form action="listCustomer.jsp" method="post">
        <label for="streetCode">Enter Street Code:</label>
        <input type="text" id="streetCode" name="streetCode">
        <input type="submit" value="Get Members">
    </form>
    
    <% 
        String streetCode = request.getParameter("streetCode");
        if (streetCode != null) {
            try {
                List<User> streetMembers = CustomerDAO.getMembersByStreet(streetCode);
                if (streetMembers.isEmpty()) {
    %>
    <p>No member with street code <%= streetCode %>.</p>
    <%
                } else {
    %>
    <table>
        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Email</th>
            <th>Address</th>
            <th>Phone Number</th>
        </tr>
        
        <% 
            for (User user : streetMembers) {
        %>
        <tr>
            <td><%= user.getId() %></td>
            <td><%= user.getUsername() %></td>
            <td><%= user.getEmail() %></td>
            <td><%= user.getAddress() %></td>
            <td><%= user.getPhnumber() %></td>
        </tr>
        <%
            }
        %>
    </table>
    <%
                }
            } catch (Exception e) {
                e.printStackTrace();
    %>
    <p>An error occurred while fetching data from the database.</p>
    <%
            }
        }
    %>
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

    });</script>
</body>
</html>