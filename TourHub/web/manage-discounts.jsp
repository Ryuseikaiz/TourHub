<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Discount" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
        <link rel="stylesheet" href="assests/css/style_profile.css">
        <link rel="stylesheet" href="assests/css/manage-discounts.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastify-js/1.12.0/toastify.min.css">
        <!-- Toasify JavaScript -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastify-js/1.12.0/toastify.min.js"></script>
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/toastify-js@1.11.1/src/toastify.min.css"
            />
        <link rel="stylesheet" href="assests/css/notification.css" />
        <title>Manage Discounts</title>
        <style>
            /* Modal container */
            .modal {
                display: none;
                position: fixed;
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5); /* Black background with transparency */
            }

            /* Modal content */
            .modal-content {
                background-color: #fff;
                margin: 15% auto;
                padding: 20px;
                border: 1px solid #888;
                width: 30%;
                border-radius: 10px;
                text-align: center;
            }

            /* Close button */
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

            /* Confirm & Cancel buttons */
            .btn-confirm, .btn-cancel {
                padding: 10px 20px;
                margin: 10px;
                border: none;
                cursor: pointer;
                border-radius: 5px;
            }

            .btn-confirm {
                background-color: #28a745;
                color: white;
            }

            .btn-cancel {
                background-color: #dc3545;
                color: white;
            }

            /* General Table Styling */
            table {
                width: 100%;
                border-collapse: collapse;
                border: 1px solid #ddd;
            }

            th, td {
                border: 1px solid #ddd;
                padding: 5px;
                text-align: center;
                vertical-align: middle;
            }

            th {
                background-color: #f2f2f2;
            }

            td form {
                display: inline-block;
                margin-right: 10px; /* Space between the buttons */
            }

            td button {
                display: inline-block;
                padding: 8px 12px;
                background-color: #007BFF;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            td button:hover {
                background-color: #0056b3;
            }

            .btn-delete {
                background-color: #DB504A; /* Red Delete Button */
            }

            .btn-delete:hover {
                background-color: #c82333; /* Darker Red on Hover */
            }

            .create-button {
                padding: 8px 12px;
                background-color: #007BFF;
                color: white;
                text-decoration: none;
                border-radius: 4px;
                transition: background-color 0.3s;
            }

            .create-button:hover {
                background-color: #0056b3;
            }

            /* Modal styling */
            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                justify-content: center;
                align-items: center;
                opacity: 0;
                transition: opacity 0.5s ease;
            }

            .modal.show {
                display: flex;
                opacity: 1;
            }

            .modal-content {
                background-color: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
                width: 400px;
                text-align: center;
            }

            .modal .close {
                color: #aaa;
                float: right;
                font-size: 24px;
                cursor: pointer;
            }

            .modal .close:hover {
                color: black;
            }

            .btn-confirm:hover {
                background-color: #218838;
            }

            .btn-cancel:hover {
                background-color: #c82333;
            }
            main{
                min-height: 100vh;
            }
        </style>
    </head>
    <body>
        <%@include file="includes/user-sidebar.jsp" %>
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
                <a href="#" class="profile">
                    <img src="img/people.png">
                </a>
            </nav>
            <!-- NAVBAR -->

            <!-- MAIN -->
            <main>
                <%
    String errorMessage = (String) session.getAttribute("error");
    String successMessage = (String) session.getAttribute("message");
    
    // Hiển thị thông báo lỗi nếu có
    if (errorMessage != null) {
                %> 
                <div style="color:red; margin-bottom: 10px;">
                    <%= errorMessage %>
                </div>
                <%
                        // Xóa thông báo lỗi khỏi session để không hiển thị lại
                        session.removeAttribute("error");
                    }

                    // Hiển thị thông báo thành công nếu có
                    if (successMessage != null) {
                %> 
                <div style="color:green; margin-bottom: 10px;">
                    <%= successMessage %>
                </div>
                <%
                        // Xóa thông báo thành công khỏi session để không hiển thị lại
                        session.removeAttribute("message");
                    }
                %>

                <div class="table-data">
                    <div class="order">
                        <div class="head">
                            <h3>Manage Discounts</h3>
                            <a href="create-discount" class="create-button">Create New Discount</a>
                        </div>
                        <table>
                            <thead>
                                <tr>
                                    <th>Code</th>
                                    <th>Quantity</th>
                                    <th>Percent Discount</th>
                                    <th>Start Day</th>
                                    <th>End Day</th>
                                    <th>Require</th>
                                    <th>Tour Name</th> <!-- Update column title -->
                                    <th>Description</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                List<Discount> discounts = (List<Discount>) request.getAttribute("listDiscount");
                                if (discounts != null && !discounts.isEmpty()) { 
                                    for (Discount discount : discounts) { %>
                                <tr>
                                    <td><%= discount.getCode() %></td>
                                    <td><%= discount.getQuantity() %></td>
                                    <td><%= discount.getPercent_Discount() %></td>
                                    <td><%= discount.getStart_Day() %></td>
                                    <td><%= discount.getEnd_Day() %></td>
                                    <td><%= discount.getRequire() %></td>
                                    <td><%= discount.getTour_name() %></td> <!-- Display tour_name -->
                                    <td><%= discount.getDescription() %></td>
                                    <td>
                                        <form action="edit-discount" method="get" style="display: inline-block; margin-right: 10px;">
                                            <input type="hidden" name="action" value="edit">
                                            <input type="hidden" name="id" value="<%= discount.getDiscount_Id() %>">
                                            <button type="submit" class="btn btn-primary">Edit</button>
                                        </form>

                                        <button class="btn btn-delete" onclick="showModal('<%= discount.getDiscount_Id() %>')" style="display: inline-block;" >Delete</button>
                                    </td>
                                </tr>
                                <% } 
    } else { %>
                                <tr>
                                    <td colspan="9">No discounts available.</td>
                                </tr>
                                <% } %>
                            </tbody>

                        </table>
                    </div>
                </div>
            </main>
            <!-- MAIN -->
        </section>
        <!-- CONTENT -->

        <!-- Modal for confirmation -->
        <div id="deleteModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeModal()">&times;</span>
                <p>Are you sure you want to delete this discount?</p>
                <form id="deleteForm" action="discount" method="post">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" id="discountId">
                    <button type="submit" class="btn-confirm">Yes, Delete</button>
                    <div class="action-container">
                        <button type="button" class="btn-cancel" onclick="closeModal()" class="action-link approve">Cancel</button>
                    </div>
                </form>
            </div>
        </div>

        <script src="assests/js/script_profile.js"></script>

        <!-- Script cho popup xác nhận xóa -->
        <script>
                            function showModal(discountId) {
                                document.getElementById('discountId').value = discountId;
                                document.getElementById('deleteModal').classList.add('show');
                            }

                            function closeModal() {
                                document.getElementById('deleteModal').classList.remove('show');
                            }

                            // Close the modal if the user clicks outside of it
                            window.onclick = function (event) {
                                const modal = document.getElementById('deleteModal');
                                if (event.target == modal) {
                                    closeModal();
                                }
                            }
        </script>
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
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js@1.11.1/src/toastify.min.js"></script>
        <script src="assests/js/notification.js"></script>
    </body>
</html>
