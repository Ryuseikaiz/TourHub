<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Discount" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
        <link rel="stylesheet" href="assests/css/style_profile.css">
        <link rel="stylesheet" href="assests/css/manage-discounts.css">
        <title>Edit Discount</title>
    </head>
    <style>
        .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            background-color: #fff;
            appearance: none;
            background-image: url('data:image/svg+xml;charset=US-ASCII,%3Csvg%20xmlns%3D%22http%3A//www.w3.org/2000/svg%22%20viewBox%3D%220%200%204%205%22%3E%3Cpath%20fill%3D%22%23000%22%20d%3D%22M2%200L0%202h4L2%200zM0%203h4L2%205%200%203z%22/%3E%3C/svg%3E');
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 10px;
        }

        .form-group select:hover {
            border-color: #999;
        }

        .form-group select:focus {
            border-color: #007BFF;
            outline: none;
        }

    </style>
    <body>

        <!-- SIDEBAR -->
        <section id="sidebar">
            <a href="index.jsp" class="brand">
                <i class='bx bxs-smile'></i>
                <span class="text">TourHub</span>
            </a>
            <ul class="side-menu top">
                <li>
                    <a href="user-profile.jsp">
                        <i class='bx bxs-dashboard'></i>
                        <span class="text">User Information</span>
                    </a>
                </li>
                <li>
                    <a href="user-booking.jsp">
                        <i class='bx bxs-shopping-bag-alt'></i>
                        <span class="text">My Booking</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class='bx bxs-message-dots'></i>
                        <span class="text">Message</span>
                    </a>
                </li>
                <li>
                    <a href="discount">
                        <i class='bx bxs-discount'></i>
                        <span class="text">Manage Discounts</span>
                    </a>
                </li>
            </ul>
            <ul class="side-menu">
                <li>
                    <a href="#">
                        <i class='bx bxs-cog'></i>
                        <span class="text">Settings</span>
                    </a>
                </li>
                <li>
                    <a href="logout" class="logout">
                        <i class='bx bxs-log-out-circle'></i>
                        <span class="text">Logout</span>
                    </a>
                </li>
            </ul>
        </section>
        <!-- SIDEBAR -->

        <!-- CONTENT -->
        <section id="content">
            <!-- NAVBAR -->
            <nav>
                <i class='bx bx-menu'></i>
                <a href="#" class="nav-link"></a>
                <form action="#">
                    <div class="form-input">
                        <input type="search" placeholder="Searching for tour...">
                        <button type="submit" class="search-btn"><i class='bx bx-search'></i></button>
                    </div>
                </form>
                <input type="checkbox" id="switch-mode" hidden>
                <label for="switch-mode" class="switch-mode"></label>
                <a href="#" class="notification">
                    <i class='bx bxs-bell'></i>
                    <span class="num">8</span>
                </a>
                <a href="#" class="profile">
                    <img src="img/people.png">
                </a>
            </nav>
            <!-- NAVBAR -->

            <!-- MAIN -->
            <main>
                <div class="form-container">
                    <h3>Edit Discount</h3>

                    <!-- Display error or success messages if any -->
                    <% String errorMessage = (String) session.getAttribute("error"); %>
                    <% String successMessage = (String) session.getAttribute("message"); %>
                    <% if (errorMessage != null) { %>
                    <div style="color:red; margin-bottom: 10px;"><%= errorMessage %></div>
                    <% session.removeAttribute("error"); %>
                    <% } else if (successMessage != null) { %>
                    <div style="color:green; margin-bottom: 10px;"><%= successMessage %></div>
                    <% session.removeAttribute("message"); %>
                    <% } %>

                    <!-- Receive discount object from request -->
                    <% Discount discount = (Discount) request.getAttribute("discount"); %>
                    <% if (discount != null) { %>
                    <form action="discount" method="post">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="<%= discount.getDiscount_Id() %>">

                        <div class="form-group">
                            <label for="code">Discount Code:</label>
                            <input type="text" id="code" name="code" value="<%= discount.getCode() %>" required>
                        </div>
                        <div class="form-group">
                            <label for="quantity">Quantity:</label>
                            <input type="number" id="quantity" name="quantity" value="<%= discount.getQuantity() %>" min="1" required>
                        </div>
                        <div class="form-group">
                            <label for="percentDiscount">Percent Discount:</label>
                            <input type="number" id="percentDiscount" name="percentDiscount" value="<%= discount.getPercent_Discount() %>" step="0.01" min="0" max="100" required>
                        </div>
                        <div class="form-group">
                            <label for="startDate">Start Date:</label>
                            <input type="date" id="startDate" name="startDate" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(discount.getStart_Day()) %>" required>
                        </div>
                        <div class="form-group">
                            <label for="endDate">End Date:</label>
                            <input type="date" id="endDate" name="endDate" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(discount.getEnd_Day()) %>" required>
                        </div>

                        <!-- Dropdown for Require (Order Slot Requirement) -->
                        <div class="form-group">
                            <label for="require">Order Slot Requirement:</label>
                            <select id="require" name="require" required>
                                <option value="1" <%= discount.getRequire().equals("1") ? "selected" : "" %>>1 slot</option>
                                <option value="2" <%= discount.getRequire().equals("2") ? "selected" : "" %>>2 slots</option>
                                <option value="2" <%= discount.getRequire().equals("3") ? "selected" : "" %>>3 slots</option>
                                <option value="2" <%= discount.getRequire().equals("4") ? "selected" : "" %>>4 slots</option>
                                <option value="2" <%= discount.getRequire().equals("5") ? "selected" : "" %>>5 slots</option>
                                <option value="2" <%= discount.getRequire().equals("6") ? "selected" : "" %>>6 slots</option>
                                <option value="2" <%= discount.getRequire().equals("7") ? "selected" : "" %>>7 slots</option>
                                <option value="2" <%= discount.getRequire().equals("8") ? "selected" : "" %>>8 slots</option>
                                <option value="2" <%= discount.getRequire().equals("9") ? "selected" : "" %>>9 slots</option>
                                <option value="2" <%= discount.getRequire().equals("10") ? "selected" : "" %>>10 slots</option>
                                
                                <!-- Additional options as needed -->
                            </select>
                        </div>

                        <!-- Dropdown for Tour Selection using tour_name but storing tour_id -->
                        <div class="form-group">
                            <label for="tourId">Select Tour:</label>
                            <select id="tourId" name="tourId" required>
                                <c:forEach var="entry" items="${providerTourNames}">
                                    <option value="${entry.value}" <c:if test="${entry.value == discount.getTour_Id()}">selected</c:if>>
                                        ${entry.key}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="description">Description:</label>
                            <input type="text" id="description" name="description" value="<%= discount.getDescription() %>" required>
                        </div>

                        <button type="submit">Update</button>
                    </form>
                    <% } %>

                    <a href="discount" class="back-link">Back to Manage Discounts</a>
                </div>
            </main>
            <!-- MAIN -->
        </section>
        <!-- CONTENT -->

        <script src="assests/js/script_profile.js"></script>
    </body>
</html>
