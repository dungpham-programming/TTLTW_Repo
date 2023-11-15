document.querySelector(".login").addEventListener("click", function() {
    // Lấy giá trị của email
    var email = document.getElementById("emailInput").value;

    // Xóa bất kỳ thông báo lỗi cũ nào
    document.getElementById("emailError").textContent = "";

    // Kiểm tra tính hợp lệ của email và password
    if (!isValidEmail(email)) {
        document.getElementById("emailError").textContent = "Email không đúng.";
        document.getElementById("emailInput").style.borderColor = "red";
    }
});

// Hàm kiểm tra tính hợp lệ của email
function isValidEmail(email) {
    // Sử dụng biểu thức chính quy để kiểm tra tính hợp lệ
    var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailPattern.test(email);
}
