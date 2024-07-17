$(document).ready(function () {
    // Khi mở nút thông tin log (log-management)
    $("body").on("click", ".open-modal-button", function () {
        console.log("clicked");

        // Lấy dữ liệu từ data-send
        const data = $(this).attr("data-send");
        const jsonData = JSON.parse(data);
        $('.json-content').html(`<pre style="white-space: pre-wrap; margin: 0;"><code class="json">${JSON.stringify(jsonData, null, 2)}</code></pre>`)
    });

    // Khi ấn vào nút đánh giá (order-history)
    $("body").on("click", ".get-form-review", function () {
        console.log("clicked");
        const buttonClicked = $(this);
        const orderId = parseInt(buttonClicked.attr("data-send"));
        console.log(orderId);

        $.ajax({
            type: "GET",
            url: "http://localhost:8080/api/client/review-form",
            dataType: "json",
            data: {
                orderId: orderId
            },
            success: function (response) {
                renderListFormReview(response);
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });

        $("#reviewProduct").modal('show');
    });
});

const bodyReview = $('#reviewProduct .modal-body');

function renderListFormReview(response) {
    console.log(response);
    // Làm rỗng modal trước
    bodyReview.empty();

    if (response.length > 0) {
        // Lấy danh sách imgUrl

        for (const reviewForm of response) {
            const form = `
            <div class="form-container mb-4">
                <form action="http://localhost:8080/api/client/review-form" id="reviewForm-product${reviewForm.productId}" method="post">
                    <div class="form-group">
                        <h3>Đánh giá sản phẩm ${reviewForm.productName}</h3>
                    </div>
                    <div class="form-group">
                        <div class="img-block my-2 d-flex">
                            
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Đánh giá:</label><br>
                        <span class="star-rating">
                            <label for="rate-1" style="--i:1"><i class="fa-solid fa-star"></i></label>
                            <input type="radio" name="rating" id="rate-1" value="1">
                            <label for="rate-2" style="--i:2"><i class="fa-solid fa-star"></i></label>
                            <input type="radio" name="rating" id="rate-2" value="2">
                            <label for="rate-3" style="--i:3"><i class="fa-solid fa-star"></i></label>
                            <input type="radio" name="rating" id="rate-3" value="3">
                            <label for="rate-4" style="--i:4"><i class="fa-solid fa-star"></i></label>
                            <input type="radio" name="rating" id="rate-4" value="4">
                            <label for="rate-5" style="--i:5"><i class="fa-solid fa-star"></i></label>
                            <input type="radio" name="rating" id="rate-5" value="5" checked>
                        </span>
                    </div>
                    <div class="form-group">
                        <label for="comment">Bình luận:</label>
                        <textarea class="form-control" id="comment" name="comment" rows="3" required></textarea>
                    </div>
                    <button type="submit" onclick="sendForm($('#reviewForm-product${reviewForm.productId}'))" class="btn btn-primary mt-3">Gửi đánh giá</button>
                </form>
            </div>
            <hr>`;

            bodyReview.append(form);

            for (const imgUrl of reviewForm.productImgs) {
                const imgBlock = $(`#reviewForm-product${reviewForm.productId} .img-block`);
                imgBlock.empty();
                imgBlock.append(`<div><img class="img-fluid" style="height: 70px" src="${imgUrl}" alt="Product image"></div>`);
            }

            $(`#reviewForm-product${reviewForm.productId}`).submit((e) => {
                e.preventDefault();

                $.ajax({
                    type: "POST",
                    url: "http://localhost:8080/api/client/review-form",
                    data: this,
                    dataType: "json",
                    success: function (response) {
                        console.log(response);
                    },
                    error: function (xhr, status, error) {
                        console.log(error);
                    }
                });
            });
        }
    }
}

function sendForm(formSent) {
    const formContainer = $(formSent).parent();
    bodyReview.remove(formSent);
    formContainer.html(
        `<div class="alert alert-success">
                    Đánh giá của bạn đã được gửi
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>`
    );
}