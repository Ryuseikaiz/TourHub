<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@include file="includes/header.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>
        <link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.2/dist/css/bootstrap.min.css">
        <style>
            body {
                background-image: url('https://golden-lotus-hotel.s3.ap-southeast-1.amazonaws.com/uploads/2021/04/013d407166ec4fa56eb1e1f8cbe183b9/images1089892_1.jpg');
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
                height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .container {
                background-color: rgba(255, 255, 255, 0.8);
                padding: 2rem;
                border-radius: 10px;
                box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
            }

            .form-control, .form-floating {
                background-color: rgba(255, 255, 255, 0.8) !important;
            }
        </style>
        <script>
            function showError(message) {
                alert(message);
            }

            function isVietnamesePhoneNumberValid(number) {
                return /(((\+|)84)|0)(3|5|7|8|9)+([0-9]{8})\b/.test(number);
            }


            function validateForm() {
                const phone = document.getElementById("phone").value;
                const password = document.getElementById("password").value;
                const confirmPassword = document.getElementById("confirmPassword").value;

                // Kiểm tra số điện thoại hợp lệ
                if (!isVietnamesePhoneNumberValid(phone)) {
                    alert("Please enter a valid phone number.");
                    return false;
                }

                // Kiểm tra mật khẩu hợp lệ
                const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,16}$/;
                if (!passwordPattern.test(password)) {
                    alert("Password must be 8-16 characters long, include at least 1 lowercase, 1 uppercase letter, and 1 special character.");
                    return false;
                }
                // Kiểm tra mật khẩu và xác nhận mật khẩu có giống nhau không
                if (password !== confirmPassword) {
                    alert("Password and confirm password must match.");
                    return false;
                }
                return true;
            }

            async function loadAddresses() {
                try {
                    const response = await fetch('db.json');
                    const data = await response.json();

                    // Tải và hiển thị danh sách tỉnh
                    const provinceSelect = document.getElementById("province");
                    data.province.forEach(province => {
                        const option = document.createElement("option");
                        option.value = province.idProvince;
                        option.textContent = province.name;
                        provinceSelect.appendChild(option);
                    });

                    // Xử lý khi người dùng chọn tỉnh
                    provinceSelect.addEventListener("change", function () {
                        const selectedProvince = this.value;
                        const provinceName = provinceSelect.options[provinceSelect.selectedIndex].text;
                        document.getElementById("provinceName").value = provinceName;
                        populateDistricts(data.district, data.commune, selectedProvince);
                    });
                } catch (error) {
                    console.error("Failed to load address data:", error);
                }
            }

// Hàm hiển thị danh sách huyện dựa trên tỉnh được chọn
            function populateDistricts(districts, communes, provinceId) {
                const districtSelect = document.getElementById("district");
                districtSelect.innerHTML = "<option value=''>Select District</option>";

                // Lọc huyện theo tỉnh và hiển thị
                districts
                        .filter(district => district.idProvince === provinceId)
                        .forEach(district => {
                            const option = document.createElement("option");
                            option.value = district.idDistrict;
                            option.textContent = district.name;
                            districtSelect.appendChild(option);
                        });

                // Xử lý khi chọn huyện
                districtSelect.addEventListener("change", function () {
                    const selectedDistrict = this.value;
                    const districtName = districtSelect.options[districtSelect.selectedIndex].text;
                    document.getElementById("districtName").value = districtName;
                    populateCommunes(communes, selectedDistrict);
                });
            }

