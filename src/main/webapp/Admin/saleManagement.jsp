<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.GregorianCalendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="dbaccess.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dbaccess.*" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="servlets.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.stream.Collectors" %>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Sale Management</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
    </head>
    <body>
<%
    // Fetch the sales data when the page is loaded

 String AdminID = (String) session.getAttribute("sessAdminID");
    String userRole = (String) session.getAttribute("role");
    String loginStatus = (String) session.getAttribute("loginStatus");
    System.out.println((String) session.getAttribute("role"));
    if (AdminID == null ||  !userRole.equals("admin") || loginStatus == null || !loginStatus.equals("success")) {
        response.sendRedirect("../Login.jsp?errCode=invalidLogin");
    }

    ArrayList<Sale> saleList = SalesDataFetcher.fetchSalesData();

    // Get the selected month from the drop-down menu
    String selectedMonthStr = request.getParameter("monthSelect");
    int selectedMonth = (selectedMonthStr != null && !selectedMonthStr.isEmpty()) ? Integer.parseInt(selectedMonthStr) : 0;

    // Filter sales data by the selected month
    if (selectedMonth > 0) {
        ArrayList<Sale> filteredSaleList = new ArrayList<>();

        for (Sale sale : saleList) {
            // Parse the string representation of the date into a java.sql.Date object
            java.util.Date utilDate = new SimpleDateFormat("yyyy-MM-dd").parse(sale.getOrder_date());
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(utilDate);
            int saleMonth = calendar.get(Calendar.MONTH) + 1;

            if (saleMonth == selectedMonth) {
                filteredSaleList.add(sale);
                System.out.println(selectedMonth);
            }
        }

        saleList = filteredSaleList;
    }else{
    	saleList = SalesDataFetcher.fetchSalesData();
    	
    }
    
		String bookTitle = request.getParameter("bookTitle");
		    
		    // Filter sales data by the book title (case-insensitive and not exact match)
		    ArrayList<Sale> filteredCustomerSaleList = new ArrayList<>();
		    if (bookTitle != null && !bookTitle.isEmpty()) {
		        for (Sale sale : saleList) {
		            if (sale.getTitle().toLowerCase().contains(bookTitle.toLowerCase())) {
		                filteredCustomerSaleList.add(sale);
		            }
		        }
		    } else {
		        // If no book title is entered, show all sales data
		        filteredCustomerSaleList = saleList;
		    }
%>





		<style>
    
        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 10px;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        /* Add a darker background color to every second row */
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .container-fluid {
        margin-bottom: 20px;
	    }
	
	  
	   #customers {
		  font-family: Arial, Helvetica, sans-serif;
		  border-collapse: collapse;
		  width: 100%;
		}
		
		#customers td, #customers th {
		  border: 1px solid #ddd;
		  padding: 8px;
		}
		
		#customers tr:nth-child(even){background-color: #f2f2f2;}
		
		#customers tr:hover {background-color: #ddd;}
		
		#customers th {
		  padding-top: 12px;
		  padding-bottom: 12px;
		  text-align: left;
		  background-color: #04AA6D;
		  color: white;
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
               <%
    // Fetch the sales data when the page is loaded
   
%>

