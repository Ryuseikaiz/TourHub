<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="includes/header.jsp" %>
<link rel="stylesheet" href="assests/css/home.css" />
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.text.Normalizer" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%--<jsp:useBean id="currentUser" class="model.User" scope="session" />--%>
<body>
    <!-- Page preloader-->
    <div class="page-loader"> 
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
    </div>
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
                                        <li><a href="tel:#">0854719702</a></li>
                                        <li><a href="tel:#">0828006916</a></li>
                                    </ul>
                                </li>
                                <li class="box-inline list-inline-item"><span class="icon novi-icon icon-md-smaller icon-secondary mdi mdi-map-marker"></span><a href="#">FPT University Da Nang</a></li>
                                <li class="box-inline list-inline-item"><span class="icon novi-icon icon-md-smaller icon-secondary mdi mdi-email"></span><a href="mailto:#">tourhubforlife@gmail.com</a></li>
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
                                    <li><a href="reporterror.jsp">Report Error</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <c:if test="${sessionScope.currentUser == null}">
                            <div class="rd-navbar-aside-right"><a class="button button-sm button-secondary button-nina" href="login">Login</a></div>
                            <div class="rd-navbar-aside-right"><a class="button button-sm button-secondary button-nina" href="register.jsp">Register</a></div>
                        </c:if>
                        <c:if test="${sessionScope.currentUser != null}">
                            <div class="dropdown">
                                <button class="avatar-button" onclick="toggleDropdown()">
                                    <img src="${currentUser.avatar}"  alt="User Avatar" class="avatar" style="width: 100px; height: 100px;">
                                </button>
                                <div id="dropdownContent" class="dropdown-content">
                                    <c:if test="${sessionScope.currentUser.role.equals('Customer')}">
                                        <a href="user">Profile</a>
                                    </c:if>
                                    <c:if test="${sessionScope.currentUser.role.equals('Provider')}">
                                        <a href="user-profile.jsp">Profile</a>
                                        <a href="provider-analys">Dashboard</a>
                                    </c:if>
                                    <c:if test="${sessionScope.currentUser.role.equals('Admin')}">
                                        <a href="dashboard">Dashboard</a>
                                        <a href="manage.jsp">System Management</a>
                                        <a href="admin-chat.jsp">Chat with customer</a>
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
                                            <button class="btn btn-primary" id="search-btn">SEARCH</button>
                                        </div>
                                        <div class="search-container">
                                            <span class="icon">🔍</span>
                                            <span class="search-text">Find <strong id="search-keyword"></strong></span>
                                            <span class="arrow"><a href="#" id="search-link">→</a></span>
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
            <div class="container"> 
                <div class="row row-fix justify-content-xl-end row-30 text-center text-xl-left">
                    <div class="col-xl-8">
                        <div class="parallax-text-wrap">
                            <h3>Our Best Tours</h3>
                            <span class="parallax-text">Hot tours</span>
                        </div>
                        <hr class="divider divider-decorate">
                    </div>
                    <div class="col-xl-3 text-xl-right">
                        <a class="button button-secondary button-nina" href="allTour">view all tours</a>
                    </div>
                </div>
                <div class="group-btn" role="group" aria-label="City Options">
                    <button type="button" class="btn btn-primary active" city="Phu Quoc">Phú Quốc</button>
                    <button type="button" class="btn btn-outline-primary" city="Da Nang">Đà Nẵng</button>
                    <button type="button" class="btn btn-outline-primary" city="Ha Noi">Hà Nội</button>
                    <button type="button" class="btn btn-outline-primary" city="TP Ho Chi Minh<">TP Hồ Chí Minh</button>
                    <button type="button" class="btn btn-outline-primary" city="Quy Nhon">Quy Nhơn</button>
                </div>
                <div class="row row-50" id="tour-list">
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
                            <div class="item">
                                <a href="search?querry= ${province.province_name}" 
                                   data-id="${province.province_id}" class="location-link">
                                    <div class="location-card">
                                        <img class="quote-boxed-image" src="assests/images/provinces/${province.image_url}" 
                                             alt="${province.province_name}" style="width: 100%; height: auto"/>
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

        <section class="section section-variant-1 bg-default novi-background bg-cover" style="margin-top: 100px">
            <div class="container"> <!-- Make it full width -->
                <div class="row justify-content-xl-end text-center text-xl-left">
                    <div class="col-xl-12"> <!-- Full width column -->
                        <div class="parallax-text-wrap">
                            <h3>Coupon</h3><span class="parallax-text">COUPON</span>
                        </div>
                        <hr class="divider divider-decorate">
                    </div>
                    <div class="col-12">
                        <div class="container-coupon flex-wrap justify-content-center">
                            <!-- Loop through each discount and corresponding tour in the discountWithTour list -->
                            <c:forEach var="item" items="${sessionScope.discountWithTour}">
                                <c:set var="discount" value="${item.discount}" />
                                <c:set var="tour" value="${item.tour}" />

                                <div class="coupon-card">   
                                    <img src="assests/images/tour-images/${tour.tour_Img[0]}" class="logo">
                                    <h3>
                                        ${discount.description}<br>
                                        ${discount.percent_Discount}% flat off on ${tour.tour_Name}<br>
                                        Use coupon: ${discount.code}
                                    </h3>
                                    <div class="coupon-row">
                                        <span class="cpnCode">${discount.code}</span>
                                        <span class="cpnBtn" onclick="copyToClipboard('${discount.code}')">Copy Code</span>
                                    </div>
                                    <p>Valid Till: 
                                        <!-- Format the endDay date using JSTL -->
                                        <fmt:formatDate value="${discount.end_Day}" pattern="dd MMM, yyyy" />
                                    </p>
                                    <div class="circle1"></div>
                                    <div class="circle2"></div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </section> 
        <section class="section section-lg text-center bg-gray-lighter novi-background bg-cover">
            <div class="container container-bigger">
                <h3>Lasted Comments</h3>
                <div class="divider divider-decorate"></div>
                <!-- Owl Carousel-->
                <div class="owl-carousel owl-layout-1" data-items="1" data-dots="true" data-nav="true" data-stage-padding="0" data-loop="" data-margin="30" data-mouse-drag="false" data-autoplay="">
                    <c:forEach var="reviewData" items="${reviewWithTourImages}">
                        <!-- Extract the review and the tour image from the map -->
                        <c:set var="review" value="${reviewData.review}" />
                        <c:set var="tour" value="${reviewData.tour}" />
                        <a href="SearchTourByIdServlet?tourId=${tour.tour_Id}">
                            <article class="quote-boxed">
                                <div class="quote-boxed-aside">

                                    <img class="quote-boxed-image" src="assests/images/tour-images/${tour.tour_Img[0]}" alt="${tour.tour_Name}" style="width: 20vw; height: 20vh;" />

                                </div>
                                <div class="quote-boxed-main">
                                    <div class="quote-boxed-text">
                                        <p>
                                            ${review.comment}
                                        </p>
                                    </div>
                                    <div class="quote-boxed-meta">
                                        <p class="quote-boxed-cite">${review.first_Name} ${review.last_Name}</p>
                                    </div>
                                </div>
                            </article>
                        </a>
                    </c:forEach>

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
                            <div class="box-cta-inner"><a class="button button-secondary button-nina" href="allTour">Book Now</a></div>
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
        <script>
            // Extract the query parameter from the URL
            const urlParams = new URLSearchParams(window.location.search);
            const searchQuery = urlParams.get('querry');

            // Set the search box value if the query exists
            if (searchQuery) {
                document.getElementById('input-box').value = decodeURIComponent(searchQuery);
            }

            // Add event listener for the search button
            document.getElementById("search-btn").addEventListener("click", function () {
                var queryValue = document.getElementById("input-box").value;
                if (queryValue) {
                    // Remove diacritics before encoding the value
                    var cleanedQuery = encodeURIComponent(removeDiacritics(queryValue));
                    // Redirect to the servlet with the new query as a URL parameter
                    window.location.href = "search?querry=" + cleanedQuery;
                }
            });

            function removeDiacritics(str) {
                const diacriticsMap = {
                    'à': 'a', 'á': 'a', 'ả': 'a', 'ã': 'a', 'ạ': 'a',
                    'â': 'a', 'ầ': 'a', 'ấ': 'a', 'ẩ': 'a', 'ẫ': 'a', 'ậ': 'a',
                    'ă': 'a', 'ằ': 'a', 'ắ': 'a', 'ẳ': 'a', 'ẵ': 'a', 'ặ': 'a',
                    'è': 'e', 'é': 'e', 'ẻ': 'e', 'ẽ': 'e', 'ẹ': 'e',
                    'ê': 'e', 'ề': 'e', 'ế': 'e', 'ể': 'e', 'ễ': 'e', 'ệ': 'e',
                    'ì': 'i', 'í': 'i', 'ỉ': 'i', 'ĩ': 'i', 'ị': 'i',
                    'ò': 'o', 'ó': 'o', 'ỏ': 'o', 'õ': 'o', 'ọ': 'o',
                    'ô': 'o', 'ồ': 'o', 'ố': 'o', 'ổ': 'o', 'ỗ': 'o', 'ộ': 'o',
                    'ơ': 'o', 'ờ': 'o', 'ớ': 'o', 'ở': 'o', 'ỡ': 'o', 'ợ': 'o',
                    'ù': 'u', 'ú': 'u', 'ủ': 'u', 'ũ': 'u', 'ụ': 'u',
                    'ư': 'u', 'ừ': 'u', 'ứ': 'u', 'ử': 'u', 'ữ': 'u', 'ự': 'u',
                    'ỳ': 'y', 'ý': 'y', 'ỷ': 'y', 'ỹ': 'y', 'ỵ': 'y',
                    'Đ': 'D', 'đ': 'd'
                };

                return str.split('').map(char => diacriticsMap[char] || char).join('');
            }
            function setProvinceLinks() {
                const provinceLinks = document.querySelectorAll('.location-link'); // Select all links with the class 'location-link'
                provinceLinks.forEach(link => {
                    const provinceName = link.querySelector('.location-name').innerText; // Get the province name
                    const cleanedName = encodeURIComponent(removeDiacritics(provinceName)); // Remove diacritics
                    const dataId = link.getAttribute('data-id'); // Get the data-id attribute
                    console.log(cleanedName);
                    // Set the new href attribute with the cleaned province name
                    if (cleanedName) { // Check if cleanedName is not empty
                        link.href = "search?querry=" + cleanedName; // Set the new href
                    } else {
                        console.error('Cleaned name is empty, href not set.');
                    }
                });
            }
            document.getElementById("search-link").addEventListener("click", function () {
                // Get the input value
                const inputBox = document.getElementById("input-box").value.trim();

                // Check if the input box is not empty
                if (inputBox) {
                    // Encode the query
                    const querry = encodeURIComponent(inputBox);

                    // Update the search link's href
                    const searchLink = document.getElementById("search-link");
                    searchLink.href = "search?querry=" + querry;

                    // Redirect to the search page
                    window.location.href = searchLink.href; // Navigate immediately
                }
            });
            // Call the function on page load
            document.addEventListener('DOMContentLoaded', setProvinceLinks);


            var cpnBtns = document.querySelectorAll(".cpnBtn");
            var cpnCodes = document.querySelectorAll(".cpnCode");

            cpnBtns.forEach(function (btn, index) {
                btn.onclick = function () {
                    // Get the corresponding coupon code using the same index
                    var cpnCode = cpnCodes[index].innerHTML;

                    // Copy the coupon code to the clipboard
                    navigator.clipboard.writeText(cpnCode).then(function () {
                        // Update the button text to indicate success
                        btn.innerHTML = "COPIED";

                        // Reset the button text after 2 seconds
                        setTimeout(function () {
                            btn.innerHTML = "COPY CODE";
                        }, 3000);
                    });
                };
            });

        </script>

        <script src="assests/js/home.js"></script>

        <%@include file="includes/footer.jsp" %>