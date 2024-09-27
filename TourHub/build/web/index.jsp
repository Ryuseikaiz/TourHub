<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="includes/header.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--<jsp:useBean id="currentUser" class="model.User" scope="session" />--%>
<body>
    <!-- Page preloader-->
    <!--        <div class="page-loader"> 
                <div class="page-loader-body "> 
                    <div class="preloader-wrapper big active"> 
                        <div class="spinner-layer spinner-blue"> 
                            <div class="circle-clipper left">
                                <div class="circle"> </div>
                            </div>
                            <div class="gap-patch">
                                <div class="circle"> </div>
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
                                <div class="circle"> </div>
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
                                <div class="circle"> </div>
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
            </div>-->
    <!-- Page-->
    <div class="page">
        <!-- Page Header-->
        <header class="section page-header">
            <!-- RD Navbar-->
            <div class="rd-navbar-wrap rd-navbar-corporate">
                <nav class="rd-navbar" data-layout="rd-navbar-fixed" data-sm-layout="rd-navbar-fixed" data-md-layout="rd-navbar-fixed" data-md-device-layout="rd-navbar-fixed" data-lg-layout="rd-navbar-fullwidth" data-xl-layout="rd-navbar-static" data-lg-device-layout="rd-navbar-fixed" data-xl-device-layout="rd-navbar-static" data-md-stick-up-offset="130px" data-lg-stick-up-offset="100px" data-stick-up="true" data-sm-stick-up="true" data-md-stick-up="true" data-lg-stick-up="true" data-xl-stick-up="true">
                    <div class="rd-navbar-collapse-toggle" data-rd-navbar-toggle=".rd-navbar-collapse"><span></span></div>
                    <div class="rd-navbar-top-panel rd-navbar-collapse novi-background">
                        <div class="rd-navbar-top-panel-inner">
                            <ul class="list-inline">
                                <li class="box-inline list-inline-item"><span class="icon novi-icon icon-md-smaller icon-secondary mdi mdi-phone"></span>
                                    <ul class="list-comma">
                                        <li><a href="tel:#">1-800-1234-567</a></li>
                                        <li><a href="tel:#">1-800-6780-345</a></li>
                                    </ul>
                                </li>
                                <li class="box-inline list-inline-item"><span class="icon novi-icon icon-md-smaller icon-secondary mdi mdi-map-marker"></span><a href="#">2130 Fulton Street, San Diego, CA 94117-1080 USA</a></li>
                                <li class="box-inline list-inline-item"><span class="icon novi-icon icon-md-smaller icon-secondary mdi mdi-email"></span><a href="mailto:#">mail@demolink.org</a></li>
                            </ul>
                            <ul class="list-inline">
                                <li class="list-inline-item"><a class="icon novi-icon icon-sm-bigger icon-gray-1 mdi mdi-facebook" href="#"></a></li>
                                <li class="list-inline-item"><a class="icon novi-icon icon-sm-bigger icon-gray-1 mdi mdi-twitter" href="#"></a></li>
                                <li class="list-inline-item"><a class="icon novi-icon icon-sm-bigger icon-gray-1 mdi mdi-instagram" href="#"></a></li>
                                <li class="list-inline-item"><a class="icon novi-icon icon-sm-bigger icon-gray-1 mdi mdi-google-plus" href="#"></a></li>
                                <li class="list-inline-item"><a class="icon novi-icon icon-sm-bigger icon-gray-1 mdi mdi-linkedin" href="#"></a></li>
                            </ul>
                        </div>
                        <div class="rd-navbar-top-panel-inner"></div>
                    </div>
                    <div class="rd-navbar-inner">
                        <!-- RD Navbar Panel-->
                        <div class="rd-navbar-panel">
                            <!-- RD Navbar Toggle-->
                            <button class="rd-navbar-toggle" data-rd-navbar-toggle=".rd-navbar-nav-wrap"><span></span></button>
                            <!-- RD Navbar Brand-->
                            <div class="rd-navbar-brand"><a class="brand-name" href="home"><img class="logo-default" src="assests/images/logo-favicon/logo.png" alt="" width="208" height="46"/>
                                    <img class="logo-inverse" src="assests/images/logo-favicon/logo.png" alt="" width="208" height="46"/></a></div>

                        </div>
                        <div class="rd-navbar-aside-center">
                            <div class="rd-navbar-nav-wrap">
                                <!-- RD Navbar Nav-->
                                <ul class="rd-navbar-nav">
                                    <li class="active"><a href="home">Home</a>
                                    </li>
                                    <li><a href="about-us.jsp">About Us</a>
                                    </li>
                                    <li><a href="contacts.jsp">Contacts</a>
                                    </li>
                                    <li><a href="typography.jsp">Typography</a>
                                    </li>
                                    <li><a href="faqs.jsp">FAQs</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <c:if test="${sessionScope.currentUser == null}">
                            <div class="rd-navbar-aside-right"><a class="button button-sm button-secondary button-nina" href="login">Login</a></div>
                            <div class="rd-navbar-aside-right"><a class="button button-sm button-secondary button-nina" href="register">Register</a></div>
                        </c:if>
                        <c:if test="${sessionScope.currentUser != null}">
                            <div class="dropdown">
                                <button class="avatar-button" onclick="toggleDropdown()">
                                    <img src="assests/images/avatar.jpg" alt="User Avatar" class="avatar">
                                </button>
                                <div id="dropdownContent" class="dropdown-content">
                                    <a href="user-profile.jsp">Profile</a>
                                    <a href="settings.jsp">Settings</a>
                                    <c:if test="${sessionScope.currentUser.role.equals('Provider')}">
                                        <a href="provider-analys">Studio</a>
                                    </c:if>
                                    <c:if test="${sessionScope.currentUser.role.equals('Admin')}">
                                        <a href="admin-analysis.jsp">Studio</a>
                                    </c:if>
                                    <a href="logout">Logout</a>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </nav>
            </div>
        </header>
        <section class="section">
            <div class="swiper-form-wrap">
                <!-- Swiper-->
                <div class="swiper-container swiper-slider swiper-slider_height-1 swiper-align-left swiper-align-left-custom context-dark bg-gray-darker" data-loop="false" data-autoplay="5500" data-simulate-touch="false" data-slide-effect="fade">
                    <div class="swiper-wrapper">
                        <div class="swiper-slide" data-slide-bg="assests/images/banner/bg1.webp">
                            <div class="swiper-slide-caption">
                                <div class="container container-bigger swiper-main-section">
                                    <div class="row row-fix justify-content-sm-center justify-content-md-start">
                                        <div class="col-md-6 col-lg-5 col-xl-4 col-xxl-5">
                                            <h3>Hundreds of Amazing Destinations</h3>
                                            <div class="divider divider-decorate"></div>
                                            <p class="text-spacing-sm">We offer a variety of destinations to travel to, ranging from exotic to some extreme ones. They include very popular countries and cities like Paris, Rio de Janeiro, Cairo and a lot of others.</p><a class="button button-default-outline button-nina button-sm" href="#">learn more</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="swiper-slide" data-slide-bg="assests/images/banner/bg2.jpg">
                            <div class="swiper-slide-caption">
                                <div class="container container-bigger swiper-main-section">
                                    <div class="row row-fix justify-content-sm-center justify-content-md-start">
                                        <div class="col-md-6 col-lg-5 col-xl-4 col-xxl-5">
                                            <h3>The Trip of Your Dream</h3>
                                            <div class="divider divider-decorate"></div>
                                            <p class="text-spacing-sm">Our travel agency is ready to offer you an exciting vacation that is designed to fit your own needs and wishes. Whether it’s an exotic cruise or a trip to your favorite resort, you will surely have the best experience.</p><a class="button button-default-outline button-nina button-sm" href="#">learn more</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="swiper-slide" data-slide-bg="assests/images/banner/bg3.jpg">
                            <div class="swiper-slide-caption">
                                <div class="container container-bigger swiper-main-section">
                                    <div class="row row-fix justify-content-sm-center justify-content-md-start">
                                        <div class="col-md-6 col-lg-5 col-xl-4 col-xxl-5">
                                            <h3>unique Travel Insights</h3>
                                            <div class="divider divider-decorate"></div>
                                            <p class="text-spacing-sm">Our team is ready to provide you with unique weekly travel insights that include photos, videos, and articles about untravelled tourist paths. We know everything about the places you’ve never been to!</p><a class="button button-default-outline button-nina button-sm" href="#">learn more</a>
                                        </div>
                                    </div>
                                </div>
                            </div>                          
                        </div>
                    </div>

                    <!-- Swiper controls-->
                    <div class="container container-bigger form-request-wrap form-request-wrap-modern">
                        <div class="row row-fix justify-content-sm-center justify-content-lg-end">
                            <div class="col-lg-6 col-xxl-5">
                                <div class="form-request form-request-modern bg-gray-lighter novi-background transparent-bg">     
                                    <div class="search-box custom-radius">
                                        <div class="row">

                                            <input type="text" id="input-box" placeholder="Search your tour" autocomplete="off">
                                            <button class="btn btn-primary">SEARCH</button>
                                        </div>
                                        <div class="search-container">
                                            <span class="icon">🔍</span>
                                            <span class="search-text">Tìm <strong id="search-keyword"></strong></span>
                                            <span class="arrow"><a href="login.jsp">→</a></span>
                                        </div>

                                        <div class="result-box">                                               
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

        </section>

        <section class="section section-variant-1 bg-default novi-background bg-cover"> 
            <!--container-wide-->
            <div class="container "> 
                <div class="row row-fix justify-content-xl-end row-30 text-center text-xl-left">
                    <div class="col-xl-8">
                        <div class="parallax-text-wrap">
                            <h3>Our Best Tours</h3><span class="parallax-text">Hot tours</span>
                        </div>
                        <hr class="divider divider-decorate">
                    </div>
                    <div class="col-xl-3 text-xl-right"><a class="button button-secondary button-nina" href="#">view all tours</a></div>
                </div>
                <div class="group-btn" role="group" aria-label="City Options">
                    <button type="button" class="btn btn-primary active" city="Phú Quốc">Phú Quốc</button>
                    <button type="button" class="btn btn-outline-primary" city="Da Nang">Da Nang</button>
                    <button type="button" class="btn btn-outline-primary" city="Hà Nội">Ha Noi</button>
                    <button type="button" class="btn btn-outline-primary" city="TP Ho Chi Minh">TP Ho Chi Minh</button>
                    <button type="button" class="btn btn-outline-primary" city="Quy Nhon">Quy Nhon</button>
                </div>
                <div class="row row-50">
                    <c:if test="${empty tours}">
                        <p>No tours available.</p>
                    </c:if>                   
                </div>
            </div>
        </section>


        <section class="section section-variant-1 bg-default novi-background bg-cover container"> 
            <div class="container"> <!-- Make it full width -->
                <div class="row justify-content-xl-end text-center text-xl-left">
                    <div class="col-xl-12"> <!-- Full width column -->
                        <div class="parallax-text-wrap">
                            <h3>Best Destinations In Viet Nam</h3><span class="parallax-text">Destination</span>
                        </div>
                        <hr class="divider divider-decorate">
                    </div>

                    <!-- Full width Owl Carousel Container -->
                    <div class="owl-carousel owl-theme location-slider">
                        <c:forEach items="${sessionScope.provinces}" var="province">
                            <!--Location Card--> 
                            <div class="item" >
                                <a href="login.jsp" data-id="${province.province_id}" class="location-link">
                                    <div class="location-card">

                                        <img class="quote-boxed-image" src="assests/images/provinces/${province.image_url}" alt="${province.province_name}" style="width: 100%; height: auto"/>
                                        <div class="location-name">${province.province_name}</div>

                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                    </div>   

                    <div class="owl-carousel owl-theme location-slider">
                    </div>

                </div>
            </div>                              
        </section>

        <section class="section section-lg text-center bg-gray-lighter novi-background bg-cover">
            <div class="container container-bigger">
                <h3>testimonials</h3>
                <div class="divider divider-decorate"></div>
                <!-- Owl Carousel-->
                <div class="owl-carousel owl-layout-1" data-items="1" data-dots="true" data-nav="true" data-stage-padding="0" data-loop="true" data-margin="30" data-mouse-drag="false" data-autoplay="true">
                    <article class="quote-boxed">
                        <div class="quote-boxed-aside"><img class="quote-boxed-image" src="assests/images/quote-user-1-210x210.jpg" alt="" width="210" height="210"/>
                        </div>
                        <div class="quote-boxed-main">
                            <div class="quote-boxed-text">
                                <p>I wanted to thank you very much for planning the trip to France for my boyfriend and me. It was amazing and exceeded my expectations! We had a wonderful time and were very pleased with the accommodations in Paris and Bayeux. Our private/small tour guides were fantastic! I appreciate all the effort to get us to the Eiffel Tower finally. </p>
                            </div>
                            <div class="quote-boxed-meta">
                                <p class="quote-boxed-cite">Ann McMillan</p>
                                <p class="quote-boxed-small">Regular Customer</p>
                            </div>
                        </div>
                    </article>
                    <article class="quote-boxed">
                        <div class="quote-boxed-aside"><img class="quote-boxed-image" src="assests/images/quote-user-2-210x210.jpg" alt="" width="210" height="210"/>
                        </div>
                        <div class="quote-boxed-main">
                            <div class="quote-boxed-text">
                                <p>I had a marvelous time in our travels to Madagascar, Zimbabwe and Botswana, I had just wonderful experiences.I loved the location of the Gorges Camp as I felt like it was only the time we got to see real and rural Africans and how they truly lived. The service was amazing and everyone was very attentive!</p>
                            </div>
                            <div class="quote-boxed-meta">
                                <p class="quote-boxed-cite">Debra Ortega</p>
                                <p class="quote-boxed-small">Regular Customer</p>
                            </div>
                        </div>
                    </article>
                    <article class="quote-boxed">
                        <div class="quote-boxed-aside"><img class="quote-boxed-image" src="assests/images/quote-user-3-210x210.jpg" alt="" width="210" height="210"/>
                        </div>
                        <div class="quote-boxed-main">
                            <div class="quote-boxed-text">
                                <p>Just wanted to say many, many thanks for helping me set up an amazing Costa Rican adventure! My nephew and I had a blast! All of the accommodations were perfect as were the activities that we did (canopy, coffee tour, hikes, fishing, and massages!) We have such fond memories and can't thank you enough!</p>
                            </div>
                            <div class="quote-boxed-meta">
                                <p class="quote-boxed-cite">Samantha Smith</p>
                                <p class="quote-boxed-small">Regular Customer</p>
                            </div>
                        </div>
                    </article>
                </div>
            </div>
        </section>

        <section class="section section-md text-center text-md-left bg-gray-700 novi-background bg-cover">
            <div class="container container-wide">
                <div class="row row-fix row-50 justify-content-sm-center">
                    <div class="col-xxl-8">
                        <div class="box-cta box-cta-inline">
                            <div class="box-cta-inner">
                                <h3 class="box-cta-title">Buy a tour without leaving your home</h3>
                                <p>Using our website, you can book any tour just in a couple of clicks.</p>
                            </div>
                            <div class="box-cta-inner"><a class="button button-secondary button-nina" href="#">Book Now</a></div>
                        </div>
                    </div>
                </div>
            </div>
        </section>    

        <% 
                   // Retrieve the JSON string from the request attribute
                   String toursJson = (String) request.getAttribute("toursJson");
                   // Escape special characters for safe embedding
                   String encodedToursJson = toursJson
                       .replace("\\", "\\\\")  // Escape backslashes
                       .replace("\"", "\\\"")  // Escape double quotes
                       .replace("\n", "\\n")   // Escape new lines
                       .replace("\r", "\\r");  // Escape carriage returns
        %>
        <script>
            const toursJson = "<%= encodedToursJson %>";
            const tours = JSON.parse(toursJson); // Parse the JSON string            
        </script>
        <script src="assests/js/home.js"></script>

        <%@include file="includes/footer.jsp" %>