$(document).ready(function(){
    $("body").on("click", ".open-modal-button", function(){
        console.log("clicked");

        // Lấy dữ liệu từ data-send
        const data = $(this).attr("data-send");
        const jsonData = JSON.parse(data);
        $('.json-content').html(`<pre style="white-space: pre-wrap; margin: 0;"><code class="json">${JSON.stringify(jsonData, null, 2)}</code></pre>`)
        $("#showJsonData").modal('show');
    });
});