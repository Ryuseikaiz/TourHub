// Function to generate a random color in rgba format
function getRandomColor() {
    const r = Math.floor(Math.random() * 256);
    const g = Math.floor(Math.random() * 256);
    const b = Math.floor(Math.random() * 256);
    return `rgba(${r}, ${g}, ${b}, 1)`; // Fully opaque color
}

// Global chart variables
let myBookingChart = null;
let myProfitChart = null;
let hotDestinationsChart = null;

// Default months array (12 months)
const defaultMonths = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

// Show placeholder chart functions
function createPlaceholderBookingChart() {
    const ctx = document.getElementById('myChart').getContext('2d');

    if (myBookingChart)
        myBookingChart.destroy();

    myBookingChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: defaultMonths,
            datasets: [{
                    label: 'Loading...',
                    data: Array(12).fill(0), // Placeholder data
                    backgroundColor: 'rgba(220, 220, 220, 0.6)',
                    borderColor: 'rgba(220, 220, 220, 1)',
                    borderWidth: 1
                }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
}

function createPlaceholderProfitChart() {
    const ctx = document.getElementById('multiLineChart').getContext('2d');

    if (myProfitChart)
        myProfitChart.destroy();

    myProfitChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: defaultMonths,
            datasets: [
                {
                    label: 'Loading...',
                    data: Array(12).fill(0), // Placeholder data
                    borderColor: 'rgba(220, 220, 220, 1)',
                    backgroundColor: 'rgba(220, 220, 220, 0.2)',
                    borderWidth: 2,
                    fill: true
                }
            ]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true
                }
            },
            plugins: {
                legend: {
                    position: 'top'
                }
            }
        }
    });
}

function createPlaceholderHotDestinationsChart() {
    const ctx = document.getElementById('circleChart').getContext('2d');

    if (hotDestinationsChart)
        hotDestinationsChart.destroy();

    hotDestinationsChart = new Chart(ctx, {
        type: 'pie',
        data: {
            labels: ['Region 1', 'Region 2', 'Region 3', 'Region 4', 'Region 5'], // Placeholder labels
            datasets: [{
                    label: 'Loading...',
                    data: Array(5).fill(0), // Placeholder data
                    backgroundColor: [
                        'rgba(220, 220, 220, 0.6)', 'rgba(220, 220, 220, 0.6)',
                        'rgba(220, 220, 220, 0.6)', 'rgba(220, 220, 220, 0.6)',
                        'rgba(220, 220, 220, 0.6)'
                    ],
                    borderWidth: 1
                }]
        },
        options: {
            responsive: true,
        }
    });
}

// Fetch monthly bookings based on selected year
function fetchMonthlyBookings() {
    $('#loadingSpinner').show(); // Show spinner before fetching

    const year = $('#yearPicker').val() || new Date().getFullYear();
    console.log('Selected Year:', year);

    fetch(`charts?year=${year}`)
            .then(response => {
                console.log('Response Status:', response.status);
                if (!response.ok)
                    throw new Error('Network response was not ok');
                return response.json();
            })
            .then(data => {
                const monthlyBookings = data.monthlyBookings || [];
                console.log('Monthly Bookings:', monthlyBookings);

                const months = monthlyBookings.map(entry => entry.month) || defaultMonths;
                const totalBookings = monthlyBookings.map(entry => entry.totalBookings || 0);

                createBookingChart(months.length ? months : defaultMonths, totalBookings.length ? totalBookings : Array(12).fill(0));
            })
            .catch(error => {
                console.error('Error fetching booking data:', error);
                createBookingChart(defaultMonths, Array(12).fill(0)); // Fallback to 0 if error
            })
            .finally(() => {
                $('#loadingSpinner').hide(); // Hide spinner after data is loaded
            });
}

