<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html class="wide wow-animation" lang="en">
     <head>
        <!-- Site Title-->
        <title>Home</title>
        <meta name="format-detection" content="telephone=no" />
        <meta
            name="viewport"
            content="width=device-width, height=device-height, initial-scale=1.0"
            />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta charset="utf-8" />
        <meta property="og:title" content="${tour.tour_Name}" />
        <meta property="og:description" content="Khám phá tour ${tour.tour_Name} tại ${tour.location}. Tour kéo dài ${tour.total_Time} giờ với các điểm đến nổi bật và cảnh đẹp." />

        <c:if test="${not empty tour.tour_Img}">
            <meta property="og:image" content="${tour.tour_Img.get(0)}" />
        </c:if>

        <meta property="og:url" content="https://tourhub.azurewebsites.net/displayTourDetail?id=${tour.tour_Id}" />
        <meta property="og:type" content="website" />
        <link
            rel="icon"
            href="assests/images/logo-favicon/logo.png"
            type="image/x-icon"
            />
        <!-- Stylesheets -->
        <link
            rel="stylesheet"
            type="text/css"
            href="//fonts.googleapis.com/css?family=Oswald:200,400%7CLato:300,400,300italic,700%7CMontserrat:900"
            />
        <link rel="stylesheet" href="assests/css/bootstrap.css" />
        <link rel="stylesheet" href="assests/css/style.css" />
        <link rel="stylesheet" href="assests/css/fonts.css" />
        <link rel="stylesheet" href="assests/css/index.css" />
        <link rel="stylesheet" href="assests/css/search-page.css" />

        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>

        <!-- Owl Carousel CSS -->
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css"
            />
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css"
            />

        <!-- jQuery (required for Owl Carousel) -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

        <!-- Owl Carousel JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>

        <link rel="stylesheet" href="assests/css/tour-detail.css" />
        <link rel="stylesheet" href="assests/css/wave.css" />

        <!-- Font Awesome -->
        <script
            src="https://kit.fontawesome.com/d14313468c.js"
            crossorigin="anonymous"
        ></script>

        <!-- Bootstrap CSS -->
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
            crossorigin="anonymous"
            />
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"
            />

        <!-- Flatpickr CSS -->
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css"
            />

        <!--<link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.2/dist/css/bootstrap.min.css">-->
        <!--[if lt IE 10]>
          <div
            style="
              background: #212121;
              padding: 10px 0;
              box-shadow: 3px 3px 5px 0 rgba(0, 0, 0, 0.3);
              clear: both;
              text-align: center;
              position: relative;
              z-index: 1;
            "
          >
            <a href="http://windows.microsoft.com/en-US/internet-explorer/"
              ><img
                src="assests/images/ie8-panel/warning_bar_0000_us.jpg"
                border="0"
                height="42"
                width="820"
                alt="You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today."
            /></a>
          </div>
          <script src="js/html5shiv.min.js"></script>
        <![endif]-->
        <style>
            .search-bar {
                position: relative;
                width: 100%;
            }

            .search-box {
                width: 100%;
                padding: 10px;
                font-size: 16px;
                border-radius: 20px;
                border: 1px solid #ccc;
            }

            .result-box {
                border: 1px solid #ccc;
                max-height: 50vh;
                overflow-y: auto;
                display: block; /* Show the results by default */
                position: absolute;
                top: 100%;
                left: 0;
                width: 100%;
                background-color: white;
                z-index: 1000;
                border-radius: 15px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                padding: 15px;
                transition: all 0.3s ease;
                display: none;
            }

            .result-item {
                display: flex;
                align-items: center;
                padding: 15px 10px;
                cursor: pointer;
                border-bottom: 1px solid #f0f0f0;
            }

            .result-item:last-child {
                border-bottom: none;
            }

            .result-item img {
                width: 60px;
                height: 60px;
                object-fit: cover;
                border-radius: 50%;
                margin-right: 15px;
            }

            .result-item div {
                display: flex;
                flex-direction: column;
            }

            .location-title,
            .activity-title {
                font-size: 18px;
                font-weight: 600;
                color: #333;
            }

            .location-description,
            .activity-location {
                font-size: 14px;
                color: #999;
            }

            .result-box h3 {
                font-size: 16px;
                color: #ff4500;
                font-weight: 600;
                margin-bottom: 10px;
                margin-top: 20px;
            }

            /* Optional: Styles for scrollbar as you had */
            .result-box::-webkit-scrollbar {
                width: 10px;
            }
            .result-box::-webkit-scrollbar-track {
                background: #f1f1f1;
                border-radius: 5px;
            }
            .result-box::-webkit-scrollbar-thumb {
                background: #888;
                border-radius: 5px;
            }
            .result-box::-webkit-scrollbar-thumb:hover {
                background: #555;
            }
            .result-box {
                scrollbar-width: thin;
                scrollbar-color: #888 #f1f1f1;
            }
            /* Popup Background and Content */
            .popup {
                display: none;
                position: fixed;
                z-index: 9999;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.7);
                opacity: 0;
                transition: opacity 0.4s ease;
            }

            .popup.show {
                display: block;
                opacity: 1;
            }

            .popup-content {
                position: relative;
                background-color: #fff;
                margin: 10% auto;
                padding: 20px;
                width: 80%;
                max-width: 800px;
                border-radius: 10px;
                max-height: 80vh;
                overflow-y: auto;
                opacity: 0;
                transform: translateY(-50px);
                transition: opacity 0.4s ease, transform 0.4s ease;
            }

            .popup-content.show {
                opacity: 1;
                transform: translateY(0);
            }

            /* Close Button */
            .close-btn {
                position: absolute;
                top: 10px;
                right: 20px;
                font-size: 24px;
                cursor: pointer;
                color: #333;
            }

            /* Review Item Styling */
            .review-item {
                display: flex;
                flex-direction: column;
                padding: 15px;
                margin-bottom: 10px;
                background-color: #fff;
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
                width: 100%;
                max-width: 800px;
                transition: box-shadow 0.3s ease;
            }

            .review-item:hover {
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            /* Review Header: Align User and Stars to the Left */
            .review-header {
                display: flex;
                justify-content: flex-start; /* Align to the left */
                align-items: center;
                margin-bottom: 10px;
            }

            .review-user {
                font-weight: bold;
                font-size: 14px;
                color: #333;
                margin-right: 10px; /* Space between name and stars */
            }

            .review-stars {
                color: #f39c12; /* Gold color for stars */
                font-size: 16px;
                margin-top: 5px;
                text-align: left;
            }

            /* Review Text */
            .review-text {
                font-size: 14px;
                line-height: 1.6;
                color: #555;
                margin-top: 10px;
                text-align: left;
            }

            /* Link for Viewing All Reviews */
            .view-review a {
                font-size: 14px;
                color: #007bff;
                cursor: pointer;
                text-decoration: underline;
            }

            .view-review a:hover {
                color: #0056b3;
            }
            /* Container for Highlighted Reviews */
            .highlight-review {
                max-width: 800px;
            }

            /* Individual Review Item */
            .review-item {
                border: none;
                border-radius: 8px;
            }

            .card-title {
                font-size: 1.1em;
                font-weight: bold;
            }

            .card-text {
                font-size: 0.95em;
            }

            .text-primary {
                color: #007bff !important;
            }

            .text-secondary {
                color: #6c757d !important;
            }

            .text-warning {
                color: #ffc107 !important;
            }

            /* Review List Styling */
            .review-list {
                width: 100%; /* Full width for list items */
            }


            /* No Review Message */
            .no-review {
                font-style: italic;
                color: #777;
                padding: 10px;
                text-align: left; /* Left-align message */
            }

            /* Additional Styling for Strong Labels */
            .review-item p strong {
                font-weight: bold;
                color: #333;
                margin-right: 5px;
            }


            /* Hiệu ứng khi hiển thị popup */
            .popup {
                display: none;
                position: fixed;
                z-index: 9999;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.7);
                opacity: 0;
                transition: opacity 0.4s ease;
            }

            .popup.show {
                display: block;
                opacity: 1;
            }

            .popup-content {
                position: relative;
                background-color: #fff;
                margin: 15% auto;
                padding: 20px;
                width: 80%;
                max-width: 800px;
                border-radius: 10px;
                max-height: 80vh;
                overflow-y: auto;
                transform: translateY(-50px);
                opacity: 0;
                transition: all 0.4s ease;
            }

            .popup-content.show {
                opacity: 1;
                transform: translateY(0);
            }

            .close-btn {
                position: absolute;
                top: 10px;
                right: 20px;
                font-size: 24px;
                cursor: pointer;
                color: #333;
            }

        </style>

        <script>
            function toggle(popupId) {
                var popup = document.getElementById(popupId);
                popup.style.display = popup.style.display === "block" ? "none" : "block";
            }
        </script>
    </head>
