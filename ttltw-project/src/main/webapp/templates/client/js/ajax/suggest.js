$(document).ready(() => {
    $('#search-box').on('input', () => {
        let searchKey = $('#search-box').val();
        let url = `http://localhost:8080${contextPath}/api/suggest-key`;
        $.ajax({
            url: url,
            type: "GET",
            dataType: "json",
            data: {key: searchKey},
            success: (suggestKeys) => {
                displaySuggestions(suggestKeys);
            },
            error: () => {
                console.log("Lỗi lấy dữ liệu!");
            }
        });
    });
});

// Bắt sự kiện khi người dùng nhấn vào vùng khác
$(document).on('click', (event) => {
    // Kiểm tra xem người dùng có nhấn vào ô tìm kiếm hay không
    if (!$(event.target).closest('#search-box').length) {
        // Người dùng nhấn vào vùng khác, xóa các thẻ suggest
        $('#search-suggest').empty();
        $('#search-suggest').css('display', 'none');
        $('#search-box').val('');
    }
});

function displaySuggestions(suggestKeys) {
    let suggestionsContainer = $('#search-suggest');
    suggestionsContainer.css('display', 'block')
    suggestionsContainer.empty();

    if (suggestKeys.length > 0) {
        for (let i = 0; i < suggestKeys.length; i++) {
            suggestionsContainer.append(`<li class="suggestion result">${suggestKeys[i]}</li>`);
        }
    } else {
        suggestionsContainer.append(`<li class="suggestion empty-result">Không có từ khóa gợi ý.</li>`);
    }
}