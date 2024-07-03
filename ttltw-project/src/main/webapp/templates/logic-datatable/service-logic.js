function deleteRecord(buttonClicked, id, requestBy) {
    if (confirm("Bạn có muốn xóa record này không?")) {
        $.ajax({
            url: `http://localhost:8080/api/admin/delete-${requestBy}?id=${id}`,
            type: 'DELETE',
            dataType: 'json',
            success: function(response) {
                renderUi(buttonClicked, response);
            },
            error: function (error, xhr) {
                console.log(xhr.responseText)
            }
        });
    }
}

function renderUi(buttonClicked, response) {
    if (response) {
        const status = response["status"];
        const notify = response["notify"];

        if (status === "success") {
            buttonClicked.closest('tr').remove();
        }
        setTimeout(() => {
            alert(`${notify} Code: ${status}`);
        }, 100);
    }
}