// Create bookings chart
function createBookingChart(months, totalBookings) {
    const ctx = document.getElementById('myChart').getContext('2d');

    if (myBookingChart)
        myBookingChart.destroy();

    myBookingChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: months.map(month => `Month ${month}`),
            datasets: [{
                    label: 'Monthly Bookings',
                    data: totalBookings,
                    backgroundColor: 'rgba(54, 162, 235, 0.6)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
}

// Fetch monthly profits based on selected year
function fetchMonthlyProfits() {
    $('#loadingSpinner').show(); // Show spinner before fetching

    const year = $('#yearPicker').val() || new Date().getFullYear();

    fetch(`charts?year=${year}`)
            .then(response => {
                if (!response.ok)
                    throw new Error('Network response was not ok');
                return response.json();
            })
            .then(data => {
                const profitsThisYear = data.monthlyProfitsThisYear?.map(entry => entry.profit || 0) || Array(12).fill(0);
                const profitsLastYear = data.monthlyProfitsLastYear?.map(entry => entry.profit || 0) || Array(12).fill(0);

                createProfitChart(defaultMonths, profitsThisYear, profitsLastYear);
            })
            .catch(error => {
                console.error('Error fetching profit data:', error);
                createProfitChart(defaultMonths, Array(12).fill(0), Array(12).fill(0));
            })
            .finally(() => {
                $('#loadingSpinner').hide(); // Hide spinner after data is loaded
            });
}

// Create profits chart
function createProfitChart(months, profitsThisYear, profitsLastYear) {
    const ctx = document.getElementById('multiLineChart').getContext('2d');

    if (myProfitChart)
        myProfitChart.destroy();

    myProfitChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: months,
            datasets: [
                {
                    label: 'This Year',
                    data: profitsThisYear,
                    borderColor: 'rgba(75, 192, 192, 1)',
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderWidth: 2,
                    fill: true
                },
                {
                    label: 'Last Year',
                    data: profitsLastYear,
                    borderColor: 'rgba(153, 102, 255, 1)',
                    backgroundColor: 'rgba(153, 102, 255, 0.2)',
                    borderWidth: 2,
                    fill: true
                }
            ]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true
                }
            },
            plugins: {
                legend: {
                    position: 'top'
                }
            }
        }
    });
}

// Fetch hot destinations based on selected year
async function fetchHotDestinations() {
    $('#loadingSpinner').show(); // Show spinner before fetching

    const year = $('#yearPicker').val() || new Date().getFullYear();

    try {
        const response = await fetch(`charts?year=${year}`);
        if (!response.ok)
            throw new Error('Network response was not ok');

        const data = await response.json();
        const {categoryLabels, categoryData} = data;

        const labels = categoryLabels || ['Region 1', 'Region 2', 'Region 3', 'Region 4', 'Region 5'];
        const dataPoints = categoryData || Array(labels.length).fill(0);

        createHotDestinationsChart(labels.length ? labels : ['Region 1', 'Region 2', 'Region 3', 'Region 4', 'Region 5'], dataPoints.length ? dataPoints : Array(5).fill(0));
    } catch (error) {
        console.error('Error fetching hot destinations:', error);
        createHotDestinationsChart(['Region 1', 'Region 2', 'Region 3', 'Region 4', 'Region 5'], Array(5).fill(0));
    } finally {
        $('#loadingSpinner').hide(); // Hide spinner after data is loaded
    }
}

// Create hot destinations chart
function createHotDestinationsChart(labels, dataPoints) {
    const ctx = document.getElementById('circleChart').getContext('2d');

    if (hotDestinationsChart)
        hotDestinationsChart.destroy();

    hotDestinationsChart = new Chart(ctx, {
        type: 'pie',
        data: {
            labels: labels,
            datasets: [{
                    label: 'Number of tour bookings by region',
                    data: dataPoints,
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.6)', 'rgba(54, 162, 235, 0.6)',
                        'rgba(255, 206, 86, 0.6)', 'rgba(75, 192, 192, 0.6)',
                        'rgba(153, 102, 255, 0.6)', 'rgba(255, 159, 64, 0.6)'
                    ],
                    borderWidth: 1
                }]
        },
        options: {
            responsive: true,
        }
    });
}

// Initialize year picker and fetch data when a year is selected
document.addEventListener('DOMContentLoaded', () => {
    $('#yearPicker').datetimepicker({
        format: "YYYY",
        viewMode: "years"
    }).on('dp.change', (e) => {
        const selectedYear = e.date.year();
        console.log('Year selected:', selectedYear);
        fetchMonthlyBookings(selectedYear);
        fetchMonthlyProfits(selectedYear);
        fetchHotDestinations(selectedYear);
    });

    // Optionally, if you want to auto-load the current year's data without waiting for user input:
    const currentYear = new Date().getFullYear();
    $('#yearPicker').val(currentYear); // Set current year in picker

    // Create placeholder charts
    createPlaceholderBookingChart();
    createPlaceholderProfitChart();
    createPlaceholderHotDestinationsChart();

    // Fetch real data
    fetchMonthlyBookings(currentYear);
    fetchMonthlyProfits(currentYear);
    fetchHotDestinations(currentYear);
});
