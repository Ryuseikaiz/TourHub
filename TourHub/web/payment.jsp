<%-- 
    Document   : provider-analysis
    Created on : Sep 24, 2024, 9:35:52 PM
    Author     : hoang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- Boxicons -->
        <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
        <!-- My CSS -->
        <link rel="stylesheet" href="assests/css/style_profile.css">       
        <link href="assests/css/customer.css" rel="stylesheet" >      
        <link href="assests/css/provider_analysis.css" rel="stylesheet"/>   
        <link href="assests/css/tour-management.css" rel="stylesheet"/>   
        <link rel="stylesheet" href="assests/css/bootstrap.css" />



        <title>Analytic</title>
        <style>
            body {
                background-color: #f4f4f4;
            }
            .form-container {
                margin-top: 50px;
                background: #fff;
                padding: 30px;
                border-radius: 5px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }
            .balance-section {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
            }

            .balance-box {
                width: 100%;
                padding: 20px;
                text-align: center;
                border-radius: 8px;
                color: white;
            }

            .deposit-box {
                background-color: #6ba8ff;
            }

            .withdraw-box {
                background-color: #70e0b5;
            }

            .balance-box {
                background-color: #ffcc5c;
            }

            .amount {
                font-size: 24px;
                margin-top: 10px;
            }

            .form {
                display: flex;
                flex-direction: column;
            }

            .amount-button {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 10px;
                margin-bottom: 10px;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
            }

            .amount-button:hover {
                background-color: #0056b3;
            }

            .custom-input {
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                margin-bottom: 10px;
            }

            .withdraw-button {
                background-color: #28a745;
                color: white;
                border: none;
                padding: 10px;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
            }

            .withdraw-button:hover {
                background-color: #218838;
            }






            .withdraw-table {
                width: 90%;
                margin: 20px auto;
                border-collapse: collapse;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            }
            .withdraw-table th, .withdraw-table td {
                padding: 15px;
                border: 1px solid #dddddd;
                text-align: left;
            }
            .withdraw-table th {
                background-color: #007bff;
                color: #ffffff;
            }
            .withdraw-table tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            .withdraw-table .status-approved {
                color: green;
                font-weight: bold;
            }
            .withdraw-table .status-pending {
                color: orange;
                font-weight: bold;
            }
            .withdraw-table .status-rejected {
                color: red;
                font-weight: bold;
            }




            /* Base Styles */
            .notification {
                position: relative;
                cursor: pointer;
            }
            .dropdown{
                margin-right: 20px;
            }
            /* Dropdown Container */
            .dropdown {
                display: none; /* Hidden by default, can be toggled with JavaScript */
                position: absolute;
                top: 40px; /* Adjust based on icon height */
                right: 0;
                width: 400px; /* Increased width */
                max-height: 500px; /* Increased height */
                background-color: #ffffff; /* White background */
                color: #333333; /* Dark text color for readability */
                border-radius: 8px;
                overflow-y: auto;
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
                z-index: 1000;
                font-family: 'Arial', sans-serif; /* Adjusted font */
            }

            /* Dropdown Content */
            .dropdown-content {
                padding: 15px; /* Adjusted padding for more spacing */
            }

            /* Header */
            .dropdown h2 {
                margin: 10px;
                font-size: 18px; /* Slightly larger font */
                font-weight: bold;
                color: #333333; /* Dark color for text */
                padding-bottom: 10px;
                border-bottom: 1px solid #e0e0e0; /* Light border */
            }

            /* Notification Item */
            .notification-item {
                display: flex;
                align-items: center;
                padding: 15px; /* More padding for larger items */
                border-bottom: 1px solid #f0f0f0; /* Light gray for item separator */
            }

            .notification-item:last-child {
                border-bottom: none;
            }

            .notification-item img {
                width: 50px; /* Increased image size */
                height: 50px;
                border-radius: 50%;
                margin-right: 15px; /* More space between image and text */
            }

            .notification-item .text {
                flex: 1;
            }

            .notification-item .text p {
                margin: 0;
                font-size: 15px; /* Slightly larger font */
                color: #333333; /* Dark text color */
                line-height: 1.5;
            }

            .notification-item .text span {
                font-size: 13px; /* Slightly larger font for timestamp */
                color: #666666; /* Muted gray for timestamps */
            }

            /* See More Button */
            .see-more {
                display: block;
                width: 100%;
                padding: 12px; /* Increased padding */
                background-color: #FD7238; /* Orange button color */
                border: none;
                color: #ffffff; /* White text */
                font-size: 15px; /* Slightly larger font */
                cursor: pointer;
                text-align: center;
                border-radius: 0 0 8px 8px; /* Rounded bottom corners */
                font-family: 'Arial', sans-serif; /* Ensure consistency with dropdown font */
            }

            .see-more:hover {
                background-color: #e26229; /* Slightly darker on hover */
            }
        </style>
    </head>
    <body>


        <!-- SIDEBAR -->
        <section id="sidebar">
            <a href="home" class="brand">
                <i class='bx bxs-smile'></i>
                <span class="text">TourHub</span>
            </a>
            <ul class="side-menu top">
                <li>
                    <a href="user-profile.jsp">
                        <i class='bx bxs-dashboard' ></i>
                        <span class="text">User Information</span>
                    </a>
                </li>
                <c:if test="${sessionScope.currentUser.role == 'Provider'}">
                    <li>
                        <a href="pending-bookings">
                            <i class='bx bxs-shopping-bag-alt' ></i>
                            <span class="text">Manage Booking</span>
                        </a>
                    </li>
                </c:if>
                <c:if test="${sessionScope.currentUser.role == 'Customer'}">
                    <li>
                        <a href="user-booking.jsp">
                            <i class='bx bxs-shopping-bag-alt' ></i>
                            <span class="text">My Booking</span>
                        </a>
                    </li>
                </c:if>
                <li>
                    <a href="#">
                        <i class='bx bxs-message-dots' ></i>
                        <span class="text">Message</span>
                    </a>
                </li>
                <c:if test="${sessionScope.currentUser.role == 'Provider' || sessionScope.currentUser.role == 'Admin'}">
                    <li class="">
                        <a href="${sessionScope.currentUser.role == 'Provider' ? '/Project_SWP/provider-analys' : 'admin-analysis.jsp'}">
                            <i class='bx bxs-dashboard' ></i>
                            <span class="text">Dashboard</span>
                        </a>
                    </li>   
                    <li class="dropdown-btn">
                        <a href="my-tour">
                            <i class='bx bxs-briefcase-alt' ></i>
                            <span class="text">My Tour</span>
                        </a>
                    </li>                       
                    <li class="active">
                        <a href="provider-management?action=show-withdraw-page">
                            <i class='bx bxs-credit-card'></i>
                            <span class="text">Widthdraw</span>
                        </a>
                    </li> 
                    <li>
                        <a href="discount">
                            <i class='bx bxs-discount'></i>
                            <span class="text">Manage Discounts</span>
                        </a>
                    </li>
                </c:if>

            </ul>
            <ul class="side-menu">
                <li>
                    <a href="#">
                        <i class='bx bxs-cog' ></i>
                        <span class="text">Settings</span>
                    </a>
                </li>
                <li>
                    <a href="logout" class="logout">
                        <i class='bx bxs-log-out-circle' ></i>
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
                <!-- HTML Code for Dropdown -->
                <a href="javascript:void(0)" class="notification" role="button" onclick="toggleDropdown(event)">
                    <i class='bx bxs-bell'></i>
                </a>

                <!-- Notification Dropdown -->
                <div id="notificationDropdown" class="dropdown" style="display: none;">
                    <h2>Notifications</h2>
                    <div class="dropdown-content">
                        <p style="display: flex; justify-content: space-between"><strong>New</strong> <a href="#">See all</a></p>
                    </div>
                    <button class="see-more">See previous notifications</button>
                </div>




                <div class="image-container">
                    <img src="assests/images/avatar.jpg" alt="User Avatar" class="avatar">
                </div>
            </nav>
            <!-- NAVBAR -->

            <!-- MAIN -->
            <main>
                <div class="table-data">
                    <div class="order">  
                        <div class="head">
                            <h3>Widthdraw money</h3>
                        </div>
                        <c:choose>
                            <c:when test="${sessionScope.currentUser == null}">
                                <c:redirect url="home" />
                            </c:when>
                            <c:otherwise>
                                <div class="container py-5">
                                    <c:set var="balance" value="${requestScope.balance}"/>
                                    <div class="row">
                                        <div class="col-lg-6 mx-auto">
                                            <div class="page">
                                                <div class="container">
                                                    <div class="balance-section">
                                                        <div class="balance-box">
                                                            Balance
                                                            <div class="amount">${balance} VND</div>
                                                        </div>
                                                    </div>
                                                    <form class="form" action="provider-management?action=withdraw" method="POST">
                                                        <label>
                                                            <input type="radio" name="amount" class="amount-button" value="1000000">
                                                            1.000.000 VND
                                                        </label>
                                                        <label>
                                                            <input type="radio" name="amount" class="amount-button" value="2000000">
                                                            2.000.000 VND
                                                        </label>
                                                        <label>
                                                            <input type="radio" name="amount" class="amount-button" value="5000000">
                                                            5.000.000 VND
                                                        </label>
                                                        <label>
                                                            <input type="radio" name="amount" class="amount-button" value="10000000">
                                                            10.000.000 VND
                                                        </label>
                                                        <input
                                                            type="number"
                                                            name="customAmount" 
                                                            class="custom-input"
                                                            placeholder="Enter custom amount (VND)"
                                                            />
                                                        <button type="submit" class="withdraw-button">Withdraw</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>   
                                    <div class="head">
                                        <h3>Booking</h3>
                                    </div>
                                    <table class="withdraw-table">
                                        <thead>
                                            <tr>
                                                <th>Withdraw Money</th>
                                                <th>Request Date</th>
                                                <th>Respond Date</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:if test="${not empty requestScope.withdrawalses}">
                                                <c:forEach var="withdrawal" items="${requestScope.withdrawalses}">
                                                    <tr>
                                                        <td>${withdrawal.withdrawMoney}</td>
                                                        <td>${withdrawal.requestDate}</td>
                                                        <td>${withdrawal.respondDate}</td>
                                                        <td class="status-${withdrawal.status.toLowerCase()}">${withdrawal.status}</td>
                                                    </tr>
                                                </c:forEach>
                                            </c:if>

                                        </tbody>
                                    </table>
                                </div> <!-- Missing closing div tag corrected here -->
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </main>          
            <!-- MAIN -->
        </section>

        <!-- CONTENT -->


        <script src="assests/js/script_profile.js"></script>     
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        const burger = document.querySelector('.burger');
                        const navigation = document.querySelector('.navigation-admin');
                        const main = document.querySelector('.main-admin');
                        const profileCard = document.querySelector('.profile-card'); // Select the profile card

                        burger.addEventListener('click', function () {
                            navigation.classList.toggle('active');
                            main.classList.toggle('active');
                            profileCard.classList.toggle('active'); // Toggle the active class on the profile card
                        });
                    });



        </script>
        <script>
