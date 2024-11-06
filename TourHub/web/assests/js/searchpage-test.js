/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

document.getElementById('input-box').addEventListener('input', function () {
    let query = this.value.trim().toLowerCase();
    let resultBox = document.getElementById('result-box');

    if (query.length > 0) {
        // Fetch both tours and provinces
        fetch(`/Project_SWP/search`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: `q=${encodeURIComponent(query)}` // Encoding the query parameter
        })
                .then(response => response.json())
                .then(data => {
                    // Check if the server response contains both `tours` and `provinces`
                    const tours = data.tours || [];
                    const provinces = data.provinces || [];

                    // Show the results if there are any, otherwise show "No results found"
                    showResults(tours, provinces);
                })
                .catch(error => {
                    console.error('Error fetching results:', error);
                    resultBox.innerHTML = '<p style="color: red;">Error fetching results.</p>';
                    resultBox.style.display = 'block'; // Display error message
                });
    } else {
        resultBox.style.display = 'none'; // Hide result box if no query
    }
});

function showResults(tours, provinces) {
    const resultBox = document.getElementById('result-box');
    resultBox.innerHTML = ''; // Clear previous results

    // If no results are found, show "No results found" message
    if (tours.length === 0 && provinces.length === 0) {
        const noResultsMessage = document.createElement('p');
        noResultsMessage.textContent = 'No results found';
        noResultsMessage.style.textAlign = 'center';
        noResultsMessage.style.fontSize = '18px';
        noResultsMessage.style.color = 'gray';
        resultBox.appendChild(noResultsMessage);
    } else {
        // Display provinces section if any
        if (provinces.length > 0) {
            const provinceHeader = document.createElement('h3');
            provinceHeader.textContent = 'Provinces';
            resultBox.appendChild(provinceHeader);

            provinces.forEach(province => {
                const listItem = document.createElement('li');
                listItem.classList.add('location-link'); // Adding the class to the li element
                listItem.style.display = 'flex';
                listItem.style.alignItems = 'center';
                listItem.style.marginBottom = '10px';
                listItem.setAttribute('data-id', province.province_id); // Adding data-id attribute
                listItem.onclick = () => selectProvince(province.province_name);

                const imgDiv = document.createElement('div');
                imgDiv.style.flexShrink = '0';

                const img = document.createElement('img');
                img.src = `assests/images/provinces/${province.image_url || 'default.jpg'}`; // Use a default image if none provided
                img.alt = province.province_name;
                img.style.width = '100px';
                img.style.height = '100px';
                img.style.objectFit = 'cover';

                imgDiv.appendChild(img);
                listItem.appendChild(imgDiv);

                const textSpan = document.createElement('span');
                textSpan.style.marginLeft = '15px';
                textSpan.style.fontSize = '18px';
                textSpan.textContent = province.province_name;

                listItem.appendChild(textSpan);
                resultBox.appendChild(listItem);
            });
        }

        // Display tours section if any
        if (tours.length > 0) {
            const tourHeader = document.createElement('h3');
            tourHeader.textContent = 'Tours';
            resultBox.appendChild(tourHeader);

            tours.forEach(tour => {
                const listItem = document.createElement('li');
                listItem.classList.add('tour-visit-count'); // Adding the class to the li element
                listItem.setAttribute('data-id', tour.tour_Id); // Adding data-id attribute
                listItem.onclick = () => selectTour(tour.tour_Id);
                listItem.style.display = 'flex';
                listItem.style.alignItems = 'center';
                listItem.style.marginBottom = '10px';

                const imgDiv = document.createElement('div');
                imgDiv.style.flexShrink = '0';

                const img = document.createElement('img');
                img.src = `${tour.tour_Img[0] || 'assets/images/tours/default.jpg'}`;
                img.alt = tour.tour_Name;
                img.style.width = '100px';
                img.style.height = '100px';
                img.style.objectFit = 'cover';

                imgDiv.appendChild(img);
                listItem.appendChild(imgDiv);

                const textSpan = document.createElement('span');
                textSpan.style.marginLeft = '15px';
                textSpan.style.fontSize = '18px';
                textSpan.textContent = tour.tour_Name;

                listItem.appendChild(textSpan);
                resultBox.appendChild(listItem);
            });
        }
    }

    // Display result box if it contains something (either results or "No results found")
    resultBox.style.display = 'block';
}

function selectProvince(provinceName) {
    // Redirect to the Province page with the selected province name
    window.location.href = `search?querry=${encodeURIComponent(removeDiacritics(provinceName))}`;
}

function selectTour(tourId) {
    // Redirect to the Tour page with the selected tour ID
    window.location.href = `SearchTourByIdServlet?tourId=${encodeURIComponent(tourId)}`;
}

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