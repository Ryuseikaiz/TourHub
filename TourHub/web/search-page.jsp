<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
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

        </style>
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

        <body>
            <div class="search-bar">
                <div class="current-place">
                    <p>Xperience / Search Results</p>
                </div>

                <div class="search-container">
                    <button class="pick-location-btn" id="button" onclick="openPopup()">
                        <i class="fa-solid fa-location-dot"></i>
                        <p id="selected-location">All</p>
                        <i class="fa-solid fa-caret-down"></i>
                    </button>


                    <input class="search-box" type="text" id="input-box" placeholder="Any ideas on what to do for your next trip?" autocomplete="off"> 
                    <div class="result-box" id="result-box"></div>
                </div>
                <div class="location-popup" id="popup">

                    <div class="popup-content">
                        <p>Choose your destination</p>
                        <i class="close fa-solid fa-xmark" alt="Close" onclick="closePopup()"></i>
                        <div class="location-container">
                            <div class="row">
                                <div class="location col-md-6">
                                    <button class="location-btn" onclick="filterByLocation('All')">All</button> <!-- This will show all tours -->
                                </div>
                                <div class="location col-md-6">
                                    <button class="location-btn" onclick="filterByLocation('Ha Noi')">Ha Noi</button>
                                </div>
                                <div class="location col-md-6">
                                    <button class="location-btn" onclick="filterByLocation('Ho Chi Minh')">Ho Chi Minh</button>
                                </div>

                                <div class="location col-md-6">
                                    <button class="location-btn" onclick="filterByLocation('Da Nang')">Da Nang</button>
                                </div>
                                <div class="location col-md-6">
                                    <button class="location-btn" onclick="filterByLocation('Hue')">Hue</button>
                                </div>

                                <div class="location col-md-6">
                                    <button class="location-btn" onclick="filterByLocation('Hoi An')">Hoi An</button>
                                </div>
                                <div class="location col-md-6">
                                    <button class="location-btn" onclick="filterByLocation('Quang Ninh')">Quang Ninh</button>
                                </div>

                                <div class="location col-md-6">
                                    <button class="location-btn" onclick="filterByLocation('Can Tho')">Can Tho</button>
                                </div>
                                <div class="location col-md-6">
                                    <button class="location-btn" onclick="filterByLocation('Phan Thiet')">Phan Thiet</button>
                                </div>

                                <div class="location col-md-6">
                                    <button class="location-btn" onclick="filterByLocation('My Son')">My Son</button>
                                </div>
                                <div class="location col-md-6">
                                    <button class="location-btn" onclick="filterByLocation('Phu Quoc')">Phu Quoc</button>
                                </div>

                                <div class="location col-md-6">
                                    <button class="location-btn" onclick="filterByLocation('Quang Binh')">Quang Binh</button>
                                </div>
                                <div class="location col-md-6">
                                    <button class="location-btn" onclick="filterByLocation('Da Lat')">Da Lat</button>
                                </div>

                                <div class="location col-md-6">
                                    <button class="location-btn" onclick="filterByLocation('Ninh Thuan')">Ninh Thuan</button>
                                </div>
                                <div class="location col-md-6">
                                    <button class="location-btn" onclick="filterByLocation('Vung Tau')">Vung Tau</button>
                                </div>

                                <div class="location col-md-6">
                                    <button class="location-btn" onclick="filterByLocation('Nha Trang')">Nha Trang</button>
                                </div>
                                <div class="location col-md-6">
                                    <button class="location-btn" onclick="filterByLocation('Hai Phong')">Hai Phong</button>
                                </div>

                                <div class="location col-md-6">
                                    <button class="location-btn" onclick="filterByLocation('Bac Ninh')">Bac Ninh</button>
                                </div>
                                <div class="location col-md-6">
                                    <button class="location-btn" onclick="filterByLocation('Buon Ma Thuoc')">Buon Ma Thuot</button>
                                </div>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
            <div class="body-container">
                <!-- Sidebar -->
                <div class="sidebar">

                    <div class="xperience">
                        <div>
                            <h2>Xperience Highlights</h2>
                        </div>

                        <div>
                            <button class="btn-new-experience">New In Experience</button>
                        </div>
                    </div>


                    <div class="price-range">
                        <h3>Price Range</h3>
                        <select class="price-select" id="priceFilter" onchange="filterByPrice()">
                            <option value="0-0" ${param.priceRange == '0-0' ? 'selected' : ''}>All</option>
                            <option value="0-1000000" ${param.priceRange == '0-1000000' ? 'selected' : ''}>0 VND - 1.000.000 VND</option>
                            <option value="1000000-3000000" ${param.priceRange == '1000000-3000000' ? 'selected' : ''}>1.000.000 VND - 3.000.000 VND</option>
                            <option value="1000000-3000000" ${param.priceRange == '2000000-4000000' ? 'selected' : ''}>2.000.000 VND - 4.000.000 VND</option>
                            <option value="1000000-3000000" ${param.priceRange == '3000000-5000000' ? 'selected' : ''}>3.000.000 VND - 5.000.000 VND</option>
                            <option value="1000000-3000000" ${param.priceRange == '5000000-8000000' ? 'selected' : ''}>5.000.000 VND - 8.000.000 VND</option>
                            <option value="1000000-3000000" ${param.priceRange == '8000000-10000000' ? 'selected' : ''}>8.000.000 VND - 10.000.000 VND</option>
                            <option value="1000000-3000000" ${param.priceRange == '10000000-15000000' ? 'selected' : ''}>10.000.000 VND - 15.000.000 VND</option>
                            <option value="1000000-3000000" ${param.priceRange == '15000000-20000000' ? 'selected' : ''}>15.000.000 VND - 20.000.000 VND</option>
                        </select>
                    </div>

                    <div class="category">
                        <h3>Category</h3>
                        <ul>
                            <li><input type="checkbox" /> All</li>
                            <li><input type="checkbox" /> Nature Tours</li>
                            <li><input type="checkbox" /> Sightseeing</li>
                            <li><input type="checkbox" /> Arts & Culture</li>
                            <li><input type="checkbox" /> Water Tours</li>
                            <li><input type="checkbox" /> Site Tours</li>
                            <li><input type="checkbox" /> Culinary Tours</li>
                            <li><input type="checkbox" /> Themed Tours</li>
                            <li><input type="checkbox" /> Half-day Tours</li>
                            <li><input type="checkbox" /> Bus tour</li>
                            <li><input type="checkbox" /> Day Tour</li>
                            <li><input type="checkbox" /> Island Hopping</li>
                        </ul>
                        <button class="btn-see-all">See All</button>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="main-content">
                    <div class="main-content-header">
                        <h4>
                            Showing Tours activities in
                            <span id="location-heading">All</span>
                        </h4>
                        <div class="sort-options">
                            <label for="sortOrder">Sort by:</label>
                            <select id="sortOrder" name="sortOrder" onchange="sortTours()">
                                <option value="popularity" ${param.sortOrder == 'popularity' ? 'selected' : ''}>Most Popular</option>
                                <option value="price-asc" ${param.sortOrder == 'price-asc' ? 'selected' : ''}>Lowest Price</option>
                                <option value="price-desc" ${param.sortOrder == 'price-desc' ? 'selected' : ''}>Highest Price</option>
                                <option value="rating" ${param.sortOrder == 'rating' ? 'selected' : ''}>Rating</option>
                            </select>
                        </div>
                    </div>

                    <div class="tour-grid" id="tourGrid">
                        <!-- Tour Cards -->
                        <c:forEach items="${requestScope.data}" var="c">
                            <div class="tour-card" data-price="${c.price}" data-location="${c.location}">
                                <a href="displayTourDetail?id=${c.tour_Id}" style="text-decoration: none; color: inherit; cursor: pointer; width: 100%;">
                                    <img src="assests/images/tour-images/${c.tour_Img[0]}" alt="Tour Image"/>
                                    <div class="tour-card-info">
                                        <div class="tour-card-header">
                                            <p class="tour-location">
                                                <i class="fa-solid fa-location-dot"></i>
                                                ${c.location}
                                            </p>
                                            <i class="wishlist-btn fa-regular fa-heart"></i>
                                        </div>

                                        <p class="tour-name">${c.tour_Name}</p>

                                        <div class="tour-card-footer">
                                            <p class="review">
                                                <i class="fa-solid fa-star"></i>   
                                                <span class="review-point">
                                                    ${c.average_Review_Rating}
                                                </span> 
                                                (<span>${c.number_Of_Review}</span> reviews)
                                                <span class="purchases" style="visibility: hidden;">${c.purchases_Time}</span>
                                            </p>
                                            <p class="price">${c.price}</p>
                                        </div>                  
                                    </div>
                                </a>    
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Pagination Buttons -->
                    <div class="pagination">
                        <button id="prevPage" disabled>Previous</button>
                        <span id="pageNumbers"></span>
                        <button id="nextPage">Next</button>
                    </div>
                </div>
            </div>
        </body>
        <script>
            let popup = document.getElementById("popup");

            function openPopup() {
                popup.classList.add("location-popup-open");
                document.body.style.overflow = 'hidden';
            }

            function closePopup() {
                popup.classList.remove("location-popup-open");
                document.body.style.overflow = 'auto';
            }

            // Function to update the location in the button
