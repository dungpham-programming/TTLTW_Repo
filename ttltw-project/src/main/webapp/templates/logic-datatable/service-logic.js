function deleteRecord(buttonClicked, id, requestBy) {
    if (confirm("Bạn có muốn xóa record này không?")) {
        $.ajax({
            url: `http://localhost:8080/api/admin/${requestBy}?id=${id}`,
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

const deleteRecordByClient = (buttonClicked, id, requestBy) => {
    if (confirm("Bạn có muốn xóa record không?")) {
        $.ajax({
            url: `http://localhost:8080/api/client/${requestBy}?id=${id}`,
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