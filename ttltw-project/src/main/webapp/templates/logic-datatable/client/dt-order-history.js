$(() => {
    $("#orderHistory").DataTable({
        lengthMenu: [5, 10, 25, 100],
        processing: true,
        serverSide: true,
        ajax: {
            url: "http://localhost:8080/api/client/order-history",
            type: "POST",
            dataType: "json",
            dataSrc: "items",
        },
        columns: [
            {data: "id"},
            {data: "createdDate"},
            {data: "shipToDate"},
            {data: "total"},
            {data: "status"},
            // Thiết lập cho cột Thao tác
            {sortable: false, searchable: false,}
        ],
        columnDefs: [
            {
                targets: 1,
                render: (data, type, row, meta) => {
                    if (data != null) {
                        return moment(data).format("DD/MM/YYYY");
                    }
                }
            },
            {
                targets: 2,
                render: (data, type, row, meta) => {
                    if (data != null) {
                        return moment(data).format("DD/MM/YYYY");
                    }
                }
            },
            {
                targets: 3,
                render: (data, type, row, meta) => {
                    const totalPrice = data;
                    return new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(data);
                }
            },
            {
                targets: 4,
                render: (data, type, row, meta) => {
                    switch (data) {
                        case 1:
                            return '<span class="badge bg-primary bg-gradient">Chờ xác nhận</span>';
                        case 2:
                            return '<span class="badge bg-info bg-gradient">Đã xác nhận</span>';
                        case 3:
                            return '<span class="badge bg-warning bg-gradient">Đang vận chuyên</span>';
                        case 4:
                            return '<span class="badge bg-success bg-gradient">Thành công</span>';
                        case 0:
                            return '<span class="badge bg-danger bg-gradient">Đã huỷ</span>';
                        default:
                            return '<span class="badge bg-warning bg-gradient">Lỗi hệ thống</span>';
                    }
                }
            },
            {
                targets: 5,
                render: (data, type, row, meta) => {
                    let allButton = '';
                    const infoButton = `<a href="http://localhost:8080/order-detail-history?orderId=${row.id}" data-bs-toggle="tooltip" title="Chi tiết đơn hàng"
                           class="edit" style="padding: 6px 14px;"><i class="fa-solid fa-info fa-xl" style="color: #e3bd74;"></i></a>`;

                    const cancelButton = `<button onclick="deleteRecordByClient(this, ${row.id}, 'account')" data-bs-toggle="tooltip" title="Xóa ảnh" 
                           class="delete" style="padding: 6px 12px; margin-left: 4px; border: 0;"><i class="fa-solid fa-xmark" style="color: #e3bd74;"></i></button>`;

                    allButton += infoButton;
                    allButton += cancelButton;
                    return allButton;
                }
            }
        ]
    });
});