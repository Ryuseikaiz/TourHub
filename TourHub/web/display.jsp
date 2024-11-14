<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard Admin</title>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <!-- Boxicons -->
        <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
        <!-- My CSS -->
        <link rel="stylesheet" href="assests/css/style_profile.css">  
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastify-js/1.12.0/toastify.min.css">
        <!-- Toasify JavaScript -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastify-js/1.12.0/toastify.min.js"></script>

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

            .tab-container {
                text-align: center; /* Căn giữa các tab theo chiều ngang */
                margin-bottom: 20px; /* Khoảng cách giữa các tab và phần tử bên dưới */
            }

            .status-tab {
                display: inline-block; /* Hiển thị các tab trong một hàng */
                padding: 10px 15px; /* Khoảng cách xung quanh nội dung */
                margin-right: 10px; /* Khoảng cách giữa các tab */
                text-decoration: none; /* Bỏ gạch chân cho liên kết */
                color: #fff; /* Màu chữ */
                background-color: #ff7f50; /* Màu nền cho tab (màu cam) */
                border-radius: 4px; /* Bo tròn các góc */
                transition: background-color 0.3s; /* Hiệu ứng chuyển màu nền */
            }

            .status-tab:hover {
                background-color: #e95e3c; /* Màu nền khi hover (màu cam đậm hơn) */
            }

            .status-tab.active {
                background-color: #e95e3c; /* Màu nền cho tab đang hoạt động (màu cam đậm hơn) */
                font-weight: bold; /* Đậm chữ cho tab đang hoạt động */
            }


            /* Responsive styles */
            @media (max-width: 768px) {
                .container {
                    grid-template-columns: 1fr;
                }
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




    </head>
    <body>
        <%@include file="includes/admin-sidebar.jsp" %>
        <!-- CONTENT -->
        <section id="content">
            <!-- NAVBAR -->
            <%@include file="includes/admin-navbar.jsp" %>
            <!-- NAVBAR -->

            <!-- MAIN -->
            <main>
                <div class="table-data">
                    <div class="order">
                        <c:choose>
                            <c:when test="${currentUser == null || (currentUser != null && currentUser.role != 'Admin')}">
                                <c:redirect url="home" />
                            </c:when>
                            <c:when test="${type == 'user'}">
                                <h3>User Management</h3>
                                <table>
                                    <thead>
                                        <tr>
                                            <th>User ID</th>
                                            <th>Username</th>
                                            <th>Email</th>
                                            <th>User Status</th>
                                            <th>Role</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="user" items="${data}">
                                            <tr>
                                                <td>${user.user_Id}</td>
                                                <td>${user.first_Name} ${user.last_Name}</td>
                                                <td>${user.email}</td>
                                                <td>${user.user_Status}</td>
                                                <td>${user.role}</td>
                                                <td>
                                                    <div class="action-container">
                                                        <a href="manage?action=user-ban&id=${user.user_Id}" class="action-link cancel">Ban</a>
                                                        <a href="manage?action=user-unban&id=${user.user_Id}" class="action-link approve">UnBan</a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>

                            <c:when test="${type == 'tour'}">
                                <h3>Tour Management</h3>
                                <div class="tab-container">
                                    <a href="manage?action=tour-manage&status=Pending" class="status-tab ${status == 'Pending' ? 'active' : ''}">Pending</a>
                                    <a href="manage?action=tour-manage&status=Active" class="status-tab ${status == 'Active' ? 'active' : ''}">Approved</a>
                                    <a href="manage?action=tour-manage&status=Cancelled" class="status-tab ${status == 'Cancelled' ? 'active' : ''}">Cancelled</a>
                                    <a href="manage?action=tour-manage&status=Banned" class="status-tab ${status == 'Banned' ? 'active' : ''}">Banned</a>
                                </div>
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Tour ID</th>
                                            <th>Tour Name</th>
                                            <th>Location</th>
                                            <th>Start Date</th>
                                            <th>End Date</th>
                                            <!--                                            <th>Price</th>-->
                                            <th>Tour Status</th>
                                                <c:if test="${status == 'Pending' || status == 'Active'}">
                                                <th>Action</th>
                                                </c:if>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="tour" items="${data}">
                                            <tr>
                                                <td>${tour.tour_Id}</td>
                                                <td>${tour.tour_Name}</td>
                                                <td>${tour.location}</td>
                                                <td>${tour.start_Date}</td>
                                                <td>${tour.end_Date}</td>
<!--                                                <td>${tour.price}</td>-->
                                                <td>${tour.tour_Status}</td>
                                                <c:if test="${status == 'Pending'}">
                                                    <td>
                                                        <div class="action-container">
                                                            <a href="manage?action=approve-tour&id=${tour.tour_Id}" class="action-link approve">Approve</a>
                                                            <a href="manage?action=cancel-tour&id=${tour.tour_Id}" class="action-link cancel">Cancel</a>
                                                        </div>
                                                    </td>
                                                </c:if>
                                                <c:if test="${status == 'Active'}">
                                                    <td>
                                                        <div class="action-container">
                                                            <a href="manage?action=ban-tour&id=${tour.tour_Id}" class="action-link cancel">Ban</a>
                                                        </div>
                                                    </td>
                                                </c:if>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>

                            <c:when test="${type == 'report'}">
                                <h3>Report Management</h3>
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Report ID</th>
                                            <th>Type</th>
                                            <th>Details</th>
                                            <th>Date</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="report" items="${data}">
                                            <tr>
                                                <td>${report.report_Id}</td>
                                                <td>${report.report_Type}</td>
                                                <td>${report.report_Details}</td>
                                                <td>${report.report_Date}</td>
                                                <td>
                                                    <div class="action-container">
                                                        <a href="manage?action=delete-report&id=${report.report_Id}" class="action-link cancel">Delete</a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>

                            <c:when test="${type == 'booking'}">
                                <h3>Booking Management</h3>
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Booking ID</th>
                                            <th>Customer Name</th>
                                            <th>Tour Name</th>
                                            <th>Booking Date</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="booking" items="${data}">
                                            <tr>
                                                <td>${booking.book_Id}</td>
                                                <td>${booking.cus_Name}</td>
                                                <td>${booking.tour_Name}</td>
                                                <td>${booking.created_At}</td>
                                                <td>${booking.book_Status}</td>
                                                <td>
                                                    <a class="action-link approve" 
                                                       href="javascript:void(0);" 
                                                       onclick="(function () {
                                                                   console.log('Opening modal with:', '${booking.book_Id}', '${booking.cus_Name}', '${booking.tour_Name}', '${booking.created_At}', '${booking.slot_Order}', '${booking.total_Cost}', '${booking.book_Status}', '${booking.tour_Date}', '${booking.cancel_Date}', '${booking.booking_Detail}', '${booking.refundAmount}');
                                                                   openModal('${booking.book_Id}', '${booking.cus_Name}', '${booking.tour_Name}', '${booking.created_At}', '${booking.slot_Order}', '${booking.total_Cost}', '${booking.book_Status}', '${booking.tour_Date}', '${booking.cancel_Date}', '${booking.booking_Detail}', '${booking.refundAmount}');
                                                               })()">
                                                        View Detail
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                                <!-- Modal -->
                                <div id="bookingModal" class="modal" style="display:none;">
                                    <div class="modal-content">
                                        <span class="close" onclick="closeModal()">&times;</span>
                                        <h2>Booking Details</h2>
                                        <div id="modalBookingDetails">
                                            <!-- Booking details will be inserted here -->
                                        </div>
                                    </div>
                                </div>
                            </c:when>

                            <c:when test="${type == 'withdrawal'}">
                                <h3>Withdrawal Management</h3>
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Withdrawal ID</th>
                                            <th>Provider Id</th>
                                            <th>Money</th>
                                            <th>Request Date</th>
                                            <th>Response Date</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="withdrawal" items="${data}">
                                            <tr>
                                                <td>${withdrawal.id}</td>
                                                <td>${withdrawal.providerId}</td>
                                                <td>${withdrawal.withdrawMoney}</td>
                                                <td>${withdrawal.requestDate}</td>
                                                <td>${withdrawal.companyBank}</td>
                                                <td>${withdrawal.status}</td>
                                                <td>
                                                    <div class="action-container">
                                                        <a href="#" class="action-link approve showQRBtn"
                                                           data-id="${withdrawal.id}"
                                                           data-bank="${withdrawal.companyBank}"
                                                           data-money="${withdrawal.withdrawMoney}">Show QR</a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                                <!-- Modal QR (chỉ cần một modal duy nhất) -->
                                <div id="qrModal" class="modal" style="display: none;">
                                    <div class="modal-content">
                                        <img class="tour-qr-img" src="" alt="QR Code">
                                        <div id="paid-content"></div>
                                    </div>
                                </div>

                                <!-- Modal thành công thanh toán -->
                                <div class="modal fade" id="statusSuccessModal" tabindex="-1" role="dialog" data-bs-backdrop="static" data-bs-keyboard="false">
                                    <div class="modal-dialog modal-dialog-centered modal-sm" role="document">
                                        <div class="modal-content">
                                            <div class="modal-body text-center p-lg-4">
                                                <svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 130.2 130.2">
                                                <circle class="path circle" fill="none" stroke="#198754" stroke-width="6" stroke-miterlimit="10" cx="65.1" cy="65.1" r="62.1" />
                                                <polyline class="path check" fill="none" stroke="#198754" stroke-width="6" stroke-linecap="round" stroke-miterlimit="10" points="100.2,40.2 51.5,88.8 29.8,67.5 " />
                                                </svg>
                                                <h4 class="text-success mt-3">Payment Complete!</h4>
                                                <p class="mt-3">You have successfully booked a tour.</p>
                                                <button type="button" class="btn btn-sm mt-3 btn-success" data-bs-dismiss="modal" onclick="window.location.href = '/home'">Ok</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:when>

                        </c:choose>
                    </div>
                </div>
            </main>
            <!-- MAIN -->
        </section>
        <!-- CONTENT -->
        <script src="assests/js/script_profile.js"></script>
        <script>
                        window.onload = function () {
                            const message = '${message}';
                            if (message) {
                                Toastify({
                                    text: message,
                                    duration: 3000, // Thời gian hiển thị (3 giây)
                                    gravity: "top", // Vị trí hiển thị (top/bottom)
                                    position: 'right', // Vị trí bên trái/bên phải
                                    backgroundColor: "linear-gradient(to right, #00b09b, #96c93d)", // Màu nền
                                }).showToast();

                                // Xóa message sau khi đã hiển thị
            <c:remove var="message" />
                            }
                        };
        </script>
        <script>
            function openModal(bookId, customerName, tourName, bookingDate, slotOrder, totalCost, bookingStatus, tourDate, cancelDate, bookingDetail, refundAmount) {
                // Cập nhật nội dung trong modalBookingDetails trực tiếp
                document.getElementById("modalBookingDetails").innerHTML =
                        "<p><strong>Booking ID:</strong> " + (bookId || 'N/A') + "</p>" +
                        "<p><strong>Customer Name:</strong> " + (customerName || 'N/A') + "</p>" +
                        "<p><strong>Tour Name:</strong> " + (tourName || 'N/A') + "</p>" +
                        "<p><strong>Booking Date:</strong> " + (bookingDate || 'N/A') + "</p>" +
                        "<p><strong>Slot Order:</strong> " + (slotOrder || 'N/A') + "</p>" +
                        "<p><strong>Total Cost:</strong> " + (totalCost || 'N/A') + "</p>" +
                        "<p><strong>Status:</strong> " + (bookingStatus || 'N/A') + "</p>" +
                        "<p><strong>Tour Date:</strong> " + (tourDate || 'N/A') + "</p>" +
                        "<p><strong>Cancel Date:</strong> " + (cancelDate ? cancelDate : 'Not have yet') + "</p>" +
                        "<p><strong>Booking Detail:</strong> " + (bookingDetail || 'N/A') + "</p>" +
                        "<p><strong>Refund Amount:</strong> " + (refundAmount ? refundAmount : 'Not have yet') + "</p>";

                // Hiển thị modal
                document.getElementById("bookingModal").style.display = "block";
            }

            function closeModal() {
                // Đóng modal
                document.getElementById("bookingModal").style.display = "none";
            }

        </script>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Đóng modal khi nhấn vào bất kỳ đâu ngoài modal content
                window.addEventListener("click", function (event) {
                    const modal = document.getElementById("qrModal");
                    if (modal && event.target === modal) {
                        modal.style.display = "none"; // Đóng modal
                    }
                });

                // Sự kiện click vào các nút "Show QR"
                const showQRBtns = document.querySelectorAll(".showQRBtn");
                showQRBtns.forEach(function (btn) {
                    btn.addEventListener("click", function (event) {
                        event.preventDefault(); // Ngừng hành động mặc định của link

                        // Lấy dữ liệu từ thuộc tính data-* của nút
                        const withdrawal = {
                            companyBank: btn.getAttribute('data-bank'),
                            withdrawMoney: btn.getAttribute('data-money')
                        };

                        // Tách dữ liệu từ withdrawal.companyBank
                        const bankInfo = withdrawal.companyBank.split(" "); // Tách chuỗi thành mảng, dùng " " làm dấu phân cách
                        const accountNo = bankInfo[0]; // Số tài khoản
                        const bankName = bankInfo.slice(1).join(" "); // Tên ngân hàng (nếu có nhiều từ, ghép lại)

                        // Tạo đối tượng MY_BANK từ dữ liệu đã tách
                        const MY_BANK = {
                            BANK_ID: bankName, // Đặt tên ngân hàng vào BANK_ID
                            ACCOUNT_NO: accountNo // Đặt số tài khoản vào ACCOUNT_NO
                        };

                        // Tạo URL QR Code sử dụng MY_BANK
                        const qrUrl = "https://img.vietqr.io/image/" + MY_BANK.BANK_ID + "-" + MY_BANK.ACCOUNT_NO + "-compact2.jpg?amount=" + withdrawal.withdrawMoney + "&addInfo=thanh%20toan%20boi%20tourhub";

                        // Kiểm tra xem phần tử qrImg có tồn tại trong DOM không
                        const qrImg = document.querySelector(".tour-qr-img");
                        if (qrImg) {
                            qrImg.src = qrUrl;  // Chỉ thay đổi src nếu phần tử tồn tại
                        }

                        // Kiểm tra xem phần tử #paid-content có tồn tại không
                        const paidContent = document.getElementById("paid-content");
                        if (paidContent) {
                            paidContent.textContent = "Bank: " + MY_BANK.BANK_ID + ", Amount: " + withdrawal.withdrawMoney;
                        }

                        // Hiển thị modal
                        const modal = document.getElementById("qrModal");
                        if (modal) {
                            modal.style.display = "block";
                        }

                        // Gọi checkPaid sau khi tạo mã QR
                        setTimeout(() => {
                            checkInterval = setInterval(() => {
                                checkPaid(-withdrawal.withdrawMoney, MY_BANK.ACCOUNT_NO + " " + MY_BANK.BANK_ID);
                            }, 1000);
                        }, 10000); // Đợi 10 giây trước khi bắt đầu kiểm tra thanh toán
                    });
                });
            });

