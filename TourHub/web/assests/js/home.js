

// Function to handle button click and toggle active state
document.querySelectorAll('.group-btn button').forEach(button => {
    button.addEventListener('click', handleButtonClick);
});

function handleButtonClick(event) {
    const activeButton = document.querySelector('.group-btn .active');
    if (activeButton) {
        activeButton.classList.remove('active');
        activeButton.classList.add('btn-outline-primary');
        activeButton.classList.remove('btn-primary');
    }
    const clickedButton = event.currentTarget;
    clickedButton.classList.remove('btn-outline-primary');
    clickedButton.classList.add('btn-primary', 'active');
    const city = clickedButton.getAttribute('city');
    displayTours(city);
}

// Function to remove diacritics from a string
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

// Search box functionality
const resultBox = document.querySelector(".result-box");
const inputBox = document.getElementById("input-box");

document.addEventListener("DOMContentLoaded", function () {
    if (inputBox) {
        inputBox.onkeyup = function () {
            let result = [];
            let input = inputBox.value.trim();

            if (input.length) {
                resultBox.style.display = 'block';

                // Normalize the input string
                const normalizedInput = removeDiacritics(input.toLowerCase()).trim();
                const inputWords = normalizedInput.split(" ").filter(word => word !== "");

                // Helper function to match input with tour name or location
                function matchNormalizedField(field) {
                    if (field && typeof field === 'string') {
                        const normalizedField = removeDiacritics(field.toLowerCase());
                        return inputWords.every(word => normalizedField.includes(word));
                    }
                    return false;
                }

                // Filter tours by matching against tour name or location
                result = tours.filter(tour => matchNormalizedField(tour.location) || matchNormalizedField(tour.tour_Name));
            } else {
                resultBox.style.display = 'none';
            }
            displaySearchs(result); // Update the UI with the filtered results

        };
    }
});




function displaySearchs(result) {
    console.log(result);
    if (result.length > 0) {
        const content = result.map(item => {
            return `<li onclick="selectInput('${item.tour_Id}')" style="display: flex; align-items: center; margin-bottom: 10px;">
                        <div style="flex-shrink: 0;">
                            <img src="${item.tour_Img[0]}" alt="${item.tour_Name}" style="width: 100px; height: 100px; object-fit: cover;">
                        </div>
                        <span style="margin-left: 15px; font-size: 18px;">${item.tour_Name}</span>
                    </li>`;
        });
        resultBox.innerHTML = "<ul>" + content.join('') + "</ul>";
    } else {
        resultBox.innerHTML = "<ul><li>No results found</li></ul>";
    }
}


// Function to display tours based on the selected city
function displayTours(city) {
    // Filter tours based on the selected city
    const filteredTours = tours.filter(tour =>
        tour.location.toLowerCase().includes(city.toLowerCase())
    );

    const cityList = document.querySelector('.row.row-50');

    // Clear the existing list
    cityList.innerHTML = '';
    if (filteredTours.length === 0) {
        cityList.innerHTML = 'No tours found for the selected city.';
        return;
    }
    console.log(filteredTours);
    // Display filtered tours
    filteredTours.forEach(tour => {
        // Create the column div and set its classes
        const colDiv = document.createElement('div');
        colDiv.classList.add('col-md-6', 'col-xl-4');
        colDiv.style.maxHeight = '450px';
        colDiv.style.minHeight = '450px';

// Create the article element and set its class
        const article = document.createElement('article');
        article.classList.add('event-default-wrap');

// Create the event default div and set its class
        const eventDefault = document.createElement('div');
        eventDefault.classList.add('event-default');

// Create and append the image
        const figure = document.createElement('figure');
        figure.classList.add('event-default-image');

        const img = document.createElement('img');
        img.src = tour.tour_Img[0];
        img.alt = tour.tour_Name;
        // Set a fixed height and max height to ensure uniformity
        const fixedHeight = '370px'; // Set desired fixed height for all images
        img.style.height = fixedHeight; // Set the fixed height
        img.style.maxHeight = '300px'; // Set maximum height for the image
        img.style.width = 'auto'; // Allow width to adjust automatically

// Set CSS properties to ensure the image maintains aspect ratio and fits correctly
        img.style.objectFit = 'cover'; // This will crop the image to fit without distortion

        figure.appendChild(img);

// Append the figure to the event default div
        eventDefault.appendChild(figure);

// Create the caption div and set its class
        const captionDiv = document.createElement('div');
        captionDiv.classList.add('event-default-caption');

        // Create the "Learn more" button
        const learnMoreBtn = document.createElement('a');

// Add classes to style the button
        learnMoreBtn.classList.add('button', 'button-xs', 'button-secondary', 'button-nina', 'tour-visit-count');

// Set the href attribute to link to the detailed tour page, passing the tourId
        learnMoreBtn.href = `SearchTourByIdServlet?tourId=${tour.tour_Id}`;

// Set the button text
        learnMoreBtn.textContent = "Learn more";

// Optionally, store the tour ID as a data attribute (useful for tracking or event handling)
        learnMoreBtn.setAttribute('data-id', tour.tour_Id);

// Append the "Learn more" button to the caption div
        captionDiv.appendChild(learnMoreBtn);


        // Append the caption div to the event default div
        eventDefault.appendChild(captionDiv);

        // Append the event default div to the article element
        article.appendChild(eventDefault);

        // Create the inner div for additional information and set its class
        const eventDefaultInner = document.createElement('div');
        eventDefaultInner.classList.add('event-default-inner');

        // Create the tour info div and append the tour name and price
        const tourInfoDiv = document.createElement('div');

        // Create the tour name heading and link
        const tourName = document.createElement('h5');
        const tourLink = document.createElement('a');
        tourLink.classList.add('event-default-title');
        tourLink.href = `SearchTourByIdServlet?tourId=${tour.tour_Id}`; // Redirect to the detail page
        tourLink.textContent = tour.tour_Name;
        tourName.appendChild(tourLink);

        // Append the tour name to the tour info div
        tourInfoDiv.appendChild(tourName);


        // Append the tour info div to the event default inner div
        eventDefaultInner.appendChild(tourInfoDiv);

        // Create the total time div, set its content, and append it to the event default inner div
        const totalTimeDiv = document.createElement('div');
        totalTimeDiv.classList.add('heading-6');
        totalTimeDiv.textContent = tour.total_Time;
        eventDefaultInner.appendChild(totalTimeDiv);

        // Append the inner div to the article element
        article.appendChild(eventDefaultInner);

        // Append the article element to the column div
        colDiv.appendChild(article);

        // Finally, append the column div to the cityList container
        cityList.appendChild(colDiv);
    });
}