</html>


<body class="search-page">
    <!-- Page-->
    <div class="page-loader"> 
        <div class="page-loader-body"> 
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
    <div class="page" id="blur">
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
                            <div class="rd-navbar-brand"><a class="brand-name" href="home"><img class="logo-default" src="assests/images/logo-favicon/logo.png" alt="" width="208" height="46"/><img class="logo-inverse" src="assests/images/logo-inverse-208x46.png" alt="" width="208" height="46"/></a></div>
                        </div>
                        <div class="rd-navbar-aside-center">
                            <div class="rd-navbar-nav-wrap">
                                <!-- RD Navbar Nav-->
                                <ul class="rd-navbar-nav">
                                    <li><a href="home">Home</a>
                                    </li>
                                    <li><a href="about-us.jsp">About Us</a>
                                    </li>
                                    <li><a href="contacts.jsp">Contacts</a>
                                    </li>
                                    <li><a href="typography.jsp">Typography</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="rd-navbar-aside-right"><a class="button button-sm button-secondary button-nina" href="#">Book a tour now</a></div>
                    </div>
                </nav>
            </div>
        </header>

        <div>
            <div class="search-bar">
                <input
                    class="search-box"
                    type="text"
                    id="input-box"
                    placeholder="Any ideas on what to do for your next trip?"
                    autocomplete="off"
                    style="margin: 0;"
                    />
                <button>Search</button>
                <div class="result-box" id="result-box">                                       
                </div>
            </div> 
        </div>
        <div class="header">
            <!--Content before waves-->
            <div class="inner-header">
                <div class="inner-header">
                    <div class="tour-header">
                        <div class="page-location">
                            <a href="#">Xperience</a> /
                            <a href="#">Vietnam</a> /
                            <a href="#">Ho Chi Minh City</a> /
                            <a href="#">Cu Chi District</a> /
                            <a href="#">Nhuan Duc Town</a>
                        </div>

                        <div class="tour-info-container-wrapper">
                            <div class="tour-info-container">
                                <div class="tour-name">
                                    <span class="tour-title">${tour.tour_Name}</span>
                                </div>

                                <div class="tour-location">
                                    <i class="fa-solid fa-location-dot"></i>
                                    <span class="location">${tour.location}</span>
                                    <a href="#">Show Map</a>
                                </div>

                                <div class="tour-time">
                                    <div class="nearest-tour-date-container">
                                        <i class="fa-solid fa-calendar-days"></i>
                                        <span class="nearest-tour-date-text">Nearest Tour Date | </span>
                                        <span class="nearest-tour-date">Sat, 28 Sep 2024</span>
                                    </div>

                                    <div class="tour-duration-container">
                                        <i class="fa-regular fa-clock"></i>
                                        <span class="tour-duration-text">Tour Duration | </span>
                                        <span class="tour-duration">${tour.total_Time} Hours</span>
                                    </div>
                                </div>                                                      
                            </div>
                            <button class="save-btn" data-tour-id="${tour.tour_Id}">
                                <i class="fa-regular fa-bookmark"></i>
                            </button>

                            <button class="share-btn" onclick="sharePage()">
                                <i class="fa-regular fa-share-from-square"></i>
                            </button>
                        </div>
                    </div>
                </div>

            </div>

        </div>

        <div class="content flex">
            <div class="tour-gallery">
                <c:if test="${not empty tour.tour_Img[0]}">
                    <div class="image-highlight">
                        <img class="tour-img" src="${tour.tour_Img.get(0)}" alt="Tour Image 1">
                        <a href="javascript:void(0)" onclick="toggle('popup1')">
                            <div class="img-viewmore">
                                <h3>
                                    <i class="fa-solid fa-image"></i>
                                    View All Image
                                </h3>
                            </div>
                        </a>
                    </div>
                </c:if>

                <c:if test="${not empty tour.tour_Img[1]}">
                    <div class="image-1">
                        <img class="tour-img" src="${tour.tour_Img.get(1)}" alt="Tour Image 2">
                        <a href="javascript:void(0)" onclick="toggle('popup1')">
                            <div class="img-viewmore">
                                <h3>
                                    <i class="fa-solid fa-image"></i>
                                    View All Image
                                </h3>
                            </div>
                        </a>
                    </div>
                </c:if>

                <c:if test="${not empty tour.tour_Img[2]}">
                    <div class="image-2">
                        <img class="tour-img" src="${tour.tour_Img.get(2)}" alt="Tour Image 3">
                        <a href="javascript:void(0)" onclick="toggle('popup1')">
                            <div class="img-viewmore">
                                <h3>
                                    <i class="fa-solid fa-image"></i>
                                    View All Image
                                </h3>
                            </div>
                        </a>
                    </div>
                </c:if>

                <c:if test="${not empty tour.tour_Img[3]}">
                    <div class="image-3">
                        <img class="tour-img" src="${tour.tour_Img.get(3)}" alt="Tour Image 4">
                        <a href="javascript:void(0)" onclick="toggle('popup1')">
                            <div class="img-viewmore">
                                <h3>
                                    <i class="fa-solid fa-image"></i>
                                    View All Image
                                </h3>
                            </div>
                        </a>
                    </div>
                </c:if>

                <c:if test="${not empty tour.tour_Img[4]}">
                    <div class="image-4">
                        <img class="tour-img" src="${tour.tour_Img.get(4)}" alt="Tour Image 5">
                        <a href="javascript:void(0)" onclick="toggle('popup1')">
                            <div class="img-viewmore">
                                <h3>
                                    <i class="fa-solid fa-image"></i>
                                    View All Image
                                </h3>
                            </div>
                        </a>
                    </div>
                </c:if>
            </div>



            <div class="tour-detail">
                <div class="tour-detail-left-section">
                    <div class="left-section-above">
                        <div class="average-rating">
                            <span class="average-rating-point">${tour.average_Review_Rating}</span>

                            <div class="rank">
                                <span class="rank-type">Excellent</span>
                                <br>
                                <span class="number-rating">From ${tour.number_Of_Review} Review</span>
                            </div>
                        </div>

                        <div class="map">
                            <i class="fa-solid fa-map-location-dot"></i>
                            <div class="map-content">
                                <span class="view-map">Show map</span>
                                <br>
                                <span>${tour.location}</span>
                            </div>

                        </div>
                    </div>

                    <div class="left-section-below">
                        <div class="experiment">
                            <h5>What You'll Experience</h5>
                            <ul>
                                <c:forEach var="experience" items="${tourDetailDescription.experiences}">
                                    <li>${experience}</li>
                                    </c:forEach>
                            </ul>
                            <a href="javascript:void(0)" class="view-more-experiment" onclick="toggle('popup3')">Read More</a>
                        </div>
                        <div class="split"></div>

                        <div class="more-information">
                            <a href="javascript:void(0)" onclick="toggle('popup2')">Contacts, Facilities, Service Language and More</a>
                        </div>
                    </div>
                </div>

                <div class="tour-detail-right-section">
                    <div class="price-section">
                        <div class="price">
                            <span class="start-from">Start From</span>
                            <h4>${tour.price}</h4>
                        </div>
                        <button class="find-tour-btn">Find Options</button>
                    </div>
                    <div class="view-review">

                        <span class="view-review-content">What Travelers Say</span>
                        <a href="#" id="viewAllReviewsBtn">See All Reviews</a>

                    </div>

                    <!-- Popup để hiển thị tất cả các đánh giá -->
                    <div id="reviewPopup" class="popup">
                        <div class="popup-content card shadow-lg">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h2 class="mb-0">All Reviews</h2>
                                <span class="close-btn" id="closePopup">&times;</span>
                            </div>
                            <div class="card-body">
                                <div class="all-reviews">
                                    <c:forEach var="review" items="${allReviews}">
                                        <div class="card mb-3 review-item">
                                            <div class="card-body">
                                                <div class="d-flex justify-content-between align-items-center mb-2">
                                                    <h5 class="card-title text-primary mb-0">${review.first_Name} ${review.last_Name}</h5>
                                                    <div class="review-stars text-warning">
                                                        <c:forEach var="i" begin="1" end="${review.rating_Star}">
                                                            ★
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                                <p class="card-text text-secondary">${review.comment}</p>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>



                    <div class="highlight-review container mt-4">
                        <div class="review-list">
                            <c:choose>
                                <c:when test="${not empty reviews}">
                                    <c:forEach var="review" items="${reviews}">
                                        <div class="card review-item mb-3 shadow-sm">
                                            <div class="card-body">
                                                <h5 class="card-title text-primary">${review.first_Name} ${review.last_Name}</h5>
                                                <p class="card-text text-secondary mb-2"><i class="fas fa-star text-warning"></i> ${review.rating_Star} / 5</p>
                                                <p class="card-text"><strong>Comment:</strong> ${review.comment}</p>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="alert alert-info text-center">No review for this tour.</div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>

            <div class="tour-itinerary">
                <h4>Tour Itinerary</h4>
                <span>
                    <ul>
                        <c:forEach var="itinerary" items="${tourDetailDescription.tourItinerary}">
                            <li>${itinerary}</li>
                            </c:forEach>
                    </ul>
                </span>
                <a href="javascript:void(0)" onclick="toggle('popup4')">See Complete Itinerary</a>
            </div>

            <div class="tour-booking">
                <h4>Available Ticket(s) for You</h4>
                <div id="notification" style="display: none; color: red;">Ngày được chọn không có tour nào!</div>
                <div class="date-picking">
                    <button class="calendar" onclick="openCalendar(); toggle('blur');">
                        <i class="fa-solid fa-calendar-days"></i>
                        See Calendar
                    </button>

                    <input type="text" id="calendarInput" style="display: none;" />
                    <div class="date-wrapper">
                        <button class="scroll-left" onclick="scrollLeft1()">
                            <i class="fa-solid fa-arrow-right fa-flip-horizontal"></i>
                        </button>

                        <div class="date-section" id="date-section">
                            <!-- Tạo 14 khung ngày -->
                            <div class="date-container" data-index="0" onclick="selectDate(this)">
                                <span class="day-of-week" data-dayofweek="0"></span>
                                <span class="date" data-formatteddate="0"></span>
                            </div>

                            <div class="date-container" data-index="1" onclick="selectDate(this)">
                                <span class="day-of-week" data-dayofweek="1"></span>
                                <span class="date" data-formatteddate="1"></span>

                            </div>
                            <div class="date-container" data-index="2" onclick="selectDate(this)">
                                <span class="day-of-week" data-dayofweek="2"></span>
                                <span class="date" data-formatteddate="2"></span>
                            </div>
                            <div class="date-container" data-index="3" onclick="selectDate(this)">
                                <span class="day-of-week" data-dayofweek="3"></span>
                                <span class="date" data-formatteddate="3"></span>
                            </div>
                            <div class="date-container" data-index="4" onclick="selectDate(this)">
                                <span class="day-of-week" data-dayofweek="4"></span>
                                <span class="date" data-formatteddate="4"></span>
                            </div>
                            <div class="date-container" data-index="5" onclick="selectDate(this)">
                                <span class="day-of-week" data-dayofweek="5"></span>
                                <span class="date" data-formatteddate="5"></span>
                            </div>
                            <div class="date-container" data-index="6" onclick="selectDate(this)">
                                <span class="day-of-week" data-dayofweek="6"></span>
                                <span class="date" data-formatteddate="6"></span>
                            </div>
                            <div class="date-container" data-index="7" onclick="selectDate(this)">
                                <span class="day-of-week" data-dayofweek="7"></span>
                                <span class="date" data-formatteddate="7"></span>
                            </div>
                            <div class="date-container" data-index="8" onclick="selectDate(this)">
                                <span class="day-of-week" data-dayofweek="8"></span>
                                <span class="date" data-formatteddate="8"></span>
                            </div>
                            <div class="date-container" data-index="9" onclick="selectDate(this)">
                                <span class="day-of-week" data-dayofweek="9"></span>
                                <span class="date" data-formatteddate="9"></span>
                            </div>
                            <div class="date-container" data-index="10" onclick="selectDate(this)">
                                <span class="day-of-week" data-dayofweek="10"></span>
                                <span class="date" data-formatteddate="10"></span>
                            </div>
                            <div class="date-container" data-index="11" onclick="selectDate(this)">
                                <span class="day-of-week" data-dayofweek="11"></span>
                                <span class="date" data-formatteddate="11"></span>
                            </div>
                            <div class="date-container" data-index="12" onclick="selectDate(this)">
                                <span class="day-of-week" data-dayofweek="12"></span>
                                <span class="date" data-formatteddate="12"></span>
                            </div>
                            <div class="date-container" data-index="13" onclick="selectDate(this)">
                                <span class="day-of-week" data-dayofweek="13"></span>
                                <span class="date" data-formatteddate="13"></span>
                            </div>
                        </div>


                        <button class="scroll-right" onclick="scrollRight()">
                            <i class="fa-solid fa-arrow-right"></i>
                        </button>
                    </div>
                </div>                  

                <div class="tour-options-section">
                    <c:forEach items="${tourOptions}" var="option">
                        <div class="tour-option" data-tour-date="${option.tour_Date}">
                            <div class="tour-option-left-section">
                                <span class="option-name">${option.option_Name}</span>
                                <span class="option-note">${option.option_Description}</span>
                                <a href="javascript:void(0)" class="tour-option-detail" onclick="toggle('popup5')">Xem chi tiết</a>
                                <span class="refund-section">${option.day_Of_Week}</span>
                            </div>
                            <div class="tour-option-right-section">
                                <div class="top-pick-logo">Top pick ${option.available_Slots}</div>
                                <div class="option-price-section">
                                    <div class="option-price">${option.option_Price}</div>

                                    <!-- Kiểm tra available_Slots -->
                                    <c:choose>
                                        <c:when test="${option.available_Slots > 0}">
                                            <button class="option-pick-btn" 
                                                    onclick="window.location.href = 'optionAdjustment?id=${option.option_Id}&selectedDate=' + selectedDate.toISOString().split('T')[0]">
                                                Chọn vé
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="option-pick-btn" disabled>Hết lượt</button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>                            
                        </div>
                    </c:forEach>
                </div>
            </div>
            <jsp:include page="CommentServlet">
                <jsp:param name="tourId" value="${tourId}" />
            </jsp:include>

            <div class="tour-rating">

            </div>
        </div>
    </div>
    <!--Popup1-->
    <div id="popup1">
        <div id="carouselExampleIndicators" class="carousel slide">
            <div class="carousel-indicators">
                <c:forEach var="i" begin="0" end="${fn:length(tour.tour_Img) - 1}">
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="${i}"
                            class="${i == 0 ? 'active' : ''}" aria-current="${i == 0 ? 'true' : 'false'}"
                            aria-label="Slide ${i + 1}"></button>
                </c:forEach>
            </div>
            <div class="carousel-inner">
                <c:forEach var="image" items="${tour.tour_Img}">
                    <div class="carousel-item ${image eq tour.tour_Img[0] ? 'active' : ''}">
                        <img src="${image}" class="carousel-img d-block w-100" alt="...">
                    </div>
                </c:forEach>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators"
                    data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators"
                    data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>

        </div>
        <div class="carousel-inner">
            <c:forEach var="image" items="assests/images/tour-images/${tour.tour_Img}">
                <div class="carousel-item ${image eq tour.tour_Img[0] ? 'active' : ''}">
                    <img src="${image}" class="carousel-img d-block w-100" alt="...">
                </div>
            </c:forEach>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators"
                data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators"
                data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>

        <button type="button" class="btn-close" aria-label="Close" onclick="toggle('popup1')"></button>
    </div>
    <!--Popup2-->
    <div id="popup2">
        <h3>More Information</h3>
        <div class="information-wrapper">
            <div class="language-service">
                <h4>Service Language(s)</h4>
                <span>Service available in:</span>
                <ul>
                    <c:forEach var="language" items="${tourDetailDescription.languageService}">
                        <li>${language}</li>
                        </c:forEach>
                </ul>
            </div>
        </div>
        <div class="extra-information">
            <h4>Additional Information</h4>
            <span>
                <ul>
                    <c:forEach var="info" items="${tourDetailDescription.additionalInformation}">
                        <li>${info}</li>
                        </c:forEach>
                </ul>
            </span>
        </div>

        <button type="button" class="btn-close" aria-label="Close" onclick="toggle('popup2')"></button>
    </div>

    <!--Popup3-->
    <div id="popup3">
        <h3>What You'll Experience</h3>
        <div class="experiment-wrapper">
            <ul>
                <c:forEach var="experience" items="${tourDetailDescription.experiences}">
                    <li>${experience}</li>
                    </c:forEach>
            </ul>


            <!--            <span>Bà Nà Hills là khu phức hợp giải trí và resort lớn nhất tại Việt Nam. Cùng nhau đi tour và xả láng cả
                            ngày tại Bà Nà Hills ngay nào! Tận hưởng không khí mát lạnh cùng phong cảnh tuyệt vời, ăn hết mình với
                            đủ loại ẩm thực và chơi hết sức với những lễ hội và các hoạt động giải trí đa dạng diễn ra hằng ngày,
                            tất cả đều ngay tại đây!</span>

                        <img src="assests/images/new-image/jojo1.jpg" alt="">
                        <span>Tận hưởng bầu không khí mát lạnh khi bạn "lướt" mây lên đến đỉnh Bà Nà </span>

                        <img src="assests/images/new-image/jojo2.jpg" alt="">
                        <span>Đừng quên "đua tốc độ" và tham gia rất nhiều trò chơi hấp dẫn khác tại Bà Nà nhé! </span>

                        <img src="assests/images/new-image/jojo3.jpg" alt="">
                        <span>Ngắm nhìn Bà Nà lấp lánh trong ánh đèn khi hoàng hôn buông xuống</span>-->
        </div>

        <button type="button" class="btn-close" aria-label="Close" onclick="toggle('popup3')"></button>
    </div>

    <!--Popup4-->
    <div id="popup4">
        <h3>Tour Itinerary</h3>
        <div class="tour-itinerary-wrapper">
            <ul>
                <c:forEach var="itinerary" items="${tourDetailDescription.tourItinerary}">
                    <li>${itinerary}</li>
                    </c:forEach>
            </ul>
        </div>

        <button type="button" class="btn-close" aria-label="Close" onclick="toggle('popup4')"></button>
    </div>    

    <!--Popup5-->
    <div id="popup5">
        <h4>Tour ghép</h4>
        <div class="tour-option-detail-wrapper">
            <div class="tour-time-popup">
                <span>
                    Thời lượng tour:
                    ${tour.total_Time}
                </span>

                <span>
                    Thời gian và điểm đón:
                    <ul>
                        <li>Khách sẽ được đón tại nơi lưu trú nằm tại trung tâm thành phố Đà Nẵng từ 07:30 – 08:30 </li>
                        <li>Đối với khách nằm ngoài khu vực trung tâm thành phố Đà Nẵng, vui lòng tham khảo Thông tin
                            thêm trên trang Sản phẩm để biết thêm chi tiết </li>
                    </ul>
                </span>
            </div>

            <span class="refund-section-popup">
                Easy Refund
            </span>

            <div class="price-wrapper">
                <span class="price-wrapper-inner">1.216.867 VND</span>

                <button>Chọn vé</button>
            </div>

            <div>
                <nav id="navbar-example2" class="navbar-inner bg-body-tertiary px-3 mb-3">
                    <ul class="nav nav-pills">
                        <li class="nav-item">
                            <a class="nav-link" href="#scrollspyHeading1">First</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#scrollspyHeading2">Second</a>
                        </li>
                        <li class="nav-item"></li>
                        <a class="nav-link" href="#scrollspyHeading3">Third</a>
                        </li>
                        <li class="nav-item"></li>
                        <a class="nav-link" href="#scrollspyHeading4">Fourth</a>
                        </li>
                        <li class="nav-item"></li>
                        <a class="nav-link" href="#scrollspyHeading5">Fifth</a>
                        </li>
                    </ul>
                </nav>
                <div data-bs-spy="scroll" data-bs-target="#navbar-example2" data-bs-root-margin="0px 0px -40%"
                     data-bs-smooth-scroll="true" class="navbar-content scrollspy-example bg-body-tertiary p-3 rounded-2" tabindex="0">
                    <h4 id="scrollspyHeading1">First heading</h4>
                    <span>
                        Giá đã bao gồm
                        Bữa ăn:

                        1 buffet trưa
                        Phương tiện di chuyển:

                        Xe có máy điều hoà để đưa đón và trung chuyển
                        Dịch vụ khác:

                        Vé vào cửa
                        Bảo hiểm du lịch
                        Hướng dẫn viên nói tiếng Việt - Anh
                    </span>
                    <h4 id="scrollspyHeading2">Second heading</h4>
                    <span>
                        Hiệu lực của voucher

                        Sử dụng vào ngày đã chọn
                        Có hiệu lực vào mọi ngày bình thường
                        Có hiệu lực vào mọi ngày lễ
                        Dành cho khách Việt Nam
                    </span>
                    <h4 id="scrollspyHeading3">Third heading</h4>
                    <span>
                        Nếu đặt chỗ của bạn đã được xác nhận, nhân viên điều hành tour sẽ liên hệ với bạn qua điện thoại
                        ít nhất 24 giờ trước khi tour bắt đầu.
                    </span>
                    <h4 id="scrollspyHeading4">Fourth heading</h4>
                    <span>
                        Đặt chỗ này không thể thay đổi lịch.
                        Yêu cầu hoàn tiền muộn nhất là 2 ngày trước ngày đi đã chọn của bạn để nhận được 100% hoàn tiền.
                        Đặt chỗ của bạn sẽ không được hoàn lại nếu bạn yêu cầu hoàn tiền ít hơn 2 ngày trước ngày đi đã
                        chọn.
                    </span>
                    <h4 id="scrollspyHeading5">Fifth heading</h4>
                    <span>
                        Điều khoản & Điều kiện
                        Thông tin chung
                        Phụ phí 100.000 VND/khách, thanh toán trực tiếp với nhà cung cấp tour, áp dụng vào các ngày khởi
                        hành tour sau: 18 Th04, 30 Th04, 1 Th05, 31 Th08 – 3 Th09 2024.
                        Dịch vụ đón trả miễn phí cho khách ở tại trung tâm thành phố Đà Nẵng.
                        Phí đón trả khách sẽ được áp dụng nếu khách có nguyện vọng được đón trả tại những địa điểm sau:
                    </span>
                </div>
            </div>

        </div>


        <button type="button" class="btn-close" aria-label="Close" onclick="toggle('popup5')"></button>
    </div>
    <!--    <div id="popup5" class="popup">
            <div class="popup-content">
                <button type="button" class="btn-close" aria-label="Close" onclick="toggle('popup5')">Close</button>
    
                 Dynamic content of the popup 
                <div class="tour-option-detail-wrapper">
    <c:forEach items="${optionDetails}" var="detail">
        <div>
            <h4>Category: 
        <c:choose>
            <c:when test="${detail.categoryId == 1}">Price Includes</c:when>
            <c:when test="${detail.categoryId == 2}">Meals</c:when>
            <c:when test="${detail.categoryId == 3}">Transport</c:when>
            <c:when test="${detail.categoryId == 4}">Additional Services/Items</c:when>
            <c:when test="${detail.categoryId == 5}">Price Excludes</c:when>
        </c:choose>
    </h4>
    <span>${detail.detailDescription}</span>
    </div>
    </c:forEach>
    </div>
    </div>
    </div>-->

    <div class="tour-content">



    </div>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous">
