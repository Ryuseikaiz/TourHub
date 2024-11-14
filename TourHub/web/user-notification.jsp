<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ page import="model.User"%> 
<%@ page import="DataAccess.UserDB"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Notification" %>
<jsp:useBean id="currentUser" class="model.User" scope="session" />
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <!-- Boxicons -->
        <link
            href="https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css"
            rel="stylesheet"
            />
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/toastify-js@1.11.1/src/toastify.min.css"
            />
        <!-- My CSS -->
        <link rel="stylesheet" href="assests/css/style_profile.css" />
        <link href="assests/css/customer.css" rel="stylesheet" />      
        <link href="assests/css/notification.css" rel="stylesheet" />  

        <title>User Profile</title>
        <style>
            .order .head {
                text-align: center;
                margin-bottom: 20px;
            }

            .order .head h3 {
                font-size: 1.8rem;
                color: #333;
                margin: 0;
            }

            /* Container styles for management sections */
            .container {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 20px;
                margin-top: 20px;
            }

            .container div {
                background-color: orange;
                color: black;
                padding: 65px;
                text-align: center;
                border-radius: 6px;
                transition: background-color 0.3s, transform 0.3s;
            }

            .container div:hover {
                background-color: blue;
                transform: translateY(-5px);
                cursor: pointer;
            }

            /* Style cho bảng */
            /* Style cho bảng */
            table {
                width: 100%; /* Chiếm toàn bộ chiều rộng */
                border-collapse: collapse; /* Loại bỏ khoảng cách giữa các ô */
                font-family: Arial, sans-serif;
                margin-bottom: 20px; /* Khoảng cách dưới bảng */
            }

            /* Style cho tiêu đề bảng */
            thead th {
                background-color: #4CAF50; /* Màu nền cho tiêu đề */
                color: white; /* Màu chữ trắng */
                padding: 12px 15px;
                text-align: center;
                font-weight: bold;
                border: 1px solid #ddd;
            }

            /* Style cho các hàng trong bảng */
            tbody td {
                padding: 10px 15px; /* Khoảng cách bên trong các ô */
                border: 1px solid #ddd; /* Đường viền */
                text-align: center; /* Căn giữa */
                vertical-align: middle; /* Canh giữa dọc */
                background-color: #f9f9f9; /* Màu nền sáng hơn cho nội dung */
            }

            /* Hiệu ứng hover cho hàng */
            tbody tr:hover {
                background-color: #f1f1f1; /* Thay đổi màu nền khi hover */
            }

            /* Container cho các nút hành động */
            .action-container {
                display: flex; /* Sử dụng flexbox để căn giữa */
                justify-content: center; /* Căn giữa các nút */
            }

            /* Style cho các nút hành động */
            a.action-link {
                display: inline-block;
                padding: 8px 12px;
                text-decoration: none;
                color: white;
                border-radius: 5px;
                margin: 0 5px; /* Khoảng cách giữa các nút */
                transition: background-color 0.3s ease;
                font-size: 14px;
            }

            /* Nút Approve */
            a.approve {
                background-color: #28a745; /* Màu xanh lá */
            }

            a.approve:hover {
                background-color: #218838; /* Màu xanh đậm hơn khi hover */
            }

            /* Nút Cancel */
            a.cancel {
                background-color: #dc3545; /* Màu đỏ */
            }

            a.cancel:hover {
                background-color: #c82333; /* Màu đỏ đậm hơn khi hover */
            }
        </style>
    </head>
    <body>
        <!-- SIDEBAR -->
        <%@include file="includes/user-sidebar.jsp" %>

        <!-- CONTENT -->
        <section id="content">
            <!-- NAVBAR -->
            <nav>
                <i class="bx bx-menu"></i>
                <a href="#" class="nav-link"></a>
                <form action="#">
                    <div class="form-input">
                        <input type="search" placeholder="Searching for tour..." />
                        <button type="submit" class="search-btn">
                            <i class="bx bx-search"></i>
                        </button>
                    </div>
                </form>
                <input type="checkbox" id="switch-mode" hidden />
                <label for="switch-mode" class="switch-mode"></label>
                <!-- HTML Code for Notification Icon and Dropdown -->
                <a href="javascript:void(0)" class="notification" role="button" onclick="toggleDropdown(event)">
                    <i class='bx bxs-bell'></i>
                </a>

                <div id="notificationDropdown" class="dropdown hidden">
                    <h2>Notifications</h2>
                    <div class="dropdown-content">
                        <!-- Content will be dynamically generated by JavaScript -->
                    </div>
                    <a href="notifications" class="see-more"><button >See previous notifications</button></a>
                </div>


                <div id="toastContainer" data-message="Welcome back! You have new notifications."></div>
            </nav>
            <!-- NAVBAR -->

            <!-- MAIN -->
            <main>
                <div class="table-data">
                    <div class="order">
                        <div class="head">
                            <h3>My Notifications</h3>
                        </div>
                        <c:choose>
                            <c:when test="${currentUser == null}">
                                <c:redirect url="home" />
                            </c:when>
                            <c:otherwise>
                                <div class="profile-card">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>Message</th>
                                                <th>Date Sent</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:if test="${not empty notifications}">
                                                <c:forEach var="notification" items="${notifications}">
                                                    <tr>
                                                        <td>${notification.message}</td>
                                                        <td>${notification.dateSent}</td>
                                                    </tr>
                                                </c:forEach>
                                            </c:if>
                                            <c:if test="${empty notifications}">
                                                <tr>
                                                    <td colspan="3">No notifications found.</td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>
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
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js@1.11.1/src/toastify.min.js"></script>
        <script src="assests/js/notification.js"></script>
    </body>
</html>
