<%@ page contentType="text/html; charset=UTF-8" %> <%@ page import="model.User"
                                                            %> <%@ page import="DataAccess.UserDB"%> <%@ taglib
                                                            uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
        uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastify-js/1.12.0/toastify.min.css">
                <!-- Toasify JavaScript -->
                <script src="https://cdnjs.cloudflare.com/ajax/libs/toastify-js/1.12.0/toastify.min.js"></script>

                <title>User Profile</title>
                <style>
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
                <style>
                    .modal {
                        display: none; /* Hidden by default */
                        position: fixed; /* Stay in place */
                        z-index: 1; /* Sit on top */
                        left: 0;
                        top: 0;
                        width: 100%; /* Full width */
                        height: 100%; /* Full height */
                        overflow: auto; /* Enable scroll if needed */
                        background-color: rgba(0, 0, 0, 0.5); /* Black w/ opacity */
                        margin-left: 10%;
                    }

                    .modal-content {
                        background-color: #fefefe;
                        margin: auto; /* Center the modal */
                        padding: 20px;
                        border: 1px solid #888;
                        border-radius: 10px; /* Tạo border cong hơn */
                        width: 80%; /* Could be more or less, depending on screen size */
                        max-width: 600px; /* Set a maximum width */
                        position: relative; /* Relative positioning for child elements */
                        top: 50%; /* Position the top 50% down */
                        transform: translateY(-50%); /* Move it back up by half its height */
                    }

                    .modal-content h2 {
                        text-align: center; /* Căn giữa tiêu đề */
                        font-size: 24px; /* Tăng kích thước chữ tiêu đề */
                    }

                    .modal-content p {
                        font-size: 18px; /* Tăng kích thước chữ nội dung */
                    }

                    .close {
                        color: #aaa;
                        float: right;
                        font-size: 28px;
                        font-weight: bold;
                    }

                    .close:hover,
                    .close:focus {
                        color: black;
                        text-decoration: none;
                        cursor: pointer;
                    }

                </style>
                <style>
                    .status-filter {
                        display: flex;
                        gap: 10px;
                        margin-bottom: 20px;
                    }
                    .filter-option {
                        padding: 10px;
                        border: 1px solid #ccc;
                        cursor: pointer;
                        text-align: center;
                        text-decoration: none;
                        color: black;
                    }
                    .filter-option.active {
                        background-color: #2196F3;
                        color: white;
                    }
                    /* Style for the form containing the Cancel button */
                    .cancel-form {
                        display: inline; /* Keep the form inline with other elements */
                        margin: 0; /* Remove margin for better alignment */
                    }

                    /* Style for the Cancel button */
                    .cancel-button {
                        background-color: transparent; /* No background color */
                        border: none; /* Remove border */
                        color: #007BFF; /* Text color (Bootstrap primary blue) */
                        cursor: pointer; /* Change cursor to pointer */
                        text-decoration: underline; /* Underline text */
                        font-size: 14px; /* Font size */
                        transition: color 0.3s; /* Smooth color transition on hover */
                    }

                    /* Style for hover effect */
                    .cancel-button:hover {
                        color: #0056b3; /* Darker blue on hover */
                    }

                    /* Optional: Style for when the button is focused */
                    .cancel-button:focus {
                        outline: none; /* Remove outline */
                        color: #0056b3; /* Keep the darker blue on focus */
                    }

                </style>
            </head>
            <body>
                <%@include file="includes/user-sidebar.jsp" %>

                <section id="content">
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
                        </a>
                        <div class="image-container">
                            <img src="assests/images/avatar.jpg" alt="User Avatar" class="avatar" />
                        </div>
                    </nav>

                    <main>
                        <div class="table-data">
                            <div class="order">
                                <div class="head">
                                    <h3>My Bookings</h3>
                                </div>
                                <c:choose>
                                    <c:when test="${currentUser == null}">
                                        <c:redirect url="index.jsp" />
                                    </c:when>
                                    <c:otherwise>
                                        <div class="status-filter">
                                            <a href="booking?status=Booked" class="filter-option ${selectedStatus == 'Booked' ? 'active' : ''}">Booked</a>
                                            <a href="booking?status=Cancelled" class="filter-option ${selectedStatus == 'Cancelled' ? 'active' : ''}">Cancelled</a>
                                            <a href="booking?status=Pending" class="filter-option ${selectedStatus == 'Pending' ? 'active' : ''}">Pending</a>
                                            <a href="booking?status=Refunded" class="filter-option ${selectedStatus == 'Refunded' ? 'active' : ''}">Refunded</a>
                                        </div>
                                        <div class="profile-card">
                                            <table>
                                                <thead>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Tour Name</th>
                                                        <th>Date Booked</th>
                                                        <th>Slot</th>
                                                        <th>Total Cost</th>
                                                        <th>Status</th>
                                                        <th>Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:choose>
                                                        <c:when test="${empty bookings}">
                                                            <tr>
                                                                <td colspan="7">No bookings found.</td>
                                                            </tr>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:forEach var="booking" items="${bookings}">
                                                                <tr>
                                                                    <td>${booking.book_Id}</td>
                                                                    <td>${booking.tour_Name}</td>
                                                                    <td>${booking.created_At}</td>
                                                                    <td>${booking.slot_Order}</td>
                                                                    <td>${booking.total_Cost}</td>
                                                                    <td>${booking.book_Status}</td>
                                                                    <td>
                                                                        <a class="action-link approve" href="javascript:void(0);" onclick="openModal('${booking.book_Id}', '${booking.cus_Name}', '${booking.tour_Name}', '${booking.created_At}', '${booking.slot_Order}', '${booking.total_Cost}', '${booking.book_Status}', '${booking.tour_Date}', '${booking.cancel_Date}', '${booking.booking_Detail}', '${booking.refundAmount}')">
                                                                            View Detail
                                                                        </a>
                                                                        <a class="action-link approve" href="booking?action=viewtour&name=${booking.tour_Name}">View Tour</a>
                                                                        <c:if test="${booking.book_Status == 'Pending'}">
                                                                            <a class="action-link cancel" href="javascript:void(0);" onclick="cancelBooking(event, '${booking.book_Id}');">
                                                                                Cancel
                                                                            </a>
                                                                        </c:if>
                                                                        <c:if test="${booking.book_Status == 'Booked'}">
                                                                            <a class="action-link cancel" href="javascript:void(0);" onclick="refundBooking(event, '${booking.book_Id}');">
                                                                                Refund
                                                                            </a>
                                                                        </c:if>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </tbody>
                                            </table>

                                            <!-- Modal -->
                                            <div id="bookingModal" class="modal" style="display:none;">
                                                <div class="modal-content">
                                                    <span class="close" onclick="closeModal()">&times;</span>
                                                    <h2>Booking Details</h2>
                                                    <div id="modalBookingDetails"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </main>
                </section>

                <script src="assests/js/script_profile.js"></script>
                <script>
                                                        function cancelBooking(event, bookingId) {
                                                            event.preventDefault(); // Ngăn chặn việc gửi biểu mẫu
                                                            const xhr = new XMLHttpRequest();
                                                            xhr.open("POST", "booking");
                                                            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                                                            xhr.onload = function () {
                                                                const response = JSON.parse(xhr.responseText);
                                                                Toastify({
                                                                    text: response.message,
                                                                    duration: 3000,
                                                                    gravity: "top",
                                                                    position: 'right',
                                                                    backgroundColor: response.message.includes("successfully") ? "#28a745" : "#dc3545",
                                                                    stopOnFocus: true
                                                                }).showToast();

                                                                // Tải lại trang hiện tại sau khi hiển thị thông báo
                                                                if (response.message.includes("successfully")) {
                                                                    location.reload(); // Tải lại trang
                                                                }
                                                            };
                                                            xhr.send("action=cancelbook&id=" + bookingId);
                                                        }
                                                        
                                                        function refundBooking(event, bookingId) {
                                                            event.preventDefault(); // Ngăn chặn việc gửi biểu mẫu
                                                            const xhr = new XMLHttpRequest();
                                                            xhr.open("POST", "booking");
                                                            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                                                            xhr.onload = function () {
                                                                const response = JSON.parse(xhr.responseText);
                                                                Toastify({
                                                                    text: response.message,
                                                                    duration: 3000,
                                                                    gravity: "top",
                                                                    position: 'right',
                                                                    backgroundColor: response.message.includes("successfully") ? "#28a745" : "#dc3545",
                                                                    stopOnFocus: true
                                                                }).showToast();

                                                                // Tải lại trang hiện tại sau khi hiển thị thông báo
                                                                if (response.message.includes("successfully")) {
                                                                    location.reload(); // Tải lại trang
                                                                }
                                                            };
                                                            xhr.send("action=refundbook&id=" + bookingId);
                                                        }


                                                        function openModal(bookId, customerName, tourName, bookingDate, slotOrder, totalCost, bookingStatus, tourDate, cancelDate, bookingDetail, refundAmount) {
                                                            document.getElementById("modalBookingDetails").innerHTML =
                                                                    "<p><strong>Booking ID:</strong> " + (bookId || 'N/A') + "</p>" +
                                                                    "<p><strong>Customer Name:</strong> " + (customerName || 'N/A') + "</p>" +
                                                                    "<p><strong>Tour Name:</strong> " + (tourName || 'N/A') + "</p>" +
                                                                    "<p><strong>Booking Date:</strong> " + (bookingDate || 'N/A') + "</p>" +
                                                                    "<p><strong>Slot Order:</strong> " + (slotOrder || 'N/A') + "</p>" +
                                                                    "<p><strong>Total Cost:</strong> " + (totalCost || 'N/A') + "</p>" +
                                                                    "<p><strong>Status:</strong> " + (bookingStatus || 'N/A') + "</p>" +
                                                                    "<p><strong>Tour Date:</strong> " + (tourDate || 'N/A') + "</p>" +
                                                                    "<p><strong>Cancel Date:</strong> " + (cancelDate ? cancelDate : 'Not available') + "</p>" +
                                                                    "<p><strong>Booking Detail:</strong> " + (bookingDetail || 'N/A') + "</p>" +
                                                                    "<p><strong>Refund Amount:</strong> " + (refundAmount ? refundAmount : 'Not available') + "</p>";

                                                            document.getElementById("bookingModal").style.display = "block";
                                                        }

                                                        function closeModal() {
                                                            document.getElementById("bookingModal").style.display = "none";
                                                        }
                </script>
            </body>

        </html>
