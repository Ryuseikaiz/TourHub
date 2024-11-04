<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ page import="model.User"%> 
<%@ page import="DataAccess.UserDB"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
        <!-- My CSS -->
        <link rel="stylesheet" href="assests/css/style_profile.css" />
        <link href="assests/css/customer.css" rel="stylesheet" />

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

            /* Style for the delete form */
            .delete-form {
                display: inline; /* Inline to stay with other elements */
            }

            .delete-form input[type="hidden"] {
                display: none; /* Hide hidden inputs */
            }

            .delete-form button {
                background-color: #dc3545; /* Red background */
                color: white; /* White text */
                border: none; /* Remove border */
                padding: 8px 12px; /* Padding for the button */
                border-radius: 5px; /* Rounded corners */
                cursor: pointer; /* Pointer cursor */
                font-size: 14px; /* Font size */
                transition: background-color 0.3s ease; /* Transition for hover effect */
            }

            .delete-form button:hover {
                background-color: #c82333; /* Darker red on hover */
            }

            /* Responsive styles */
            @media (max-width: 768px) {
                .container {
                    grid-template-columns: 1fr;
                }
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
                <a href="#" class="notification">
                    <i class="bx bxs-bell"></i>
                    <!-- <span class="num">8</span> -->
                </a>
                <div class="image-container">
                    <img
                        src="assests/images/avatar.jpg"
                        alt="User Avatar"
                        class="avatar"
                        />
                </div>
            </nav>
            <!-- NAVBAR -->

            <!-- MAIN -->
            <main>
                <div class="table-data">
                    <div class="order">
                        <div class="head">
                            <h3>My Wishlists</h3>
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
                                                <th>ID</th>
                                                <th>Tour Name</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:choose>
                                                <c:when test="${empty wishlistItems}">
                                                    <tr>
                                                        <td colspan="3">No wishlist found.</td>
                                                    </tr>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:forEach var="wishlist" items="${wishlistItems}">
                                                        <tr>
                                                            <td>${wishlist.wish_Id}</td>
                                                            <td>${wishlist.tour_Name}</td>
                                                            <td>
                                                                <a class="action-link approve" href="displayTourDetail?id=${wishlist.tour_Id}">View Details</a>
                                                                <form action="wishlist" method="post" class="delete-form">
                                                                    <input type="hidden" name="wishId" value="${wishlist.wish_Id}" />
                                                                    <input type="hidden" name="action" value="delete" />
                                                                    <button type="submit" onclick="return confirm('Are you sure you want to delete this item?');">Delete</button>
                                                                </form>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
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
    </body>
</html>