// Biến để theo dõi trạng thái thanh toán thành công
            let isSuccess = false;
            let checkInterval = null;

            async function checkPaid(price, content) {
                if (isSuccess) {
                    return;
                }

                try {
                    const response = await fetch("https://script.google.com/macros/s/AKfycbzUZ3aGbGOZsAgwgGaRreU4HM0F8fi9RoQZnUE-TWCOYX0sWymFkSlfW_ZA73iV5GCQ/exec");
                    const data = await response.json();
                    const lastPaid = data.data[data.data.length - 1];

                    const lastPrice = lastPaid["Giá trị"];
                    const lastContent = lastPaid["Mô tả"];

                    // Kiểm tra thanh toán thành công
                    if (lastPrice >= price && lastContent.includes(content)) {
                        isSuccess = true;
                        clearInterval(checkInterval); // Dừng lại khi thanh toán thành công

                        // Hiển thị modal thành công thanh toán
                        const paymentSuccessModal = new bootstrap.Modal(document.getElementById('statusSuccessModal'));
                        paymentSuccessModal.show();

                        // Chuyển hướng đến trang /home khi thanh toán thành công
                        setTimeout(() => {
                            window.location.href = '/home'; // Chuyển hướng đến trang chủ
                        }, 3000); // Đợi 3 giây trước khi chuyển hướng
                    } else {
                        console.log("Payment not successful yet.");
                    }
                } catch (error) {
                    console.error("Error occurred during payment check:", error);
                }
            }


        </script>

    </body>
</html>





