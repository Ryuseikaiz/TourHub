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
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/toastify-js@1.11.1/src/toastify.min.css"
            />
        <!-- My CSS -->
        <link rel="stylesheet" href="assests/css/style_profile.css">       
        <link href="assests/css/customer.css" rel="stylesheet" />
        <link href="assests/css/notification.css" rel="stylesheet" />

        <title>User Profile</title>
        <style>


            /* Base Styling */
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                color: #333;
            }
            /* Profile Card */
            .profile-card {
                display: flex;
                justify-content: space-between;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 8px;
                background-color: #f9f9f9;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                margin: 20px;
            }

            .profile-info-left,
            .profile-info-right {
                flex: 1;
                margin-right: 20px;
            }
            
            .profile-info-left {
                
                
            }

            .profile-info-right {
                
                margin-right: 0;
            }


            .avatar-container {
                position: relative;
                width: 300px;
                height: 300px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 50%;
                overflow: hidden;
                border: 4px solid #ddd;
            }

            .avatar {
                width: 100%;
                height: 100%;
                border-radius: 50%;
                object-fit: cover; /* Ensures the image fits well inside the circle */
            }

            .avatar-overlay {
                display: flex;
                align-items: center;
                justify-content: center;
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                cursor: pointer;
                border-radius: 50%; /* Ensures overlay is also circular */
                background-color: rgba(0, 0, 0, 0.3); /* Adds a semi-transparent overlay */
                transition: background-color 0.3s ease;
            }

            .avatar-container:hover .avatar-overlay {
                background-color: rgba(0, 0, 0, 0.5); /* Darkens overlay on hover */
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
            <%@include file="includes/user-navbar.jsp" %>
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
                                    <!--Avatar Upload Section-->  
                                    <div class="profile-info-right">
                                        <div class="avatar-container">
                                            <form  id="uploadAvatarForm" action="UploadAvatarServlet" method="POST">
                                                <input type="file" id="avatarImg" name="avatarImg" accept=".jpg, .jpeg, .png, .webp" onchange="handleFileChange(event)" style="display: none;">
                                                <label for="avatarImg" class="avatar-overlay">
                                                    <img id="avatarImgPreview" src="${user.avatar }" alt="User Avatar" class="avatar">                                                    
                                                </label>
                                                <input type="hidden" id="tour_Img_URLs" name="tour_Img_URLs">
                                            </form>
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
            <!--MAIN--> 
        </section>
        <!-- CONTENT 

        <!-- Include profile-related JavaScript -->
        <script src="assests/js/script_profile.js"></script>

        <script>
                                                    function togglePassword() {
                                                        const passwordField = document.getElementById('passwordDisplay');
                                                        const button = event.target;
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
                                                        const profileCard = document.querySelector('.profile-card');

                                                        burger.addEventListener('click', function () {
                                                            navigation.classList.toggle('active');
                                                            main.classList.toggle('active');
                                                            profileCard.classList.toggle('active');
                                                        });
                                                    });


        </script>

        <script src="https://www.gstatic.com/firebasejs/8.0.0/firebase.js"></script>
        <script>
                                                    // Firebase configuration
                                                    const firebaseConfig = {
                                                        apiKey: "AIzaSyADteJKp4c9C64kC08pMJs_jYh-Fa5EX6o",
                                                        authDomain: "tourhub-41aa5.firebaseapp.com",
                                                        projectId: "tourhub-41aa5",
                                                        storageBucket: "tourhub-41aa5.appspot.com",
                                                        messagingSenderId: "556340467473",
                                                        appId: "1:556340467473:web:2f6de24bdbb33709e51eb0"
                                                    };
                                                    firebase.initializeApp(firebaseConfig);

                                                    // Handle file selection and upload to Firebase
                                                    async function handleFileChange(event) {
                                                        const file = event.target.files[0];

                                                        if (!file) {
                                                            alert("No file selected!");
                                                            return;
                                                        }
                                                        if (file.size > 5 * 1024 * 1024) { // 5 MB limit
                                                            alert("File size exceeds 5MB limit!");
                                                            return;
                                                        }

                                                        const storageRef = firebase.storage().ref('avatars/' + file.name);
                                                        const uploadTask = storageRef.put(file);

                                                        uploadTask.on('state_changed',
                                                                (snapshot) => {
                                                            const progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
                                                            console.log(`Upload is ${progress}% done`);
                                                        },
                                                                (error) => {
                                                            console.error("Upload failed:", error);
                                                            alert("Failed to upload image. Please try again.");
                                                        },
                                                                async () => {
                                                            try {
                                                                // Get the download URL after upload completes
                                                                const downloadURL = await uploadTask.snapshot.ref.getDownloadURL();

                                                                // Set the preview image source and the hidden input value
                                                                document.getElementById('avatarImgPreview').src = downloadURL;
                                                                document.getElementById('tour_Img_URLs').value = downloadURL;

                                                                // Only show the submit button or automatically submit after successful upload
                                                                if (downloadURL) {
                                                                    document.getElementById("uploadAvatarForm").submit();
                                                                }
                                                            } catch (error) {
                                                                console.error("Failed to retrieve download URL:", error);
                                                                alert("Failed to retrieve the uploaded image URL. Please try again.");
                                                            }
                                                        }
                                                        );
                                                    }

        </script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js@1.11.1/src/toastify.min.js"></script>
        <script src="assests/js/notification.js"></script>
    </body>
</html>