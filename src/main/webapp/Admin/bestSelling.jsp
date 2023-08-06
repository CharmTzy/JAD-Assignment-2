<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Book" %>
<%@ page import="dbaccess.BookDAO" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Best Selling</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
    
    <style>
        /* Add your CSS styles here */
        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }

        th {
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
                
                <!-- Page content-->
    <h1>Best Selling Books</h1>

    <% 
        try {
            int limit = 10; // Set the number of top-selling books to display

            // Get the best selling books using the BookDAO
            List<Book> bestSellingBooks = BookDAO.getBestSellingBooks(limit);
    %>

    <% if (!bestSellingBooks.isEmpty()) { %>
    <table>
        <tr>
            <th>Title</th>
            <th>Author</th>
        </tr>
        <% for (Book book : bestSellingBooks) { %>
        <tr>
            <td><%= book.getTitle() %></td>
            <td><%= book.getAuthor() %></td>
            
        </tr>
        <% } %>
    </table>
    <% } else { %>
    <p>No best selling books found.</p>
    <% } %>

    <% } catch (Exception e) { %>
    <p>Error fetching best selling books: <%= e.getMessage() %></p>
    <% } %>


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

