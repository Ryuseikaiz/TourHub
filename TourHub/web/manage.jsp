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
        <section id="sidebar">
            <a href="index.jsp" class="brand">
                <i class='bx bxs-smile'></i>
                <span class="text">TourHub</span>
            </a>
            <ul class="side-menu top">
                <li>
                    <a href="dashboard">
                        <i class='bx bxs-dashboard' ></i>
                        <span class="text">Dashboard</span>
                    </a>
                </li>
                <li class="active">
                    <a href="manage.jsp">
                        <i class='bx bxs-shopping-bag-alt' ></i>
                        <span class="text">System Management</span>
                    </a>
                </li>
                <li>
                    <a href="admin-chat.jsp">
                        <i class='bx bxs-message-dots' ></i>
                        <span class="text">Message</span>
                    </a>
                </li>
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

            </nav>
            <!-- NAVBAR -->

            <!-- MAIN -->
            <main>
                <div class="table-data">
                    <div class="order">
                        <div class="head">
                            <h3>System Management</h3>
                        </div>
                        <c:choose>
                            <c:when test="${currentUser == null}">
                                <c:redirect url="index.jsp" />
                            </c:when>
                            <c:otherwise>
                                <div class="container">
                                    <div class="clickable" data-url="user-manage">User management</div>
                                    <div class="clickable" data-url="tour-manage">Tour management</div>
                                    <div class="clickable" data-url="report-manage">Report management</div>
                                    <div class="clickable" data-url="booking-manage">Booking management</div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </main>
            <!-- MAIN -->
        </section>
        <!-- CONTENT -->

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const clickableDivs = document.querySelectorAll('.container .clickable');
                clickableDivs.forEach(div => {
                    div.addEventListener('click', function () {
                        const action = div.getAttribute('data-url');
                        console.log(action);
                        const url = `manage?action=`+ action;
                        console.log('Redirecting to:', url);
                        window.location.href = url;
                    });
                });
            });
        </script>

        <script src="assests/js/script_profile.js"></script>
    </body>
</html>




