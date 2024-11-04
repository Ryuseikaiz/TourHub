<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.User" %>
<%@ page import="DataAccess.UserDB"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
                border: 2px solid black; /* Thêm viền đen */
                border-radius: 50%; /* Để viền cũng có hình tròn */
                overflow: hidden; /* Ẩn phần viền ra ngoài nếu có */
            }

            /* Style for the avatar image */
            .avatar {
                width: 250px; /* Điều chỉnh chiều rộng */
                height: 250px; /* Điều chỉnh chiều cao */
                border-radius: 50%; /* Hình tròn */
                object-fit: cover; /* Giữ tỷ lệ hình ảnh */
            }

            /* Style for the overlay */
            .avatar-overlay {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.6);
                border-radius: 50%; /* Hình tròn */
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
                width: 150px; /* Đặt chiều rộng để đảm bảo chúng bằng nhau */
                text-align: center;
                margin: 5px; /* Khoảng cách giữa các nút */
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
                <a href="#" class="notification">
                    <i class='bx bxs-bell' ></i>
                    <!-- <span class="num">8</span> -->
                </a>
                <div class="image-container">
                    <img src="${user.avatar}" alt="User Avatar" class="avatar">
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
                            <c:when test="${user == null}">
                                <c:redirect url="home" />
                            </c:when>
                            <c:otherwise>
                                <div class="profile-card">
                                    <div class="profile-info-left">
                                        <div class="profile-info">
                                            <label>Full Name:</label>
                                            <p><span>${user.first_Name} ${user.last_Name}</span></p>
                                        </div>
                                        <div class="profile-info">
                                            <label>Email:</label>
                                            <p><span>${user.email}</span></p>
                                            <form class="changeform" action="user-updateinfo.jsp" method="get">
                                                <button type="submit" name="buttonChange" value="email">Change email</button>
                                            </form>
                                        </div>
                                        <div class="profile-info">
                                            <label>Phone Number:</label>
                                            <p><span>${user.phone}</span></p>
                                        </div>
                                        <div class="profile-info">
                                            <label>Address:</label>
                                            <p><span>${user.address}</span></p>
                                        </div>
                                        <div class="profile-info">
                                            <label>Password:</label>
                                            <p>
                                                <span id="passwordDisplay">********</span>
                                                <button type="button" onclick="togglePassword()">Show</button>
                                            </p>
                                            <form class="changeform" action="user-updateinfo.jsp" method="get">
                                                <button type="submit" name="buttonChange" value="pass">Change password</button>
                                            </form>
                                        </div>
                                        <c:if test="${user.role == 'Customer'}">
                                            <div class="profile-info">
                                                <label>Birthday: </label>
                                                <p><span>${formattedBirthday}</span></p>
                                            </div>
                                        </c:if>
                                        <c:if test="${user.role == 'Provider'}">
                                            <div class="profile-info">
                                                <label>Tax Code: </label>
                                                <p><span>${user.tax_Code}</span></p>
                                            </div>
                                            <div class="profile-info">
                                                <label>Balance: </label>
                                                <p><span>${user.balance}</span></p>
                                            </div>
                                            <div class="profile-info">
                                                <label>Bank Information: </label>
                                                <p><span>${user.bank_Information}</span></p>
                                            </div>
                                        </c:if>
                                    </div>
                                    <div class="profile-info-right">
                                        <div class="profile-info">
                                            <div class="avatar-container">
                                                <img id="avatarImg" src="${user.avatar}" class="avatar" alt="${user.avatar}" />

                                                <div class="avatar-overlay">
                                                    <form id="uploadForm" action="UploadAvatarServlet" method="post" enctype="multipart/form-data">
                                                        <label for="file-input" class="upload-label">Change Avatar</label>
                                                        <input id="file-input" type="file" name="avatar" accept="image/*" required onchange="previewImage(event)">
                                                        <button type="submit" class="upload-btn" id="uploadBtn" style="display:none;">Upload</button>
                                                        <button type="button" class="upload-btn" id="cancelBtn" style="display:none;" onclick="cancelUpload()">Cancel</button>
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
                                                                    passwordField.innerHTML = "${user.password}";
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
                                                            function previewImage(event) {
                                                                const file = event.target.files[0];
                                                                const imgElement = document.getElementById('avatarImg');

                                                                if (file) {
                                                                    const reader = new FileReader();
                                                                    reader.onload = function (e) {
                                                                        imgElement.src = e.target.result; // Hiển thị ảnh đã chọn
                                                                        document.getElementById('uploadBtn').style.display = 'inline-block'; // Hiện nút Upload
                                                                        document.getElementById('cancelBtn').style.display = 'inline-block'; // Hiện nút Cancel
                                                                    };
                                                                    reader.readAsDataURL(file);
                                                                }
                                                            }

                                                            var userAvatarPath = "${user.avatar}";

                                                            userAvatarPath = userAvatarPath.replace("assestsimages", "assests/images").replace("avatar", "avatar/").replace("imagesavatar", "images/avatar");
                                                            function cancelUpload() {
                                                                document.getElementById('file-input').value = ''; // Reset file input
                                                                document.getElementById('uploadBtn').style.display = 'none'; // Ẩn nút Upload
                                                                document.getElementById('cancelBtn').style.display = 'none'; // Ẩn nút Cancel

                                                                // Đặt lại ảnh về hình ảnh đã lưu
                                                                document.getElementById('avatarImg').src = userAvatarPath; // Gán lại đường dẫn ảnh
                                                            }

        </script>

    </body>
</html>