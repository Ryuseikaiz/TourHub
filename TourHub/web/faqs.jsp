<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.User" %>
<%@ page import="model.FAQ" %>
<%@ page import="DataAccess.UserDB" %>
<%@ page import="DataAccess.FAQDB" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:useBean id="currentUser" class="model.User" scope="session" />
<%@ include file="includes/header.jsp" %>

<%
    FAQDB faqDB = new FAQDB();
    List<FAQ> faqs = faqDB.getAllFAQs(); // Assume this method retrieves all FAQs
    request.setAttribute("faqs", faqs);
%>

<body>
    <!-- Page preloader-->
    <div class="page-loader"> 
        <div class="page-loader-body"> 
            <div class="preloader-wrapper big active"> 
                <div class="spinner-layer spinner-blue"> 
                    <div class="circle-clipper left">
                        <div class="circle"></div>
                    </div>
                    <div class="gap-patch">
                        <div class="circle"></div>
                    </div>
                    <div class="circle-clipper right">
                        <div class="circle"></div>
                    </div>
                </div>
                <div class="spinner-layer spinner-red">
                    <div class="circle-clipper left">
                        <div class="circle"></div>
                    </div>
                    <div class="gap-patch">
                        <div class="circle"></div>
                    </div>
                    <div class="circle-clipper right">
                        <div class="circle"></div>
                    </div>
                </div>
                <div class="spinner-layer spinner-yellow"> 
                    <div class="circle-clipper left">
                        <div class="circle"></div>
                    </div>
                    <div class="gap-patch">
                        <div class="circle"></div>
                    </div>
                    <div class="circle-clipper right">
                        <div class="circle"></div>
                    </div>
                </div>
                <div class="spinner-layer spinner-green"> 
                    <div class="circle-clipper left">
                        <div class="circle"></div>
                    </div>
                    <div class="gap-patch">
                        <div class="circle"></div>
                    </div>
                    <div class="circle-clipper right">
                        <div class="circle"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Page-->
    <div class="page">
        <!-- Page Header-->
        <header class="section page-header">
            <!-- RD Navbar-->
            <div class="rd-navbar-wrap rd-navbar-corporate">
                <nav class="rd-navbar" data-layout="rd-navbar-fixed" data-sm-layout="rd-navbar-fixed" data-md-layout="rd-navbar-fixed" data-lg-layout="rd-navbar-fullwidth" data-xl-layout="rd-navbar-static" data-md-stick-up-offset="130px" data-lg-stick-up-offset="100px" data-stick-up="true">
                    <div class="rd-navbar-collapse-toggle" data-rd-navbar-toggle=".rd-navbar-collapse"><span></span></div>
                    <div class="rd-navbar-top-panel rd-navbar-collapse novi-background">
                        <div class="rd-navbar-top-panel-inner">
                            <ul class="list-inline">
                                <li class="box-inline list-inline-item">
                                    <span class="icon novi-icon icon-md-smaller icon-secondary mdi mdi-phone"></span>
                                    <ul class="list-comma">
                                        <li><a href="tel:18001234567">1-800-1234-567</a></li>
                                        <li><a href="tel:18006780345">1-800-6780-345</a></li>
                                    </ul>
                                </li>
                                <li class="box-inline list-inline-item">
                                    <span class="icon novi-icon icon-md-smaller icon-secondary mdi mdi-map-marker"></span>
                                    <a href="#">2130 Fulton Street, San Diego, CA 94117-1080 USA</a>
                                </li>
                                <li class="box-inline list-inline-item">
                                    <span class="icon novi-icon icon-md-smaller icon-secondary mdi mdi-email"></span>
                                    <a href="mailto:mail@demolink.org">mail@demolink.org</a>
                                </li>
                            </ul>
                            <ul class="list-inline">
                                <li class="list-inline-item"><a class="icon novi-icon icon-sm-bigger icon-gray-1 mdi mdi-facebook" href="#"></a></li>
                                <li class="list-inline-item"><a class="icon novi-icon icon-sm-bigger icon-gray-1 mdi mdi-twitter" href="#"></a></li>
                                <li class="list-inline-item"><a class="icon novi-icon icon-sm-bigger icon-gray-1 mdi mdi-instagram" href="#"></a></li>
                                <li class="list-inline-item"><a class="icon novi-icon icon-sm-bigger icon-gray-1 mdi mdi-google-plus" href="#"></a></li>
                                <li class="list-inline-item"><a class="icon novi-icon icon-sm-bigger icon-gray-1 mdi mdi-linkedin" href="#"></a></li>
                            </ul>
                        </div>
                        <div class="rd-navbar-top-panel-inner">
                            <a class="button button-sm button-secondary button-nina" href="https://www.templatemonster.com/website-templates/62466.html" target="_blank">Buy Template Now</a>
                        </div>
                    </div>
                    <div class="rd-navbar-inner">
                        <!-- RD Navbar Panel-->
                        <div class="rd-navbar-panel">
                            <!-- RD Navbar Toggle-->
                            <button class="rd-navbar-toggle" data-rd-navbar-toggle=".rd-navbar-nav-wrap"><span></span></button>
                            <!-- RD Navbar Brand-->
                            <div class="rd-navbar-brand"><a class="brand-name" href="index.jsp"><img class="logo-default" src="assets/images/logo-default-208x46.png" alt="" width="208" height="46"/><img class="logo-inverse" src="assets/images/logo-inverse-208x46.png" alt="" width="208" height="46"/></a></div>
                        </div>
                        <div class="rd-navbar-aside-center">
                            <div class="rd-navbar-nav-wrap">
                                <!-- RD Navbar Nav-->
                                <ul class="rd-navbar-nav">
                                    <li><a href="index.jsp">Home</a></li>
                                    <li><a href="about-us.jsp">About Us</a></li>
                                    <li><a href="contacts.jsp">Contacts</a></li>
                                    <li><a href="typography.jsp">Typography</a></li>
                                    <li class="active"><a href="faqs.jsp">FAQs</a></li>
                                    <li><a href="reporterror.jsp">Report Error</a></li>
                                </ul>
                            </div>
                        </div>

                        <c:choose>
                            <c:when test="${currentUser == null}">
                                <div class="rd-navbar-aside-right"><a class="button button-sm button-secondary button-nina" href="#">Book a Tour Now</a></div>
                            </c:when>
                            <c:otherwise>
                                <div class="dropdown">
                                    <button class="avatar-button" onclick="toggleDropdown()">
                                        <img src="assets/images/avatar.jpg" alt="User Avatar" class="avatar">
                                    </button>
                                    <div id="dropdownContent" class="dropdown-content">
                                        <a href="user-profile.jsp">Profile</a>
                                        <a href="settings.jsp">Settings</a>
                                        <a href="logout">Logout</a>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </nav>
            </div>
        </header>

        <section class="section section-lg bg-default novi-background bg-cover">
            <div class="container container-wide">
                <div class="row justify-content-center">
                    <div class="col-md-10 col-lg-8">
                        <h2 class="text-center">Frequently Asked Questions</h2>
                        <hr class="divider divider-decorate">

                        <div class="faq-section">
                            <c:forEach var="faq" items="${faqs}">
                                <h5 class="faq-question">${fn:escapeXml(faq.question)}</h5>
                                <p class="faq-answer">${fn:escapeXml(faq.answer)}</p>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <%@ include file="includes/footer.jsp" %>
    </div>
</body>
