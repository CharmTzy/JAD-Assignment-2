<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"%>
<%@page import = "dbaccess.*" %>
<%@page import = "java.util.ArrayList" %>

<%@page import = "java.util.Iterator" %>

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
String loginStatus = (String) session.getAttribute("loginStatus");
if ( AdminID == null || !loginStatus.equals("success")){
	response.sendRedirect("../Login.jsp?errCode=invalidLogin");
}

%>

<style>
 
	  
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
                <table>
				        <thead>
				            <tr>
				                <th>Order ID</th>
				                <th>Customer ID</th>
				                <th>Order Date</th>
				                <th>Total Amount</th>
				                <th>Username</th>
				                <th>Book ID</th>
				                <th>Quantity</th>
				                <th>Title</th>
				            </tr>
				        </thead>
				        <tbody>
				            <%@ page import="dbaccess.Sale" %>
				            <%@ page import="java.util.ArrayList" %>
				            <% ArrayList<Sale> saleList = (ArrayList<Sale>) request.getAttribute("saleArray"); 
				            out.println(saleList);%>
				            <% if (saleList != null) { %>
				                <% for (Sale sale : saleList) { %>
				                    <tr>
				                        <td><%= sale.getOrder_id() %></td>
				                        <td><%= sale.getCustomer_id() %></td>
				                        <td><%= sale.getOrder_date() %></td>
				                        <td><%= sale.getTotal_amount() %></td>
				                        <td><%= sale.getUsername() %></td>
				                        <td><%= sale.getBook_id() %></td>
				                        <td><%= sale.getQuantity() %></td>
				                        <td><%= sale.getTitle() %></td>
				                    </tr>
				                <% } %>
				            <% } else { %>
				                <tr>
				                    <td colspan="8">No sales data available.</td>
				                </tr>
				            <% } %>
				        </tbody>
				    </table>
                </div>
            </div>
        </div>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
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
