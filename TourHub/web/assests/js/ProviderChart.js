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

// Function to create placeholder charts
function createPlaceholderChart(ctx, type, labels, data) {
    return new Chart(ctx, {
        type: type,
        data: {
            labels: labels,
            datasets: [{
                    label: 'Loading...',
                    data: data,
                    backgroundColor: 'rgba(220, 220, 220, 0.6)',
                    borderColor: 'rgba(220, 220, 220, 1)',
                    borderWidth: 1
                }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
}

// Placeholder chart functions
function createPlaceholderBookingChart() {
    const ctx = document.getElementById('myChart').getContext('2d');
    if (myBookingChart)
        myBookingChart.destroy();
    myBookingChart = createPlaceholderChart(ctx, 'bar', defaultMonths, Array(12).fill(0));
}

function createPlaceholderProfitChart() {
    const ctx = document.getElementById('multiLineChart').getContext('2d');
    if (myProfitChart)
        myProfitChart.destroy();
    myProfitChart = createPlaceholderChart(ctx, 'line', defaultMonths, Array(12).fill(0));
}

function createPlaceholderHotDestinationsChart() {
    const ctx = document.getElementById('circleChart').getContext('2d');
    if (hotDestinationsChart)
        hotDestinationsChart.destroy();
    hotDestinationsChart = createPlaceholderChart(ctx, 'pie', ['Region 1', 'Region 2', 'Region 3', 'Region 4', 'Region 5'], Array(5).fill(0));
}

// Fetch booking data
function fetchMonthlyBookings() {
    $('#loadingSpinner').show();

    const year = $('#yearPicker').val() || new Date().getFullYear();

    fetch(`https://tourhub.azurewebsites.net/charts?year=${year}`)
            .then(response => {
                if (!response.ok)
                    throw new Error('Network response was not ok');
                return response.json();
            })
            .then(data => {
                const monthlyBookings = data.monthlyBookings || [];
                const months = monthlyBookings.map(entry => entry.month) || defaultMonths;
                const totalBookings = monthlyBookings.map(entry => entry.totalBookings || 0);
                createBookingChart(months.length ? months : defaultMonths, totalBookings.length ? totalBookings : Array(12).fill(0));
            })
            .catch(() => {
                createBookingChart(defaultMonths, Array(12).fill(0));
            })
            .finally(() => $('#loadingSpinner').hide());
}

// Create booking chart
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
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
}

// Fetch profit data
function fetchMonthlyProfits() {
    $('#loadingSpinner').show();
    const year = $('#yearPicker').val() || new Date().getFullYear();

    fetch(`https://tourhub.azurewebsites.net/charts?year=${year}`)
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
            .catch(() => {
                createProfitChart(defaultMonths, Array(12).fill(0), Array(12).fill(0));
            })
            .finally(() => $('#loadingSpinner').hide());
}

// Create profit chart
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

// Fetch hot destinations
async function fetchHotDestinations() {
    $('#loadingSpinner').show();

    const year = $('#yearPicker').val() || new Date().getFullYear();

    try {
        const response = await fetch(`https://tourhub.azurewebsites.net/charts?year=${year}`);
        if (!response.ok)
            throw new Error('Network response was not ok');
        const data = await response.json();

        const labels = data.categoryLabels || ['Region 1', 'Region 2', 'Region 3', 'Region 4', 'Region 5'];
        const dataPoints = data.categoryData || Array(labels.length).fill(0);

        createHotDestinationsChart(labels, dataPoints);

    } catch (error) {
        createHotDestinationsChart(['Region 1', 'Region 2', 'Region 3', 'Region 4', 'Region 5'], Array(5).fill(0));
    } finally {
        $('#loadingSpinner').hide();
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

// Initialize charts
document.addEventListener('DOMContentLoaded', () => {
    $('#yearPicker').datetimepicker({
        format: "YYYY",
        viewMode: "years"
    }).on('dp.change', (e) => {
        const selectedYear = e.date.year();
        fetchMonthlyBookings(selectedYear);
        fetchMonthlyProfits(selectedYear);
        fetchHotDestinations(selectedYear);
    });

    const currentYear = new Date().getFullYear();
    $('#yearPicker').val(currentYear);

    createPlaceholderBookingChart();
    createPlaceholderProfitChart();
    createPlaceholderHotDestinationsChart();

    fetchMonthlyBookings(currentYear);
    fetchMonthlyProfits(currentYear);
    fetchHotDestinations(currentYear);
});