//            function reloadData() {
//                var date = document.getElementById("date").value;
//                $.ajax({
//                    url: "/Project_SWP/provider-analys",
//                    type: "POST",
//                    data: {
//                        date: date
//                    },
//                    success: function (data) {
//                        // Assuming 'data' is a JSON object
//                        document.querySelector("#totalVisitValue").innerHTML = data.totalVisitATour || 0;
//                        document.querySelector("#visitTodayValue").innerHTML = data.visitToday || 0;
//                        document.querySelector("#bookingThisMonthValue").innerHTML = data.bookingThisMonth || 0;
//                    }
//                });
//            }
//            function calculateDuration() {
//                // Get the values of the start and end dates
//                var startDate = document.getElementById("start_Date").value;
//                var endDate = document.getElementById("end_Date").value;
//
//                if (startDate && endDate) {
//                    // Parse the dates into Date objects
//                    var start = new Date(startDate);
//                    var end = new Date(endDate);
//
//                    // Calculate the difference in time (milliseconds)
//                    var diffTime = end - start;
//
//                    // Convert the time difference to days (1 day = 24*60*60*1000 milliseconds)
//                    var diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
//
//                    if (diffDays > 0) {
//                        // Set the day value
//                        document.getElementById("day").value = diffDays;
//
//                        // Set the night value (days - 1)
//                        document.getElementById("night").value = diffDays - 1;
//                    } else {
//                        // If the end date is before the start date, reset the fields
//                        document.getElementById("day").value = 0;
//                        document.getElementById("night").value = 0;
//                    }
//                } else {
//                    // Reset the fields if either date is missing
//                    document.getElementById("day").value = 0;
//                    document.getElementById("night").value = 0;
//                }
//            }
//            $(function () {
//                $('[data-toggle="tooltip"]').tooltip()
//            })
            // Keep track of sort directions for each column
            let sortDirection = [true, true, true, true];  // Default to ascending for all columns

            function sortTable(columnIndex) {
                let table = document.querySelector(".withdraw-table");
                let tbody = table.querySelector("tbody");
                let rows = Array.from(tbody.getElementsByTagName("tr"));
                let isAscending = sortDirection[columnIndex];  // Check current sort direction for this column

                let sortedRows = rows.sort((a, b) => {
                    let valA = a.getElementsByTagName("td")[columnIndex].textContent.trim();
                    let valB = b.getElementsByTagName("td")[columnIndex].textContent.trim();

                    // Handle different types of sorting based on the column index
                    if (columnIndex === 0) {  // Withdraw Money column: numeric sorting
                        valA = parseFloat(valA.replace(/[^\d.-]/g, '')) || 0;
                        valB = parseFloat(valB.replace(/[^\d.-]/g, '')) || 0;
                    } else if (columnIndex === 1 || columnIndex === 2) {  // Request Date and Respond Date columns: date sorting
                        valA = new Date(valA);
                        valB = new Date(valB);
                    }

                    // Compare values
                    if (valA < valB) {
                        return isAscending ? -1 : 1;
                    }
                    if (valA > valB) {
                        return isAscending ? 1 : -1;
                    }
                    return 0;
                });

                // Remove existing rows and append sorted rows back to the table
                tbody.innerHTML = '';
                for (let row of sortedRows) {
                    tbody.appendChild(row);
                }

                // Toggle sort direction for the next click
                sortDirection[columnIndex] = !isAscending;
            }

            function toggleDropdown(event) {
                event.preventDefault(); // Prevents default anchor behavior
                const dropdown = document.getElementById("notificationDropdown");
                if (!dropdown) {
                    console.error('Dropdown element not found');
                    return;
                }

                // Toggle visibility
                dropdown.style.display = dropdown.style.display === "block" ? "none" : "block";

                // Fetch notifications only when showing the dropdown
                if (dropdown.style.display === "block") {
                    fetchNotifications();
                }
            }

            // Close the dropdown when clicking outside of it
            window.onclick = function (event) {
                if (!event.target.closest('.notification') && !event.target.closest('#notificationDropdown')) {
                    const dropdown = document.getElementById("notificationDropdown");
                    if (dropdown && dropdown.style.display === "block") {
                        dropdown.style.display = "none";
                    }
                }
            };

            function fetchNotifications() {
                const notificationContainer = document.querySelector('.dropdown-content');
                if (!notificationContainer) {
                    console.error('Notification container element not found');
                    return;
                }

                // Show loading message
                notificationContainer.innerHTML = '<p>Loading...</p>';

                fetch('/Project_SWP/notifications', {method: 'POST'})
                        .then(response => {
                            if (!response.ok) {
                                console.error('Network response was not ok:', response.statusText);
                                throw new Error('Network response was not ok');
                            }
                            return response.json();
                        })
                        .then(data => {
                            notificationContainer.innerHTML = ''; // Clear existing content

                            if (data.length === 0) {
                                notificationContainer.innerHTML = '<p>No new notifications</p>';
                                return;
                            }

                            data.forEach(noti => {
                                const notificationItem = document.createElement('div');
                                notificationItem.classList.add('notification-item');

                                const notiContent = `
                        <div class="text">
                            <p><strong>${noti.isRead ? noti.message : '<em>' + noti.message + '</em>'}</strong></p>
                            <span>${noti.dateSent}</span>
                        </div>
                    `;
                                notificationItem.innerHTML = notiContent;
                                notificationContainer.appendChild(notificationItem);
                            });
                        })
                        .catch(error => {
                            console.error('Fetch operation failed:', error);
                            notificationContainer.innerHTML = '<p>Failed to load notifications. Please try again later.</p>';
                        });
            }
        </script>

        <script src="dist/js/theme.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
