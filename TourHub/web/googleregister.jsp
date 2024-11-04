<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.User" %>
<%@ include file="includes/header.jsp" %>
<html>
    <head>
        <title>Complete Your Registration</title>
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
    <%
        User currentUser = (User) session.getAttribute("currentUser");
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>
    <body>
        <section class="section section-lg bg-default novi-background bg-cover">
            <div class="container container-wide">
                <div class="row justify-content-center">
                    <div class="col-md-10 col-lg-8">
                        <h2 class="text-center">Complete Your Registration</h2>
                        <hr class="divider divider-decorate">
                        <form action="completeRegistration" method="POST" class="registration-form" onsubmit="return validateForm();">
                            <div class="form-group">
                                <label for="phone">Phone Number:</label>
                                <input type="text" id="phone" name="phone" class="form-control" required
                                       value="<%= request.getParameter("phone") != null ? request.getParameter("phone") : "" %>"/>
                            </div>

                            <!-- Address Selection -->
                            <div class="form-group">
                                <label for="province">Province:</label>
                                <select id="province" name="province" class="form-control" required style="height: 50px;">
                                    <option value="">Select Province</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="district">District:</label>
                                <select id="district" name="district" class="form-control" required style="height: 50px;">
                                    <option value="">Select District</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="commune">Commune:</label>
                                <select id="commune" name="commune" class="form-control" required style="height: 50px;">
                                    <option value="">Select Commune</option>
                                </select>
                            </div>
                            <input type="hidden" id="provinceName" name="provinceName">
                            <input type="hidden" id="districtName" name="districtName">
                            <input type="hidden" id="communeName" name="communeName">
                            <div class="form-group">
                                <label for="address">Street Address:</label>
                                <input type="text" id="address" name="address" class="form-control" required
                                       value="<%= request.getParameter("address") != null ? request.getParameter("address") : "" %>"/>
                            </div>

                            <div class="form-group">
                                <label for="password">Create Password:</label>
                                <input type="password" id="password" name="password" class="form-control" required/>
                            </div>
                            <div class="form-group">
                                <label for="role">Select Role:</label>
                                <select name="role" id="role" class="form-control" required style="height: 100px;">
                                    <option value="Provider" <%= "Provider".equals(request.getParameter("role")) ? "selected" : "" %>>Provider</option>
                                    <option value="Customer" <%= "Customer".equals(request.getParameter("role")) ? "selected" : "" %>>Customer</option>
                                </select>
                            </div>

                            <div class="form-group text-center">
                                <input type="submit" class="button button-sm button-secondary" value="Complete Registration"/>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>

        <% if (errorMessage != null) { %>
        <script>
            showError('<%= errorMessage.replace("'", "\\'") %>');
        </script>
        <% } %>
        <%@ include file="includes/footer.jsp" %>
    </body>
</html>
