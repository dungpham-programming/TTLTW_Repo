
function check() {
    // Lấy giá trị của mật khẩu cũ, mật khẩu mới và nhập lại mật khẩu mới
    var password1 = document.getElementById("passwordInput1").value;
    var password2 = document.getElementById("passwordInput2").value;
    var password3 = document.getElementById("passwordInput3").value;

    // Xóa bất kỳ thông báo lỗi cũ nào
    document.getElementById("passwordError1").textContent = "";
    document.getElementById("passwordError2").textContent = "";
    document.getElementById("passwordError3").textContent = "";

    // Kiểm tra tính hợp lệ của mật khẩu cũ
    if (password1 === password2 && password1 !== "" && password2 !== "") {
        document.getElementById("passwordError1").textContent = "Mật khẩu mới trùng với mật khẩu cũ.";
        document.getElementById("passwordInput1").style.borderColor = "red";
    }

    // Kiểm tra tính hợp lệ của mật khẩu mới
    if (!isValidPassword(password2) && password2 !== "") {
        document.getElementById("passwordError2").textContent = "Mật khẩu mới phải có ít nhất 6 kí tự.";
        document.getElementById("passwordInput2").style.borderColor = "red";
    }

    // Kiểm tra xem mật khẩu mới có trùng với nhập lại mật khẩu mới hay không
    if (password2 !== password3 && password2 !== "" && password3 !== "") {
        document.getElementById("passwordError3").textContent = "Mật khẩu mới và nhập lại mật khẩu không trùng khớp.";
        document.getElementById("passwordInput2").style.borderColor = "red";
        document.getElementById("passwordInput3").style.borderColor = "red";
    }
}

    // Hàm kiểm tra tính hợp lệ của password
    function isValidPassword(password) {
    return password.length >= 6;
}

