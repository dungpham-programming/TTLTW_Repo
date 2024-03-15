const url = `http://localhost:8080${contextPath}/api/cart`;

$(document).ready(function() {
    $(".increase, .decrease").click(function() {
        // Lấy giá trị số lượng từ ô input tương ứng
        let quantity = parseInt($(this).closest(".quantity-container").find(".quantity-amount").val());

        // Kiểm tra xem nút được nhấn là tăng hay giảm số lượng
        if ($(this).hasClass("increase")) {
            quantity++;
        } else if ($(this).hasClass("decrease")) {
            if (quantity > 0) {
                quantity--;
            }
        }

        // Gửi yêu cầu AJAX đến Servlet
        $.ajax({
            type: "GET",
            url: url,
            data: { quantity: quantity },
            success: function(response) {
                // Xử lý kết quả từ Servlet nếu cần
                console.log("Yêu cầu thành công!");
            },
            error: function() {
                console.log("Lỗi xảy ra khi gửi yêu cầu AJAX!");
            }
        });
    });
});