</script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<!--<script>
    function fetchDetails(optionId) {
        // Construct the URL using window.location.origin
        const origin = window.location.origin;
        var url = origin + `/Project_SWP/getTourOptionDetails?optionId=` + optionId;
        console.log("Fetching from url: " + url);
        // Fetch data from the server
        fetch(url)
            .then(response => {
                if (!response.ok) {
                    throw new Error("Network response was not ok");
                }
                return response.text();
            })
            .then(data => {
                // Update the content of the popup with the fetched data
                document.getElementById('popup5').innerHTML = data;
                toggle('popup5'); // Assuming toggle function is defined to show/hide the popup
            })
            .catch(error => {
                console.error("Fetch error: ", error);
                alert("Failed to load tour option details.");
            });
    }
</script>-->

<script>
            // Toggle function for handling blur and popups
            function toggle(action) {
                var blur = document.getElementById('blur');
                if (action === 'blur') {
                    // Chỉ kích hoạt blur
                    blur.classList.toggle('active');
                } else if (action === 'popup1') {
                    // Kích hoạt popup 1 và blur
                    blur.classList.toggle('active');
                    var popup1 = document.getElementById('popup1');
                    popup1.classList.toggle('active');
                } else if (action === 'popup2') {
                    // Kích hoạt popup 2 và blur
                    blur.classList.toggle('active');
                    var popup2 = document.getElementById('popup2');
                    popup2.classList.toggle('active');
                } else if (action === 'popup3') {
                    // Kích hoạt popup 2 và blur
                    blur.classList.toggle('active');
                    var popup3 = document.getElementById('popup3');
                    popup3.classList.toggle('active');
                } else if (action === 'popup4') {
                    // Kích hoạt popup 2 và blur
                    blur.classList.toggle('active');
                    var popup4 = document.getElementById('popup4');
                    popup4.classList.toggle('active');
                } else if (action === 'popup5') {
                    // Kích hoạt popup 2 và blur
                    blur.classList.toggle('active');
                    var popup5 = document.getElementById('popup5');
                    popup5.classList.toggle('active');
                } else if (action === 'calendar') {
                    // Kích hoạt popup 2 và blur
                    blur.classList.toggle('active');
                    const section = document.getElementById('date-section');
                    if (section) {
                        section.scrollLeft -= 600; // Di chuyển về phía trái
                    }
                } else {
                    // Đóng popup (khi người dùng nhấn nút "Close")
                    var popups = document.getElementsByClassName('popup');
                    for (var i = 0; i < popups.length; i++) {
                        popups[i].classList.remove('active');
                    }
                    blur.classList.remove('active');
                }
            }

            // Scroll date section
            function scrollRight() {
                const section = document.getElementById('date-section');
                if (section)
                    section.scrollLeft += 200;
            }

            function scrollLeft1() {
                const section = document.getElementById('date-section');
                if (section)
                    section.scrollLeft -= 200;
            }

            // Close blur effect when clicking outside of popup
            document.addEventListener('click', function (event) {
                var calendarElement = document.querySelector('.flatpickr-calendar');
                var blurElement = document.getElementById('blur');
                if (calendarElement && !calendarElement.contains(event.target) && !event.target.closest('.calendar') && blurElement && blurElement.classList.contains('active')) {
                    toggle(null);
                }
            }, true);

            // Display 14 days with available tour dates
            let selectedDate = new Date();
            function displayDateRange() {
                const daysOfWeek = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
                let dateContainers = document.querySelectorAll('.date-container');
                const tourOptions = [...document.querySelectorAll('.tour-option')];
                const availableTourDates = tourOptions.map(option => new Date(option.getAttribute('data-tour-date')))
                        .sort((a, b) => a - b)
                        .filter(date => date >= new Date());
                const closestTourDates = availableTourDates.slice(0, 14);

                for (let i = 0; i < dateContainers.length; i++) {
                    if (i < closestTourDates.length) {
                        const date = closestTourDates[i];
                        dateContainers[i].querySelector('[data-dayofweek]').innerText = daysOfWeek[date.getDay()];
                        dateContainers[i].querySelector('[data-formatteddate]').innerText = date.getDate() + ' thg ' + (date.getMonth() + 1);
                        dateContainers[i].onclick = () => selectDate(dateContainers[i], date.toISOString());
                        dateContainers[i].style.display = 'flex';
                        dateContainers[i].classList.toggle('selected', i === 0);
                        if (i === 0)
                            selectedDate = date;
                    } else {
                        dateContainers[i].style.display = 'none';
                    }
                }
                filterTourOptions(selectedDate);
            }

            const daysMapping = {
                'Sunday': 0, 'Monday': 1, 'Tuesday': 2, 'Wednesday': 3, 'Thursday': 4, 'Friday': 5, 'Saturday': 6
            };

            function filterTourOptions(selectedDate) {
                const dayOfWeek = selectedDate.getDay();
                const tourOptions = [...document.querySelectorAll('.tour-option')];
                tourOptions.forEach(option => {
                    const refundSection = option.querySelector('.refund-section').innerText;
                    const optionDayOfWeek = daysMapping[refundSection];
                    const tourDateStr = option.getAttribute('data-tour-date');
                    const tourDate = new Date(tourDateStr);
                    option.style.display = optionDayOfWeek === dayOfWeek && selectedDate.toDateString() === tourDate.toDateString() ? 'flex' : 'none';
                });
            }

            function selectDate(element, dateStr) {
                document.querySelectorAll('.date-container').forEach(date => date.classList.remove('selected'));
                element.classList.add('selected');
                selectedDate = new Date(dateStr);
                filterTourOptions(selectedDate);
            }

            function openCalendar() {
                flatpickr("#calendarInput", {
                    dateFormat: "Y-m-d", defaultDate: new Date(), minDate: "today",
                    onChange: function (selectedDates, dateStr) {
                        if (selectedDates.length > 0) {
                            const selectedDate = selectedDates[0].toISOString().split('T')[0];
                            const availableTourDates = getAvailableTourDates().map(date => new Date(date).toISOString().split('T')[0]);
                            if (!availableTourDates.includes(selectedDate)) {
                                document.getElementById('notification').innerText = "Ngày được chọn không có tour nào!";
                                document.getElementById('notification').style.display = 'block';
                            } else {
                                displayDateRange(new Date(selectedDate));
                                document.getElementById('notification').style.display = 'none';
                            }
                        }
                    },
                    onClose: function () {
                        toggle('calendar');
                    }
                }).open();
            }

            function getAvailableTourDates() {
                return [...document.querySelectorAll('.tour-option')].map(option => new Date(option.getAttribute('data-tour-date')).toDateString());
            }

            window.onload = displayDateRange;

            // Smooth scroll to section
            document.querySelectorAll('.nav-link').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    e.preventDefault();
                    document.querySelector(this.getAttribute('href')).scrollIntoView({behavior: 'smooth', block: 'start'});
                });
            });

            // Save to wishlist
            document.addEventListener('DOMContentLoaded', function () {
                document.querySelector('.save-btn').addEventListener('click', function () {
                    addWishlist(this.getAttribute('data-tour-id'), window.location.href);
                });
            });

            function addWishlist(tourId, returnUrl) {
                const request = new XMLHttpRequest();
                request.open('POST', 'wishlist', true);
                request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                request.onreadystatechange = function () {
                    if (request.readyState === XMLHttpRequest.DONE) {
                        const responseMessage = request.status === 200 ? JSON.parse(request.responseText).message : "An error occurred.";
                        Toastify({
                            text: responseMessage,
                            duration: 3000,
                            gravity: "top",
                            position: "right",
                            backgroundColor: responseMessage.includes("Failed") ? "linear-gradient(to right, #ff5f6d, #ffc371)" : "linear-gradient(to right, #00b09b, #96c93d)",
                        }).showToast();
                    }
                };
                request.send(`action=add&tourId=${tourId}&returnUrl=${returnUrl}`);
            }

            // Share page on Facebook
            function sharePage() {
                window.open("https://www.facebook.com/sharer/sharer.php?u=" + encodeURIComponent(window.location.href), '_blank');
            }

            // Open and close review popup
            document.getElementById("viewAllReviewsBtn").addEventListener("click", function (event) {
                event.preventDefault();
                var popup = document.getElementById("reviewPopup");
                var popupContent = document.querySelector(".popup-content");
                popup.classList.add("show");
                setTimeout(() => popupContent.classList.add("show"), 100);
            });

            document.getElementById("closePopup").addEventListener("click", function () {
                var popup = document.getElementById("reviewPopup");
                var popupContent = document.querySelector(".popup-content");
                popupContent.classList.remove("show");
                setTimeout(() => popup.classList.remove("show"), 400);
            });

            window.addEventListener("click", function (event) {
                var popup = document.getElementById("reviewPopup");
                if (event.target == popup) {
                    document.querySelector(".popup-content").classList.remove("show");
                    setTimeout(() => popup.classList.remove("show"), 400);
                }
            });
</script>


<script src="assests/js/searchpage-test.js"></script>
</body>

<%@include file="includes/footer.jsp" %>