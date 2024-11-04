<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.User" %>
<%@ page import="DataAccess.UserDB"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%--<jsp:useBean id="currentUser" class="model.User" scope="session" />--%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- Boxicons -->
        <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
        <!-- My CSS -->
        <link rel="stylesheet" href="assests/css/style_profile.css">       
        <link href="assests/css/customer.css" rel="stylesheet" />

        <title>User Profile</title>
        <style>


            /* Style the labels */
            .avatardiv label {
                margin-bottom: 10px; /* Space below the label */
                font-weight: bold; /* Bold text */
            }

            /* Style the file input */
            .avatardiv input[type="file"] {
                margin-bottom: 20px; /* Space below the input */
                padding: 10px; /* Add padding */
                border: 1px solid #ccc; /* Light border */
                border-radius: 4px; /* Rounded corners */
                font-size: 14px; /* Font size */
            }

            /* Style the submit button */
            .avatardiv button {
                padding: 10px 20px; /* Vertical and horizontal padding */
                border: none; /* Remove default border */
                border-radius: 4px; /* Rounded corners */
                background-color: #4CAF50; /* Green background */
                color: white; /* White text color */
                font-size: 16px; /* Font size */
                cursor: pointer; /* Pointer cursor on hover */
                transition: background-color 0.3s; /* Transition effect */
            }

            /* Change button color on hover */
            .avatardiv button:hover {
                background-color: #45a049; /* Darker green on hover */
            }

            .profile-card {
                display: flex; /* Sử dụng Flexbox để tạo cấu trúc cho phần card */
                justify-content: space-between; /* Căn giữa và phân chia không gian */
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 8px;
                background-color: #f9f9f9;
            }

            .profile-info-left,
            .profile-info-right {
                flex: 1; /* Chiếm 50% không gian của mỗi phần */
                margin-right: 20px; /* Thêm khoảng cách bên phải cho phần bên trái */
            }

            .profile-info-right {
                margin-right: 0; /* Đảm bảo không gian cho phần bên phải */
            }

            /* Style for the avatar container */
            .avatar-container {
                position: relative;
                display: inline-block;
                text-align: center;
            }

            /* Style for the avatar image */
            .avatar {
                width: 250px; /* Adjust the width as needed */
                height: 250px; /* Adjust the height as needed */
                border-radius: 50%;
                object-fit: cover;
            }

            /* Style for the overlay */
            .avatar-overlay {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.6);
                border-radius: 50%;
                display: flex;
                justify-content: center;
                align-items: center;
                opacity: 0;
                transition: opacity 0.3s ease;
            }

            /* Show the overlay on hover */
            .avatar-container:hover .avatar-overlay {
                opacity: 1;
            }

            /* Common style for both buttons */
            .upload-label, .upload-btn {
                color: white;
                font-size: 16px;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                display: inline-block;
                width: 150px; /* Set width to ensure they are equal */
                text-align: center;
                margin: 5px; /* Space between the buttons */
            }

            /* Style for the "Change Avatar" label */
            .upload-label {
                background-color: #17a2b8;
            }

            /* Style for the "Upload" button */
            .upload-btn {
                background-color: #28a745;
                border: none;
            }

            /* Hover effect for both buttons */
            .upload-label:hover, .upload-btn:hover {
                opacity: 0.8;
            }

            /* Hide the file input field */
            input[type="file"] {
                display: none;
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

            /* Dropdown Toggle */
            .notification:hover + .dropdown,
            .dropdown:hover {
                display: block;
            }


        </style>
    </head>
    <body>
        <!-- SIDEBAR -->

        <%@include file="includes/user-sidebar.jsp" %>

        <!-- SIDEBAR -->
        <!-- CONTENT -->
        <section id="content">
            <!-- NAVBAR -->
            <nav>
                <i class='bx bx-menu' ></i>
                <a href="#" class="nav-link"></a>
                <form action="#">
                    <div class="form-input">
                        <input type="search" placeholder="Searching for tour...">
                        <button type="submit" class="search-btn"><i class='bx bx-search' ></i></button>
                    </div>
                </form>
                <input type="checkbox" id="switch-mode" hidden>
                <label for="switch-mode" class="switch-mode"></label>
                <a href="#" class="notification" onclick="toggleDropdown()">
                    <i class='bx bxs-bell'></i>
                </a>



                <!-- Notification Dropdown -->
                <div id="notificationDropdown" class="dropdown">
                    <h2>Notifications</h2>
                    <div class="dropdown-content">
                        <p style="display: flex; justify-content: space-between"><strong>New</strong> <a href="#">See all</a></p>
                        <div class="notification-item">
                            <img src="user1.jpg" alt="User Image">
                            <div class="text">
                                <p><strong>Duy Khánh</strong> played Tiến Lên Miền Nam Cybergame: "Duy" is the winner and won 118.75K chip!</p>
                                <span>1h</span>
                            </div>
                        </div>
                        <!-- Repeat .notification-item for other notifications -->
                    </div>
                    <button class="see-more">See previous notifications</button>
                </div>


                <div class="image-container">
                    <img src="${currentUser.avatar}" alt="User Avatar" class="avatar">
                </div>

            </nav>
            <!-- NAVBAR -->

            <!-- MAIN -->
            <main>
                <div class="table-data">
                    <div class="order">
                        <div class="head">
                            <h3>User Information</h3>
                        </div>
                        <!-- Enter data here -->
                        <c:choose>
                            <c:when test="${sessionScope.currentUser == null}">
                                <c:redirect url="home" />
                            </c:when>
                            <c:otherwise>
                                <div class="profile-card">
                                    <div class="profile-info-left">
                                        <div class="profile-info">
                                            <label>Full Name:</label>
                                            <p><span>${currentUser.first_Name} ${currentUser.last_Name}</span></p>
                                        </div>
                                        <div class="profile-info">
                                            <label>Email:</label>
                                            <p><span>${sessionScope.currentUser.email}</span></p>
                                            <form class="changeform" action="user-updateinfo.jsp" method="get">
                                                <button type="submit" name="buttonChange" value="email">Change email</button>
                                            </form>
                                        </div>
                                        <div class="profile-info">
                                            <label>Phone Number:</label>
                                            <p><span>${currentUser.phone}</span></p>
                                        </div>
                                        <div class="profile-info">
                                            <label>Address:</label>
                                            <p><span>${currentUser.address}</span></p>
                                        </div>
                                        <div class="profile-info">
                                            <label>Password:</label>
                                            <p>
                                                <span id="passwordDisplay">********</span>
                                                <button onclick="togglePassword()">Show</button>
                                            </p>
                                            <form class="changeform" action="user-updateinfo.jsp" method="get">
                                                <button type="submit" name="buttonChange" value="pass">Change password</button>
                                            </form>
                                        </div>
                                        <c:if test="${sessionScope.currentUser.role == 'Customer'}">
                                            <div class="profile-info">
                                                <label>Birthday: </label>
                                                <p><span>${currentUser.cus_Birth}</span></p>
                                            </div>
                                        </c:if>
                                        <c:if test="${sessionScope.currentUser.role == 'Provider'}">
                                            <div class="profile-info">
                                                <label>Tax Code: </label>
                                                <p><span>${currentUser.tax_Code}</span></p>
                                            </div>
                                            <div class="profile-info">
                                                <label>Balance: </label>
                                                <p><span>${currentUser.balance}</span></p>
                                            </div>
                                            <div class="profile-info">
                                                <label>Bank Information: </label>
                                                <p><span>${currentUser.bank_Information}</span></p>
                                            </div>
                                        </c:if>

                                    </div>
                                    <div class="profile-info-right">
                                        <div class="profile-info">
                                            <!-- Avatar container -->
                                            <div class="avatar-container">
                                                <!-- Display the current avatar -->
                                                <img id="avatarImg" src="${currentUser.avatar}" class="avatar" />

                                                <!-- Overlay that appears on hover -->
                                                <div class="avatar-overlay">
                                                    <!-- Upload form inside the overlay -->
                                                    <form action="UploadAvatarServlet" method="post" enctype="multipart/form-data">
                                                        <label for="file-input" class="upload-label">Change Avatar</label>
                                                        <input id="file-input" type="file" name="avatar" accept="image/*" required>
                                                        <button type="submit" class="upload-btn">Upload</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="change-info-button">
                                    <form action="user-updateinfo.jsp">
                                        <button type="submit">Change Information</button>
                                    </form>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </main>
            <!-- MAIN -->
        </section>
        <!-- CONTENT -->


        <script src="assests/js/script_profile.js"></script>
        <script>
                                                    function togglePassword() {
                                                        var passwordField = document.getElementById('passwordDisplay');
                                                        var button = event.target;
                                                        if (passwordField.innerHTML === "********") {
                                                            passwordField.innerHTML = "${currentUser.password}";
                                                            button.textContent = "Hide";
                                                        } else {
                                                            passwordField.innerHTML = "********";
                                                            button.textContent = "Show";
                                                        }
                                                    }

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



                                                    function toggleDropdown() {
                                                        const dropdown = document.getElementById("notificationDropdown");
                                                        dropdown.style.display = dropdown.style.display === "block" ? "none" : "block";
                                                    }

                                                    window.onclick = function (event) {
                                                        if (!event.target.matches('.notification, .notification *')) {
                                                            document.getElementById("notificationDropdown").style.display = "none";
                                                        }
                                                    }
        </script>
    </body>
</html>