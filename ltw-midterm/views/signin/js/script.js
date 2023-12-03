function checking() {
    // Lấy giá trị của email và password
    var email = document.getElementById("emailInput").value;
    var password = document.getElementById("passwordInput").value;

    // Xóa bất kỳ thông báo lỗi cũ nào
    document.getElementById("emailError").textContent = "";
    document.getElementById("passwordError").textContent = "";

    // Kiểm tra tính hợp lệ của email và password
    if (!isValidEmail(email) && email !== "") {
        document.getElementById("emailError").textContent = "Email không hợp lệ.";
        document.getElementById("emailInput").style.borderColor = "red";
    }

    if (!isValidPassword(password) && password !== "") {
        document.getElementById("passwordError").textContent = "Mật khẩu có ít nhất 6 ký tự.";
        document.getElementById("passwordInput").style.borderColor = "red";
    }
}

// Hàm kiểm tra tính hợp lệ của email
function isValidEmail(email) {
    // Sử dụng biểu thức chính quy để kiểm tra tính hợp lệ
    var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailPattern.test(email);
}

// Hàm kiểm tra tính hợp lệ của password
function isValidPassword(password) {
    return password.length >= 6;
}
