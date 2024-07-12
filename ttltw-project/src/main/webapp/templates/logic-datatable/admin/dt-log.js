$(document).ready(function () {
    $('#logData').DataTable({
        scrollX: true,
        lengthMenu: [5, 10, 25, 100],
        processing: true,
        serverSide: true,
        ajax: {
            url: "http://localhost:8080/api/admin/log",
            type: "POST",
            dataType: "json",
            dataSrc: "items",
        },
        columns: [
            {data: "id"},
            {data: "ip"},
            {data: "national"},
            {data: "level"},
            {data: "address"},
            {data: "previousValue"},
            {data: "currentValue"},
            {data: "createdDate"},
            {data: "createdBy"},
            // Thiết lập cho cột Thao tác
            {sortable: false, searchable: false,}
        ],
        columnDefs: [
            {
                targets: [4, 5, 6],
                render: function (data, type, row, meta) {
                    const jsonObj = JSON.parse(data);
                    return `<pre style="white-space: pre-wrap; margin: 0;"><code class="json">${JSON.stringify(jsonObj, null, 2)}</code></pre>`
                }
            },
            {
                target: 9,
                render: function (data, type, row, meta) {
                    let allButton = '';
                    const deleteBtn = `<button onclick="deleteRecord(this, ${row.id}, 'log')" style="padding: 9px; margin-left: 4px;" data-bs-toggle="tooltip" title="Xóa ảnh" class="delete">
                        <i class="fa-solid fa-trash" style="color: #e3bd74;"></i></button>`;
                    allButton += deleteBtn;
                    return allButton;
                }
            }
        ]
    });
});