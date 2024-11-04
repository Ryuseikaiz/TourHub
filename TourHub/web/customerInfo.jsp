<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.User" %>
<%@ include file="includes/header.jsp" %>

<html>
<head>
    <title>Customer Information</title>
    <script>
        function validateDOB() {
            const birthDate = new Date(document.getElementById("birthDate").value);
            const today = new Date();
            const age = today.getFullYear() - birthDate.getFullYear();
            const monthDifference = today.getMonth() - birthDate.getMonth();
            if (monthDifference < 0 || (monthDifference === 0 && today.getDate() < birthDate.getDate())) {
                age--;
            }
            
            if (age < 18) {
                alert("You must be at least 18 years old to create account.");
                return false; // Prevent form submission
            }
            return true; // Allow form submission
        }
    </script>
</head>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null || !"Customer".equals(currentUser.getRole())) {
        // If session doesn't have the customer or role is not Customer, redirect to login
        response.sendRedirect("login.jsp");
        return;
    }
%>
<body>
    <section class="section section-lg bg-default novi-background bg-cover">
        <div class="container container-wide">
            <div class="row justify-content-center">
                <div class="col-md-10 col-lg-8">
                    <h2 class="text-center">Enter Customer Information</h2>
                    <hr class="divider divider-decorate">

                    <form action="updateCustomerInfo" method="POST" class="customer-info-form" onsubmit="return validateDOB()">
                        <div class="form-group">
                            <label for="birthDate">Date of Birth:</label>
                            <input type="date" id="birthDate" name="birthDate" class="form-control" required style="height: 50px;"/>
                        </div>
                    <div class="form-group text-center">
                        <input type="submit" class="button button-sm button-secondary" value="Submit"/>
                    </div>
                    </form>
                    
                </div>
            </div>
        </div>
    </section>
</body>
</html>
