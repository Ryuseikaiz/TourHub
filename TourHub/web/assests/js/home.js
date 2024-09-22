

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
                result = tours.filter(tour => {
                    const normalizedInput = removeDiacritics(input.toLowerCase()).trim();
                    const normalizedTourName = removeDiacritics(tour.tourName.toLowerCase());
                    const inputWords = normalizedInput.split(" ").filter(word => word !== "");
                    return inputWords.every(word => normalizedTourName.includes(word));
                });
            } else {
                resultBox.innerHTML = '';
                resultBox.style.display = 'none';
            }
            displaySearchs(result);
        };
    }
});

function displaySearchs(result) {
    if (result.length > 0) {
        const content = result.map(item => {
            return `<li onclick="selectInput(this)" style="display: flex; align-items: center; margin-bottom: 10px;">
                        <div style="flex-shrink: 0;">
                            <img src="${item.tourImg}" alt="${item.tourName}" style="width: 100px; height: 100px; object-fit: cover;">
                        </div>
                        <span style="margin-left: 15px; font-size: 18px;">${item.tourName}</span>
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
        tour.tourName.toLowerCase().includes(city.toLowerCase())
    );
    const cityList = document.querySelector('.row.row-50');
    // Clear the existing list
    cityList.innerHTML = '';
    if (filteredTours.length === 0) {
        cityList.innerHTML = 'No tours found for the selected city.';
        return;
    }

    // Display filtered tours
    filteredTours.forEach(tour => {
        const colDiv = document.createElement('div');
        colDiv.classList.add('col-md-6', 'col-xl-4');
        const article = document.createElement('article');
        article.classList.add('event-default-wrap');
        const eventDefault = document.createElement('div');
        eventDefault.classList.add('event-default');
        const figure = document.createElement('figure');
        figure.classList.add('event-default-image');
        const img = document.createElement('img');
        img.src = tour.tourImg;
        img.alt = tour.tourName;
        img.width = 570;
        img.height = 370;
        figure.appendChild(img);
        eventDefault.appendChild(figure);
        const captionDiv = document.createElement('div');
        captionDiv.classList.add('event-default-caption');
        const learnMoreBtn = document.createElement('a');
        learnMoreBtn.classList.add('button', 'button-xs', 'button-secondary', 'button-nina');
        learnMoreBtn.href = "#";
        learnMoreBtn.textContent = "Learn more";
        captionDiv.appendChild(learnMoreBtn);
        eventDefault.appendChild(captionDiv);
        article.appendChild(eventDefault);
        const eventDefaultInner = document.createElement('div');
        eventDefaultInner.classList.add('event-default-inner');
        const tourInfoDiv = document.createElement('div');
        const tourName = document.createElement('h5');
        const tourLink = document.createElement('a');
        tourLink.classList.add('event-default-title');
        tourLink.href = "#";
        tourLink.textContent = tour.tourName;
        tourName.appendChild(tourLink);
        tourInfoDiv.appendChild(tourName);
        eventDefaultInner.appendChild(tourInfoDiv);
        const priceSpan = document.createElement('span');
        priceSpan.classList.add('heading-5');
        priceSpan.textContent = tour.price + " VND";
        tourInfoDiv.appendChild(priceSpan);
        const totalTimeDiv = document.createElement('div');
        totalTimeDiv.classList.add('heading-6');
        totalTimeDiv.textContent = tour.totalTime;
        eventDefaultInner.appendChild(totalTimeDiv);
        article.appendChild(eventDefaultInner);
        colDiv.appendChild(article);
        cityList.appendChild(colDiv);
    });
}
// Event listener to load tours for "Phú Quốc" automatically
document.addEventListener('DOMContentLoaded', function () {
    displayTours("Phú Quốc");
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
    searchContainer.style.display = 'none';
    // Add an event listener to the input field to detect user input
    searchInput.addEventListener('input', function () {
        const input = searchInput.value.trim();  // Trim the input to remove extra spaces
        console.log(input);

        // Check if the trimmed input is non-empty
        if (input.length > 0) {
            userInput.innerText = `"` + input + `"`;  // Update search keyword
            searchContainer.style.display = 'flex';    // Show element if input exists
        } else {
            searchContainer.style.display = 'none';      // Hide element if input is empty
        }
    });
});

function selectInput(list) {
    inputBox.value = list.innerText;
    resultBox.innerHTML = '';
    resultBox.style.display = 'none';
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
