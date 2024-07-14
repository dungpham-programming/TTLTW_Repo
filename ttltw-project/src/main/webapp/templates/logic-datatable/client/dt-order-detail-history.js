$(() => {
    $("#orderDetailHistory").DataTable({
        lengthMenu: [5, 10, 25, 100],
        processing: true,
        serverSide: true,
        ajax: {
            url: `http://localhost:8080/api/client/order-detail-history?orderId=${orderId}`,
            type: "POST",
            dataType: "json",
            dataSrc: "items",
        },
        columns: [
            {data: "productId"},
            {data: "productName"},
            {data: "originalPrice"},
            {data: "discountPrice"},
            {data: "discountPercent"},
            {data: "quantity"},
        ],
        columnDefs: [
            {
                targets: 2,
                render: (data, type, row, meta) => {
                    return `<span>${new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(data)}</span>`;
                }
            },
            {
                targets: 3,
                render: (data, type, row, meta) => {
                    return `<span style="color: #d31616; font-weight: 500;">${new Intl.NumberFormat('vi-VN', {
                        style: 'currency',
                        currency: 'VND'
                    }).format(data)}</span>`
                }
            },
            {
                targets: 4,
                render: (data, type, row, meta) => {
                    return `<span class="badge bg-danger">${data + "%"}</span>`;
                }
            }
        ]
    });
});