$(document).ready(function () {
    // Attach click event handler using event delegation
    $(document).on('click', '.tour-visit-count', function (e) {
        // e.preventDefault(); // Uncomment if you want to prevent default link behavior

        const tourId = $(this).data('id');

        $.ajax({
            url: 'UpdateVisitCountServlet', // Servlet URL to handle the update
            type: 'GET',
            data: {id: tourId},
            success: function (response) {
                console.log('Visit count updated successfully:', response);
                // Redirect to the tour details page after updating the visit count
                const newUrl = `SearchTourByIdServlet?tourId=${encodeURIComponent(tourId)}`;
                window.location.assign(newUrl);
            },
            error: function (xhr, status, error) {
                console.error('Error updating visit count:', error);
                // Redirect to the tour details page in case of an error
                const newUrl = `SearchTourByIdServlet?tourId=${encodeURIComponent(tourId)}`;
                window.location.assign(newUrl);
            }
        });
    });

    $(document).on('click', '.location-link', function (e) {
        // e.preventDefault(); // Prevent default link behavior

        var provinceId = $(this).data('id'); // Get province ID
        $.ajax({
            url: 'UpdateVisitCountServlet', //servlet URL handle the update
            type: 'POST',
            data: {id: provinceId},
            success: function (response) {
                console.log('Visit count updated successfully:', response);
                // Redirect to login.jsp after updating the visit count
                // window.location.href = 'login.jsp';
            },
            error: function (xhr, status, error) {
                console.error('Error updating visit count:', error);
                // Optionally, redirect to login.jsp in case of an error as well
                // window.location.href = 'login.jsp';
            }
        });
    });
});