$(document).ready(function(){
    $("body").on("click", ".open-modal-button", function(){
        console.log("clicked");
        $("#showJsonData").modal('show');
    });
});