// Hàm hiển thị danh sách xã dựa trên huyện được chọn
            function populateCommunes(communes, districtId) {
                const communeSelect = document.getElementById("commune");
                communeSelect.innerHTML = "<option value=''>Select Commune</option>";

                communes
                        .filter(commune => commune.idDistrict === districtId)
                        .forEach(commune => {
                            const option = document.createElement("option");
                            option.value = commune.idCommune;
                            option.textContent = commune.name;
                            communeSelect.appendChild(option);
                        });
                communeSelect.addEventListener("change", function () {
                    const communeName = communeSelect.options[communeSelect.selectedIndex].text;
                    document.getElementById("communeName").value = communeName;
                });
            }

            window.onload = loadAddresses;

        </script>
    </head>
    <body>
        <section class="py-3 py-md-5 py-xl-8">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12 col-lg-10 col-xl-8">
                        <div class="mb-5 text-center">
                            <h2 class="display-5 fw-bold">Sign Up</h2>
                        </div>
                        <form action="register" method="post" onsubmit="return validateForm();">
                            <div class="row gy-3">
                                <!-- First Name -->
                                <div class="col-12 col-md-6">
                                    <div class="form-floating">
                                        <input type="text" class="form-control" id="firstName" name="firstName" placeholder="First Name" value="${param.firstName}" required>
                                        <label for="firstName">First Name</label>
                                    </div>
                                </div>

                                <!-- Last Name -->
                                <div class="col-12 col-md-6">
                                    <div class="form-floating">
                                        <input type="text" class="form-control" id="lastName" name="lastName" placeholder="Last Name" value="${param.lastName}" required>
                                        <label for="lastName">Last Name</label>
                                    </div>
                                </div>

                                <!-- Email -->
                                <div class="col-12">
                                    <div class="form-floating">
                                        <input type="email" class="form-control" id="email" name="email" placeholder="Email" value="${param.email}" required>
                                        <label for="email">Email</label>
                                    </div>
                                </div>

                                <!-- Phone -->
                                <div class="col-12">
                                    <div class="form-floating">
                                        <input type="tel" class="form-control" id="phone" name="phone" placeholder="Phone" value="${param.phone}" required>
                                        <label for="phone">Phone</label>
                                    </div>
                                </div>

                                <!-- Address -->
                                <div class="col-12">
                                    <div class="form-floating">
                                        <select class="form-select" id="province" required>
                                            <option value="">Select Province</option>
                                        </select>
                                        <label for="province">Province</label>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <div class="form-floating">
                                        <select class="form-select" id="district" required>
                                            <option value="">Select District</option>
                                        </select>
                                        <label for="district">District</label>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <div class="form-floating">
                                        <select class="form-select" id="commune" required>
                                            <option value="">Select Commune</option>
                                        </select>
                                        <label for="commune">Commune</label>
                                    </div>
                                </div>

                                <!-- Hidden fields to store selected names -->
                                <input type="hidden" id="provinceName" name="provinceName">
                                <input type="hidden" id="districtName" name="districtName">
                                <input type="hidden" id="communeName" name="communeName">

                                <div class="col-12">
                                    <div class="form-floating">
                                        <input type="text" class="form-control" id="streetAddress" name="streetAddress" placeholder="Street Address" value="${param.streetAddress}" required>
                                        <label for="streetAddress">Street Address</label>
                                    </div>
                                </div>

                                <!-- Password -->
                                <div class="col-12 col-md-6">
                                    <div class="form-floating">
                                        <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                                        <label for="password">Password</label>
                                    </div>
                                </div>

                                <!-- Confirm Password -->
                                <div class="col-12 col-md-6">
                                    <div class="form-floating">
                                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required>
                                        <label for="confirmPassword">Confirm Password</label>
                                    </div>
                                </div>

                                <!-- Role Selection -->
                                <div class="col-12">
                                    <div class="form-floating">
                                        <select class="form-select" name="role" id="role" required>
                                            <option value="Customer" ${param.role == 'Customer' ? 'selected' : ''}>Customer</option>
                                            <option value="Provider" ${param.role == 'Provider' ? 'selected' : ''}>Provider</option>
                                        </select>
                                        <label for="role">Select Role</label>
                                    </div>
                                </div>

                                <!-- Error Handling (if applicable) -->
                                <div class="col-12">
                                    <c:if test="${not empty error}">
                                        <div class="alert alert-danger" role="alert">
                                            ${fn:escapeXml(error)}
                                        </div>
                                    </c:if>
                                </div>

                                <!-- Submit Button -->
                                <div class="col-12">
                                    <div class="d-grid">
                                        <button class="btn btn-primary btn-lg" type="submit">Register</button>
                                    </div>
                                </div>

                                <!-- Already Registered -->
                                <div class="col-12 text-center">
                                    <p>Already have an account? <a href="login.jsp">Login here</a>.</p>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>
    </body>
</html>