//                document.querySelectorAll(".location-btn").forEach(button => {
//                    button.addEventListener("click", function() {
//                        // Get the button's text content (the location name)
//                        const selectedLocation = this.textContent;
//
//                        // Update the <p> tag inside the main button with the selected location
//                        document.getElementById("selected-location").textContent = selectedLocation;
//
//                        // Also update the location heading if needed
//                        document.getElementById("location-heading").textContent = selectedLocation;
//
//                        // Close the popup after selection
//                        closePopup();
//                    });
//                });

            document.querySelectorAll(".location-btn").forEach(button => {
                button.addEventListener("click", function () {
                    // Get the button's text content (the location name)
                    const selectedLocation = this.textContent;

                    // Store the selected location in localStorage
                    localStorage.setItem('selectedLocation', selectedLocation);

                    // Update the <p> tag inside the main button with the selected location
                    document.getElementById("selected-location").textContent = selectedLocation;

                    // Also update the location heading
                    document.getElementById("location-heading").textContent = selectedLocation;

                    // Close the popup after selection
                    closePopup();
                });
            });

            window.addEventListener('load', function () {
                // Check if there is a saved location in localStorage
                const savedLocation = localStorage.getItem('selectedLocation');

                if (savedLocation) {
                    // Update the location heading with the saved location
                    document.getElementById("location-heading").textContent = savedLocation;
                    document.getElementById("selected-location").textContent = savedLocation; // If needed for other elements
                }
            });



            function filterByLocation(location) {
                const sortOrder = document.getElementById('sortOrder') ? document.getElementById('sortOrder').value : 'popularity';
                window.location.href = 'allTour?location=' + location + '&sortOrder=' + sortOrder;
            }

            function sortTours() {
                const sortOrder = document.getElementById('sortOrder').value;
                const location = new URLSearchParams(window.location.search).get('location') || 'All'; // Retain the current location filter if present
                window.location.href = 'allTour?sortOrder=' + sortOrder + '&location=' + location;
            }

            function filterByPrice() {
                const priceRange = document.getElementById('priceFilter').value;
                const sortOrder = document.getElementById('sortOrder').value;
                const location = new URLSearchParams(window.location.search).get('location') || 'All';  // Retain the current location filter if present
                window.location.href = 'allTour?priceRange=' + priceRange + '&sortOrder=' + sortOrder + '&location=' + location;
            }

            document.addEventListener('DOMContentLoaded', function () {
                let tourCards = document.querySelectorAll('.tour-card');
                const toursPerPage = 9; // Number of tours to display per page
                let currentPage = 1;
                let totalPages = Math.ceil(tourCards.length / toursPerPage);

                // Function to show tours based on the current page
                function showTours(page) {
                    // Recalculate the total pages in case the number of cards changes dynamically
                    totalPages = Math.ceil(tourCards.length / toursPerPage);

                    // Hide all tours first
                    tourCards.forEach((card, index) => {
                        card.style.display = 'none';
                    });

                    // Calculate start and end index for the current page
                    const start = (page - 1) * toursPerPage;
                    const end = page * toursPerPage;

                    // Show tours within the range of start and end index
                    tourCards.forEach((card, index) => {
                        if (index >= start && index < end) {
                            card.style.display = 'block';
                        }
                    });

                    // Update pagination buttons
                    document.getElementById('prevPage').disabled = (page === 1);
                    document.getElementById('nextPage').disabled = (page === totalPages);

                    // Update page numbers display
                    updatePageNumbers(page);

                    // Scroll to the top of the page
                    window.scrollTo(0, 0);
                }

                // Function to update page numbers display
                function updatePageNumbers(currentPage) {
                    const pageNumbersContainer = document.getElementById('pageNumbers');
                    pageNumbersContainer.innerHTML = `Page ${currentPage} of ${totalPages}`;
                }

                // Event listeners for pagination buttons
                document.getElementById('prevPage').addEventListener('click', function () {
                    if (currentPage > 1) {
                        currentPage--;
                        showTours(currentPage);
                    }
                });

                document.getElementById('nextPage').addEventListener('click', function () {
                    if (currentPage < totalPages) {
                        currentPage++;
                        showTours(currentPage);
                    }
                });

                // Initially show the first page of tours
                showTours(currentPage);
            });



        </script>
        <script src="assests/js/searchpage-test.js"></script>
</body>

<%@include file="includes/footer.jsp" %>