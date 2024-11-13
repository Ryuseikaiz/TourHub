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
        <link rel="stylesheet" href="assests/css/bootstrap.css" />       

        <!-- Include Toastify CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Toastify/1.11.1/Toastify.min.css">
        <!-- Include Toastify JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Toastify/1.11.1/Toastify.min.js"></script>


        <title>Add Tour</title>
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
                <a href="#" class="notification">
                    <i class='bx bxs-bell' ></i>
                    <!-- <span class="num">8</span> -->
                </a>
                <div class="image-container">
                    <img src="assests/images/avatar.jpg" alt="User Avatar" class="avatar">
                </div>
            </nav>
            <!-- NAVBAR -->

            <!-- MAIN -->
            <main>
                <div class="table-data">
                    <div class="order">
                        <h3 class="head">Add Tour</h3>                   
                        <form action="provider-management?action=add-tour" method="POST" enctype="multipart/form-data" onsubmit="return submitForm(event);" > <!-- Combined form with file upload -->
                            <div class="form-group required">
                                <label for="tour_Name">Tour Name: <span style="color: red;">*</span></label>
                                <input type="text" class="form-control" id="tour_Name" name="tour_Name" maxlength="255" required>
                            </div>
                            <div class="form-group required">
                                <label for="tour_Description">Tour Description: <span style="color: red;">*</span></label>
                                <textarea class="form-control" id="tour_Description" name="tour_Description" rows="4" required style="width: 100%; resize: vertical;"></textarea>
                            </div>
                            <div class="form-group required">
                                <label for="start_Date">Start Date: <span style="color: red;">*</span></label>
                                <input type="date" class="form-control" id="start_Date" name="start_Date" required onchange="validateDates(); calculateDuration();" min="">
                                <span id="startDateError" style="color: red; display: none;">Start date cannot be in the past.</span>
                            </div>

                            <div class="form-group required">
                                <label for="end_Date">End Date: <span style="color: red;">*</span></label>
                                <input type="date" class="form-control" id="end_Date" name="end_Date" required onchange="validateDates(); calculateDuration();">
                                <span id="endDateError" style="color: red; display: none;">End date cannot be before the start date.</span>
                            </div>

                            <div class="form-group required">
                                <label for="total_Time">Duration</label>
                                <div class="d-flex align-items-center">
                                    <div class="mr-3">
                                        <input type="number" id="day" name="day" class="form-control" required placeholder="Days" readonly>
                                    </div>
                                    <div>
                                        <input type="number" id="night" name="night" class="form-control" required placeholder="Nights" readonly>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="location">Location: <span style="color: red;">*</span></label>
                                <select class="form-control" id="location" name="location" style="height: 40px;
                                        padding: 8px;
                                        font-size: 16px;" required>
                                    <option value="">Select a province</option>
                                    <c:set var="location" value="${location}"/> <!-- Move this line outside the forEach -->
                                    <c:forEach var="province" items="${provinces}">
                                        <option value="${province.province_name}" style="height: 40px;
                                                padding: 8px;
                                                font-size: 16px;"
                                                <c:if test="${province.province_name == location}">selected</c:if>
                                                >${province.province_name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group required">
                                <label for="slot">Slot: <span style="color: red;">*</span></label>
                                <input type="number" class="form-control" id="slot" name="slot" required>
                                <small id="slotError" style="color: red; display: none;">Slot must be a non-negative number.</small>
                            </div>          
                            <div class="form-group required">
                                <label for="tour_Img">Tour Images: <span style="color: red;">*</span></label>
                                <input type="file" class="form-control-file" id="fileButton" accept=".jpg, .jpeg, .png, .webp" multiple required>
                                <progress value="0" max="100" id="uploader">0%</progress>
                                <input type="hidden" id="tour_Img_URL" name="tour_Img_URL">                                
                                <small class="form-text text-muted">Upload image files (JPG, PNG, etc.), each not exceeding 2MB.</small>
                            </div>
                            <div id="imgDiv"></div>
                            <c:out value="${message}"/>
                            <button type="submit" class="btn btn-primary btn-block action-link approve">Add Tour</button>

                        </form>
                    </div>
                </div>
            </main>          
            <!-- MAIN -->
            <div id="toastContainer" data-message="<c:out value='${message}' />"></div>
        </section>
        <!-- CONTENT -->
        <script src="assests/js/script_profile.js"></script>             
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://www.gstatic.com/firebasejs/4.2.0/firebase.js"></script>


        <!--        <script>
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
        
                </script>-->
        <!--<script src="dist/js/theme.min.js"></script>-->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <script src="./assests/js/edit-tour.js"></script>
        <script type="text/javascript">
                                    const firebaseConfig = {
                                        apiKey: "AIzaSyADteJKp4c9C64kC08pMJs_jYh-Fa5EX6o",
                                        authDomain: "tourhub-41aa5.firebaseapp.com",
                                        projectId: "tourhub-41aa5",
                                        storageBucket: "tourhub-41aa5.appspot.com",
                                        messagingSenderId: "556340467473",
                                        appId: "1:556340467473:web:2f6de24bdbb33709e51eb0",
                                        measurementId: "G-0JBZE81PGF"
                                    };
                                    firebase.initializeApp(firebaseConfig);

                                    const uploader = document.getElementById('uploader');
                                    const fileButton = document.getElementById('fileButton');
                                    const saveButton = document.querySelector('button[type="submit"]');
                                    saveButton.disabled = true; // Disable save button initially

                                    let uploadedCount = 0; // Track the count of uploaded files
                                    let totalFiles = 0; // Total files selected
                                    const imageUrls = [];

                                    fileButton.addEventListener('change', function (e) {
                                        uploadedCount = 0; // Reset the upload count on new selection
                                        totalFiles = e.target.files.length; // Set total files selected
                                        Array.from(e.target.files).forEach(uploadFile);
                                    });

                                    function uploadFile(file) {
                                        const storageRef = firebase.storage().ref('images/' + file.name);
                                        const uploadTask = storageRef.put(file);

                                        uploadTask.on(firebase.storage.TaskEvent.STATE_CHANGED, function (snapshot) {
                                            const progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
                                            uploader.value = progress;
                                            saveButton.disabled = true; // Disable save button during upload
                                        }, function (error) {
                                            console.error("Upload failed:", error);
                                        }, function () {
                                            uploadTask.snapshot.ref.getDownloadURL().then(function (downloadURL) {
                                                imageUrls.push(downloadURL);
                                                document.getElementById("tour_Img_URL").value = imageUrls.join(';');
                                                displayImage(downloadURL);

                                                uploadedCount++; // Increase the count of uploaded files
                                                if (uploadedCount === totalFiles) {
                                                    saveButton.disabled = false; // Enable save button when all files are uploaded
                                                }
                                            });
                                        });
                                    }

                                    function displayImage(url) {
                                        const imgDiv = document.getElementById("imgDiv");
                                        const imgElement = document.createElement("img");
                                        imgElement.src = url;
                                        imgElement.width = 100;
                                        imgElement.height = 100;
                                        imgDiv.appendChild(imgElement);
                                    }
        </script>


    </body>
</html>
