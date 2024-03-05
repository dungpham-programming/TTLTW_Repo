const url = `http://localhost:8080${contextPath}/api/product-psr`;

window.addEventListener('popstate', function (event) {
    location.reload();
});

// Hàm chính của twbsPagination
// $(() => {}); chính là arrow function của $(document).ready(function() {});
$(() => {
    window.pagObj = $('#pagination').twbsPagination({
        // Kiểm tra các thuộc tính trong file .js (trong default)
        totalPages: totalPages,
        // Đây là SỐ PAGE HIỂN THỊ TRONG THANH CHỌN PAGE
        visiblePages: 5,
        startPage: currentPage,
        onPageClick: (event, page) => {
            // Nếu page hiện tại khác page đang chọn thì mới cần fetch data
            if (currentPage !== page) {
                changeURLAndFetchData(page)
                if (typeof categoryTypeId !== 'undefined') {
                    fetchDataByCateType(page, categoryTypeId, sort, range);
                }
                if (typeof key !== 'undefined') {
                    fetchDataByKey(page, key, sort, range);
                }
            }
        }
    });
});

// TODO: Xem xét thêm cho sort và range
function changeURLAndFetchData(pageClick) {
    let newURL = `http://localhost:8080/ttltw/shop-detail-by-type?categoryTypeId=${categoryTypeId}&recentPage=${pageClick}&sort=${sort}&range=none`;
    history.pushState({initial: true}, null, newURL);
}

// Hàm để fetch data từ API thông qua trang chi tiết loại sản phẩm
function fetchDataByCateType(page, categoryTypeId, sort, range) {
    $.ajax({
        url: url,
        type: "GET",
        dataType: "json",
        contentType: "json",
        data: {
            recentPage: page,
            categoryTypeId: categoryTypeId,
            sort: sort,
            range: range
        },
        success: (response) => {
            updateUI(response);
        },
        error: () => {
            console.log("Lỗi lấy dữ liệu!");
        }
    })
}

// Hàm để fetch data từ API thông qua trang tìm kiếm
function fetchDataByKey(page, key, sort, range) {
    $.ajax({
        url: url,
        type: "GET",
        dataType: "json",
        contentType: "json",
        data: {
            page: page,
            key: key,
            sort: sort,
            range: range
        },
        success: (response) => {
            updateUI(response)
        },
        error: () => {
            console.log("Lỗi lấy dữ liệu!");
        }
    })
}

function updateUI(response) {
    let productContainer = $("#product-container");
    productContainer.empty();

    // Lấy ra list products từ JSON
    if (response) {
        let products = response.products;
        appendProduct(productContainer, products);
        currentPage = response.recentPage;
        totalPages = response.totalPages;
    } else {
        console.log("Lỗi khi lấy lên sản phẩm!!!")
    }
}

function appendProduct(productContainer, products) {
    for (const product of products) {
        productContainer.append(`
            <div class="col-12 col-md-6 col-lg-3 mb-5">
                <div class="product-item">
                    <img src="../images/wooden/binh_go_cam_2_1.jpg" class="img-fluid product-thumbnail" alt="">
                    <h3 class="product-title">${product.name}</h3>
                    <strong class="product-price">${numeral(product.discountPrice).format('0,0')}₫</strong>
                    <div class="origin-price-and-discount">
                        <del>${numeral(product.originalPrice).format('0,0')}₫</del>
                        <label>${numeral(product.discountPercent).format('0,0')}%</label>
                    </div>
                    <a href="${contextPath}/cart-adding?productId=${product.id}&requestBy=shop-detail-by-type" class="btn-pop-mini left">
                        <i class="fa-solid fa-cart-plus fa-xl" style="color: #2a1710"></i>
                        <p class="content-btn-mini">Thêm vào giỏ hàng</p>
                    </a>
                    <a href="${contextPath}/product-detail?id=${product.id}" class="btn-pop-mini right">
                        <i class="fa-solid fa-info fa-xl" style="color: #2a1710"></i>
                        <p class="content-btn-mini">Chi tiết sản phẩm</p>
                    </a>
                </div>
            </div>
        `);
    }
}