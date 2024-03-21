const addingCartUrl = `http://localhost:8080${contextPath}/api/cart-adding`;

// Function gửi yêu cầu AJAX khi click vào nút "Thêm vào giỏ hàng"
$(() => {
    // Lấy ra button giỏ hàng (.left)
    $(".btn-pop-mini.left").click(function(event) {
        event.preventDefault(); // Ngăn chặn hành động mặc định của nút

        const productId = $(this).closest('.product-item').find('input[name="productId"]').val(); // Lấy productId của sản phẩm

        // Gửi yêu cầu AJAX đến Servlet để thêm sản phẩm vào giỏ hàng
        $.ajax({
            type: "POST",
            url: addingCartUrl,
            dataType: "json",
            data: { productId: productId },
            success: (response) => {
                // Xử lý phản hồi từ Servlet (nếu cần)
                if (response.success === "true") {
                    const totalItems = response.totalItems;
                    successNotify();
                    updateTotalItem(totalItems);
                    // Xử lý response.sendRedirect được Servlet gửi trên client-side
                } else if (response.redirectLink) {
                    // Thực hiện chuyển hướng bằng cách cập nhật URL của trang
                    window.location.href = response.redirectLink;
                }
            },
            error: (xhr, status, error) => {
                // Xử lý lỗi (nếu có)
                console.error(xhr.responseText);
            }
        });
    });
});

const successNotify = () => {
    const popup = $(`<div id="autoDismissAlert" class="alert alert-success alert-dismissible fade show d-flex align-items-center adding-cart-notify" role="alert">
                        <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Info:"><use xlink:href="#info-fill"/></svg>
                        <div>Thêm vào giỏ hàng thành công!</div>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                     </div>`);

    $('body').append(popup);

    setTimeout(() => {
        $("#autoDismissAlert").alert('close');
    }, 3000);
}

const updateTotalItem = (totalItems) => {
    const totalItemElement = $(".number-item");
    totalItemElement.text(totalItems);
}