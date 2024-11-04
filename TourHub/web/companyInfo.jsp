<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.User" %>
<%@ include file="includes/header.jsp" %>

<html>
<head>
    <title>Company Information</title>
</head>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null || !"Provider".equals(currentUser.getRole())) {
        // If session doesn't have the provider or role is not Provider, redirect to login
        response.sendRedirect("login.jsp");
        return;
    }
%>
<body>
    <section class="section section-lg bg-default novi-background bg-cover">
        <div class="container container-wide">
            <div class="row justify-content-center">
                <div class="col-md-10 col-lg-8">
                    <h2 class="text-center">Enter Company Information</h2>
                    <hr class="divider divider-decorate">

                    <form action="updateCompanyInfo" method="POST" class="company-info-form">
                        <div class="form-group">
                            <label for="taxCode">Tax Code:</label>
                            <input type="text" id="taxCode" name="taxCode" class="form-control" required/>
                        </div>
                        <div class="form-group">
                            <label for="bankInformation">Bank Information:</label>
                            <input type="text" id="bankInformation" name="bankInformation" class="form-control" required/>
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
