// Render
$(() => {
    renderRating();

});

// Sự kiện khi người dùng thay đổi filter
$(() => {
    $('#filter-rating').change(function () {
        const selectedValue = $(this).val();
        $.ajax({
            type: 'GET',
            url: 'http://localhost:8080/api/client/rating-filter',
            data: {country: selectedValue},
            success: function (response) {
                // Xử lý phản hồi từ Servlet nếu cần
                console.log('Đã gửi yêu cầu thành công.');
            },
            error: function (xhr, status, error) {
                console.error('Lỗi khi gửi yêu cầu: ' + error);
            }
        });
    });
});

function renderRating() {
    const ratingBox = $('.rating-box');
    const totalRating = $('.total-rating h3');
    ratingBox.empty();

    // toFixed(1) để chỉ làm tròn 1 chữ số thập phân
    totalRating.text(averageRating.toFixed(1));
    totalRating.css({margin: '0 4px 0 0'});

    for (let i = 1; i <= 5; i++) {
        const star = $('<i>').addClass('fa-star fa-xl')
        if (i <= Math.floor(averageRating)) {
            star.addClass('fa-solid');
            star.css({color: '#FFD43B'});
        } else if (i === Math.ceil(averageRating) && averageRating % 1 !== 0) {
            star.removeClass('fa-star');
            star.addClass('fa-star-half-stroke');
            star.addClass('fa-solid');
            star.css({color: '#FFD43B'});
        } else {
            star.addClass('fa-regular');
            star.css({color: '#FFD43B'});
        }
        ratingBox.append(star);
    }
    ratingBox.append(`<span class="ms-2">${totalReview} đánh giá</span>`)
}

function renderReviews() {
    // ...
}

// function voted(buttonClicked, reviewId) {
//     $.ajax({
//         type: 'GET',
//         url: 'http://localhost:8080/api/client/vote',
//         dataType: 'json',
//         data: {reviewId: reviewId},
//         success: function (response) {
//             // Xử lý phản hồi không Servlet nếu cần
//             $(buttonClicked).text(`<i class="fa-thin fa-thumbs-up"></i>  Hữu ích (${response})`)
//             console.log('Đã gửi yêu cầu này.');
//         },
//         error: function (xhr, status, error) {
//             console.error('Lỗi khi gửi yêu cầu: ' + error);
//         }
//     })
// }