// Event listener to load tours for "Phú Quốc" automatically
document.addEventListener('DOMContentLoaded', function () {
    displayTours("Phu Quoc");
    // Add event listeners to buttons
    document.querySelectorAll('button[city]').forEach(button => {
        button.addEventListener('click', function () {
            const city = this.getAttribute('city');
            displayTours(city);
        });
    });
});


document.addEventListener("DOMContentLoaded", function () {
    // Get the search keyword element
    const userInput = document.getElementById("search-keyword");

    // Get the input field where the user types the search text
    const searchInput = document.getElementById("input-box");

    // Get the search container element
    const searchContainer = document.querySelector(".search-container");
    searchContainer.style.display = 'none'; // Initially hide the search container

    // Add an event listener to the input field to detect user input
    searchInput.addEventListener('input', function () {
        const input = searchInput.value.trim(); // Trim the input to remove extra spaces
        console.log(input);

        // Check if the trimmed input is non-empty
        if (input.length > 0) {
            userInput.innerText = `"${input}"`; // Update search keyword dynamically
            searchContainer.style.display = 'flex'; // Show element if input exists
        } else {
            searchContainer.style.display = 'none'; // Hide element if input is empty
        }
    });
});

function selectInput(tourId) {
    // Redirect to the SearchTourByIdServlet with the selected tour ID
    window.location.href = `SearchTourByIdServlet?tourId=${encodeURIComponent(tourId)}`;
}

// Function to toggle dropdown visibility
function toggleDropdown() {
    const dropdownContent = document.getElementById("dropdownContent");
    if (dropdownContent) {
        dropdownContent.classList.toggle("show");
    }
}

// Close the dropdown if the user clicks outside of it
window.addEventListener('click', function (event) {
    const avatarButton = document.querySelector('.avatar-button');
    const avatar = document.querySelector('.avatar');
    const dropdowns = document.querySelectorAll('.dropdown-content');
    if (!avatarButton.contains(event.target) && !avatar.contains(event.target)) {
        dropdowns.forEach(dropdown => {
            if (dropdown.classList.contains('show')) {
                dropdown.classList.remove('show');
            }
        });
    }
});
//
$(document).ready(function () {
    $('.location-slider').owlCarousel({
        items: 5, // Default items for screens below 480px
        loop: true, // Enable looping of items
        autoplay: true, // Autoplay feature
        autoplayTimeout: 3000, // 3 seconds delay between slides
        margin: 10, // Margin between items
        dots: false, // No dots navigation
        nav: false, // No navigation arrows
        responsive: {// Responsive breakpoints
            0: {
                items: 1    // 1 item below 480px
            },
            480: {
                items: 2    // 2 items between 480px and 767px
            },
            768: {
                items: 3    // 3 items between 768px and 991px
            },
            1024: {
                items: 5    // 5 items for 1024px and larger screens
            }
        }
    });
});


$(document).ready(function () {
    $('.location-link').click(function (e) {
//        e.preventDefault(); // Prevent default link behavior

        var provinceId = $(this).data('id'); // Get province ID
        $.ajax({
            url: 'UpdateVisitCountServlet', //servlet URL handle the update
            type: 'POST',
            data: {id: provinceId},
            success: function (response) {
                console.log('Visit count updated successfully:', response);
                // Redirect to login.jsp after updating the visit count
//                window.location.href = 'login.jsp';
            },
            error: function (xhr, status, error) {
                console.error('Error updating visit count:', error);
                // Optionally, redirect to login.jsp in case of an error as well
//                window.location.href = 'login.jsp';
            }
        });
    });
});

$(document).ready(function () {
    $('.tour-visit-count').click(function (e) {
//        e.preventDefault(); // Prevent default link behavior

        var tourId = $(this).data('id'); // Get province ID
        $.ajax({
            url: 'UpdateVisitCountServlet', //servlet URL handle the update
            type: 'GET',
            data: {id: tourId},
            success: function (response) {
                console.log('Visit count updated successfully:', response);
                // Redirect to login.jsp after updating the visit count
//                window.location.href = 'login.jsp';
            },
            error: function (xhr, status, error) {
                console.error('Error updating visit count:', error);
                // Optionally, redirect to login.jsp in case of an error as well
//                window.location.href = 'login.jsp';
            }
        });
    });
});