<div class="container-fluid">
    <h1>Sale Management</h1>
    <form id="filterForm" method="get" action="./saleManagement.jsp">
         <label for="monthSelect">Select Month:</label>
            <select id="monthSelect" name="monthSelect">
                <option value="0" <% if (selectedMonth == 0) { %>selected="selected"<% } %>>All Months</option>
	            <option value="1" <% if (selectedMonth == 1) { %>selected="selected"<% } %>>January</option>
	            <option value="2" <% if (selectedMonth == 2) { %>selected="selected"<% } %>>February</option>
                <option value="3" <% if (selectedMonth == 3) { %>selected="selected"<% } %>>March</option>
	            <option value="4" <% if (selectedMonth == 4) { %>selected="selected"<% } %>>April</option>
	            <option value="5" <% if (selectedMonth == 5) { %>selected="selected"<% } %>>May</option>
	            <option value="6" <% if (selectedMonth == 6) { %>selected="selected"<% } %>>June</option>
	            <option value="7" <% if (selectedMonth == 7) { %>selected="selected"<% } %>>July</option>
	            <option value="8" <% if (selectedMonth == 8) { %>selected="selected"<% } %>>August</option>
	            <option value="9" <% if (selectedMonth == 9) { %>selected="selected"<% } %>>September</option>
	            <option value="10" <% if (selectedMonth == 10) { %>selected="selected"<% } %>>October</option>
	            <option value="11" <% if (selectedMonth == 11) { %>selected="selected"<% } %>>November</option>
               	<option value="12" <% if (selectedMonth == 12) { %>selected="selected"<% } %>>December</option>
                
                <!-- Add options for other months here -->
            </select>
        <label for="bookTitle">Enter Book Title:</label>
        <input type="text" id="bookTitle" name="bookTitle" value="<%= (bookTitle != null) ? bookTitle : "" %>">
        <input type="submit" value="Apply">
    </form>
    <table border="1">
        <!-- Table header rows (unchanged) -->
        <thead>
            <tr>
                <th>Order ID</th>
                <th>Customer ID</th>
                <th>Username</th>
                <th>Book ID</th>
                <th>Title</th>
                <th>Quantity</th>
                <th>Total Amount</th>
                <th>Order Date</th>
                <th>Update Status</th>
            </tr>
        </thead>
        <!-- Table body rows will be dynamically filled using the Java code -->
        <tbody>
            <% if (filteredCustomerSaleList != null && !filteredCustomerSaleList.isEmpty()) { %>
                <% for (Sale sale : filteredCustomerSaleList) { %>
                    <tr>
                        <td><%= sale.getOrder_id() %></td>
                        <td><%= sale.getCustomer_id() %></td>
                        <td><%= sale.getUsername() %></td>
                        <td><%= sale.getBook_id() %></td>
                        <td><%= sale.getTitle() %></td>
                        <td><%= sale.getQuantity() %></td>
                        <td><%= sale.getTotal_amount() %></td>
                        <td><%= sale.getOrder_date() %></td>
                        <td>
                    <form method="post" action="<%=request.getContextPath()%>/UpdateOrderStatusServlet">
					    <input type="hidden" name="order_id" value="<%= sale.getOrder_id() %>">
					    <button type="submit" name="status" value="delivered">Delivered</button>
					    <button type="submit" name="status" value="cancelled">Cancelled</button>
					</form>

                </td>
                    </tr>
                <% } %>
            <% } else { %>
                <tr>
                    <td colspan="9">No sales data available.</td>
                </tr>
            <% } %>
        </tbody>
    </table>
</div>

<%
    // Calculate the total purchase value for each customer
    Map<String, Double> customerPurchaseMap = new HashMap<>();
    Map<String, String> customerNameMap = new HashMap<>(); // Store customer names

    for (Sale sale : saleList) {
        String customerId = String.valueOf(sale.getCustomer_id());
        double purchaseAmount = sale.getTotal_amount();

        customerPurchaseMap.put(customerId, customerPurchaseMap.getOrDefault(customerId, 0.0) + purchaseAmount);
        // Assuming the username is available in the Sale object, you can get it like this:
        String username = sale.getUsername();
        customerNameMap.put(customerId, username);
    }

    // Sort the customers by their total purchase value in descending order
    List<Map.Entry<String, Double>> sortedCustomers = customerPurchaseMap.entrySet()
            .stream()
            .sorted(Map.Entry.<String, Double>comparingByValue().reversed())
            .limit(10)
            .collect(Collectors.toList());
%>

<div class="container-fluid">
    <h5>Top 10 Customers by Purchase Value</h5>
    <div class="table-container">
        <table id="customers">
            <!-- Table header rows -->
            <thead>
                <tr>
                    <th>Customer ID</th>
                    <th>Username</th>
                    <th>Total Purchase Amount</th>
                </tr>
            </thead>
            <!-- Table body rows will be dynamically filled using the Java code -->
            <tbody>
                <% if (!sortedCustomers.isEmpty()) { %>
                    <% for (Map.Entry<String, Double> entry : sortedCustomers) { %>
                        <tr>
                            <td><%= entry.getKey() %></td>
                            <td><%= customerNameMap.get(entry.getKey()) %></td> <!-- Display the username -->
                            <td><%= new DecimalFormat("0.00").format(entry.getValue()) %></td>
                        </tr>
                    <% } %>
                <% } else { %>
                    <tr>
                        <td colspan="3">No data available.</td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
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
        window.addEventListener('DOMContentLoaded', event => {

            // Get the select element and add a change event listener
            const monthSelect = document.getElementById('monthSelect');
            if (monthSelect) {
                monthSelect.addEventListener('change', event => {
                    // Submit the form when the month selection changes
                    document.getElementById('filterForm').submit();
                });
            }

            // Toggle the side navigation (unchanged) ...
        });
        </script>
    </body>
</html>