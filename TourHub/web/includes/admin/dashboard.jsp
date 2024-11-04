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
        <link rel="stylesheet" type="text/css" href="assests/css/dashboard.css">   

        <style>
            .head button {
                border-radius: 20px; /* Add border radius to the button */
                padding: 8px 15px; /* Optional: Adjust padding for better appearance */
                background-color: #ff5722; /* Optional: Set background color for button */
                color: #fff; /* Optional: Set text color for button */
                border: none; /* Optional: Remove default border */
                cursor: pointer; /* Optional: Change cursor to pointer on hover */
            }

            .head button:hover {
                background-color: #e64a19; /* Optional: Darken button on hover */
            }

            h3 {
                text-align: center; /* Center the heading */
                color: #333; /* Dark color for the heading */
                margin-bottom: 15px; /* Space below the heading */
            }

            .select-container {
                display: flex; /* Use flexbox */
                justify-content: center; /* Center horizontally */
            }

            select {
                padding: 20px; /* Padding inside the select */
                padding-left:2%;
                padding-right:2%;
                border: 1px solid #ccc; /* Border around the select */
                border-radius: 5px; /* Rounded corners */
                font-size: 16px; /* Increase font size */
                appearance: none; /* Remove default arrow for better customization */
                background-color: #fff; /* White background for the select */
            }

            #monthlyBookingsChart {
                width: 100% !important; /* Ensure the canvas takes full width */
                height: 100% !important; /* Ensure the canvas takes full height */
            }

            .ye {
                margin-top: 10px;
            }
        </style>
    </head>
    <body>
        <%@include file="../admin-sidebar.jsp" %>
        <!-- CONTENT -->
        <section id="content">
            <!-- NAVBAR -->
            <%@include file="../admin-navbar.jsp" %>
            <!-- NAVBAR -->

            <!-- MAIN -->
            <main>
                <div class="table-data">
                    <div class="order">
                        <div class="head">
                            <h3>View Website Statistic</h3>
                            <div>
                                <form method="post" action="exportfile">
                                    <button type="submit">Export File</button>
                                </form>
                            </div>
                        </div>
                        <c:choose>
                            <c:when test="${currentUser == null || (currentUser != null && currentUser.role != 'Admin')}">
                                <c:redirect url="home" />
                            </c:when>
                            <c:otherwise>
                                <div class="container">
                                    <div class="info-cards">
                                        <!-- Số lượng đặt tour -->
                                        <div class="info-card">
                                            <h3>Số lượng đặt tour</h3>
                                            <p>${totalBookings}</p>
                                        </div>

                                        <!-- Doanh thu -->
                                        <div class="info-card">
                                            <h3>Doanh thu</h3>
                                            <p>${totalRevenue} VND</p>
                                        </div>

                                        <!-- Tỷ lệ hủy tour -->
                                        <div class="info-card">
                                            <h3>Tỷ lệ hủy tour</h3>
                                            <p>${cancellationRate}%</p>
                                        </div>
                                    </div>
                                    <!-- Container cho cả hai biểu đồ -->
                                    <div class="charts-container">


                                        <div class="chart-container">
                                            <canvas id="bookingsByCompanyChart"></canvas>
                                        </div>

                                        <div class="chart-container">
                                            <canvas id="bookingsByLocationChart"></canvas>
                                        </div>
                                    </div>

                                    <h3>Số Lượng Đặt Tour Theo Từng Tháng</h3>
                                    <div class="select-container">
                                        <select id="yearSelect" onchange="updateChart()">
                                            <option value="2023">2023</option>
                                            <option value="2024">2024</option>
                                            <!-- Thêm các năm khác nếu cần -->
                                        </select>
                                    </div>

                                    <div class="charts-container ye">

                                        <div class="chart-container">
                                            <canvas id="monthlyBookingsChart"></canvas>
                                        </div>
                                    </div>

                                    <!-- Liệt kê các user vừa đăng ký gần đây nhất -->
                                    <div class="recent-users-container">
                                        <h3>Danh Sách Người Dùng Đăng Ký Gần Đây</h3>
                                        <table class="users-table">
                                            <thead>
                                                <tr>
                                                    <th>Tên</th>
                                                    <th>Vai Trò</th>
                                                    <th>Thời Gian Đăng Ký</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:if test="${not empty recentUsers}">
                                                    <c:forEach var="user" items="${recentUsers}">
                                                        <tr>
                                                            <td>${user.first_Name} ${user.last_Name}</td>
                                                            <td>${user.role}</td>
                                                            <td>${user.created_At}</td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:if>
                                                <c:if test="${empty recentUsers}">
                                                    <tr>
                                                        <td colspan="3">Không có người dùng nào gần đây</td>
                                                    </tr>
                                                </c:if>
                                            </tbody>
                                        </table>
                                    </div>
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
            // JavaScript để vẽ biểu đồ
            var ctxLocation = document.getElementById('bookingsByLocationChart').getContext('2d');
            var locationLabels = [];
            var locationData = [];

            <c:if test="${not empty bookingsByLocation}">
                <c:forEach var="entry" items="${bookingsByLocation}">
            locationLabels.push('${entry.key}');
            locationData.push(${entry.value});
                </c:forEach>
            </c:if>

            var bookingsByLocationChart = new Chart(ctxLocation, {
                type: 'pie',
                data: {
                    labels: locationLabels,
                    datasets: [{
                            label: 'Số lượng đặt tour theo vùng',
                            data: locationData,
                            backgroundColor: [
                                'rgba(255, 99, 132, 0.6)',
                                'rgba(54, 162, 235, 0.6)',
                                'rgba(255, 206, 86, 0.6)',
                                'rgba(75, 192, 192, 0.6)',
                                'rgba(153, 102, 255, 0.6)',
                                'rgba(255, 159, 64, 0.6)'
                            ],
                            borderWidth: 1
                        }]
                },
                options: {
                    responsive: true,
                }
            });

            //
            var ctxCompany = document.getElementById('bookingsByCompanyChart').getContext('2d');
            var CompanyLabels = [];
            var CompanyData = [];

            <c:if test="${not empty bookingsByCompany}">
                <c:forEach var="entry" items="${bookingsByCompany}">
            CompanyLabels.push('${entry.key}');
            CompanyData.push(${entry.value});
                </c:forEach>
            </c:if>

            var bookingsByCompanyChart = new Chart(ctxCompany, {
                type: 'pie',
                data: {
                    labels: CompanyLabels,
                    datasets: [{
                            label: 'Số lượng đặt tour theo từng công ty',
                            data: CompanyData,
                            backgroundColor: [
                                'rgba(255, 99, 132, 0.6)',
                                'rgba(54, 162, 235, 0.6)',
                                'rgba(255, 206, 86, 0.6)',
                                'rgba(75, 192, 192, 0.6)',
                                'rgba(153, 102, 255, 0.6)',
                                'rgba(255, 159, 64, 0.6)'
                            ],
                            borderWidth: 1
                        }]
                },
                options: {
                    responsive: true,
                }
            });
            //

            var ctxMonth = document.getElementById('monthlyBookingsChart').getContext('2d');
            var monthlyLabels = [];
            var monthlyData = [];

            <c:if test="${not empty monthlyBookings}">
                <c:forEach var="entry" items="${monthlyBookings}">
            monthlyLabels.push('${entry.key}');
            monthlyData.push(${entry.value});
                </c:forEach>
            </c:if>

            var monthlyBookingsChart = new Chart(ctxMonth, {
                type: 'bar',
                data: {
                    labels: monthlyLabels,
                    datasets: [{
                            label: 'Số lượng đặt tour',
                            data: monthlyData,
                            backgroundColor: 'rgba(54, 162, 235, 0.6)',
                            borderColor: 'rgba(54, 162, 235, 1)',
                            borderWidth: 1
                        }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Số lượng'
                            }
                        },
                        x: {
                            title: {
                                display: true,
                                text: 'Tháng'
                            }
                        }
                    }
                }
            });

            function updateChart() {
                var selectedYear = document.getElementById('yearSelect').value;

                // Gửi yêu cầu đến server để lấy dữ liệu mới cho năm đã chọn
                fetch('/Project_SWP/dashboard?year=' + selectedYear + '&format=json')
                        .then(response => {
                            if (!response.ok) {
                                throw new Error(`HTTP error! status: ${response.status}`);
                            }
                            return response.json();
                        })
                        .then(data => {
                            monthlyLabels = [];
                            monthlyData = [];

                            // Giả định dữ liệu trả về là một đối tượng với thuộc tính month và bookingCount
                            for (const month in data) {
                                monthlyLabels.push(month);
                                monthlyData.push(data[month]);
                            }

                            // Vẽ lại biểu đồ
                            monthlyBookingsChart.data.labels = monthlyLabels;
                            monthlyBookingsChart.data.datasets[0].data = monthlyData;
                            monthlyBookingsChart.update();
                        })
                        .catch(error => console.error('Error fetching data:', error));
            }

        </script>


        <script src="assests/js/script_profile.js"></script>
    </body>
</html>





