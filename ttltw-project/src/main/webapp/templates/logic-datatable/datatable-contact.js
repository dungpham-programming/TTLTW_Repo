$(document).ready(function (){
    $('#contactData').DataTable({
        lengthMenu: [5, 10, 25, 100],
        processing: true,
        serverSide: true,
        ajax: {
            url: "http://localhost:8080/api/admin/contact",
            type: "POST",
            dataType: "json",
            dataSrc: "items", // Dữ liệu cần lấy từ thuộc tính JSON, ở đây là items (Danh sách)
        },
        columns: [
            { data: "id" },
            { data: "email" },
            { data: "firstName" },
            { data: "lastName" },
            { data: "title" },
            { data: "message" },
            { data: "status" },
            { data: "createdDate" },
            { data: "createdBy" },
            { data: "modifiedDate" },
            { data: "modifiedBy" },
            // Thiết lập cho cột Thao tác
            { sortable: false, searchable: false, }
        ],
    });
});
