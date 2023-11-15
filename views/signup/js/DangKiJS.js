// DangKiJS.js

document.addEventListener('DOMContentLoaded', function () {
    // Wait for the DOM to be fully loaded

    // Find the button element
    const registerButton = document.querySelector('button');

    // Add a click event listener to the button
    registerButton.addEventListener('click', function (event) {
        // Prevent the default form submission behavior
        event.preventDefault();
        console.log('Button clicked!');
        // Call your validateForm function when the button is clicked
        validateForm();
    });

    // Your other JavaScript code goes here...
});

function validateForm() {
    console.log('validateForm function called!');
    resetErrors();

    const fullName = document.querySelector('.form-input[placeholder="Họ và tên"]').value;
    const email = document.querySelector('.form-input[placeholder="Địa chỉ email"]').value;
    const password = document.querySelector('.form-input[placeholder="Mật khẩu"]').value;
    const password2 = document.querySelector('.form-input[placeholder="Nhập lại mật khẩu"]').value;

    if (fullName.trim() === '') {
        displayError('full_name_error', 'Họ và tên không được để trống');
        return;
    }

    if (!isValidFullName(fullName)) {
        displayError('full_name_error', 'Tên người dùng không tồn tại số');
        return;
    }
    if (email.trim() === '') {
        displayError('email_error', 'Địa chỉ email không được để trống');
        return;
    }
    // Validate Email
    if (!isValidEmail(email)) {
        displayError('email_error', 'Địa chỉ email không hợp lệ');
        return;
    }

    if (password.trim() === '') {
        displayError('password_error', 'Mật khẩu không được để trống');
        return;
    }
// Validate Password (you might want to add more specific criteria)
    if (password.length < 5) {
        displayError('password_error', 'Mật khẩu có độ dài >5 kí tự');
        return;
    }
    if (password2.trim() === '') {
        displayError('password2_error', 'Nhập lại mật khẩu không được để trống');
        return;
    }


    if (password !== password2) {
        displayError('password2_error', 'Không đúng! Nhập lại mật khẩu');
        return;
    }
    console.log('   ');
}

function resetErrors() {
    // Reset all error messages
    const errorElements = document.querySelectorAll('.error-message');
    errorElements.forEach((element) => {
        element.textContent = '';
    });
}

function isValidFullName(name) {
    // Check if the name contains any numbers
    return !/\d/.test(name);
}

function isValidEmail(email) {
    // Very basic email validation, you might want to use a regex or a library for a more robust check
    return /\S+@\S+\.\S+/.test(email);
}

function displayError(id, message) {
    const errorElement = document.getElementById(id);
    if (errorElement) {
        errorElement.textContent = message;
        errorElement.style.color = 'gray';
    } else {
        console.error(`Error element with ID ${id} not found.`);
    }
}
function togglePassword(inputId) {
    const passwordInput = document.getElementById(inputId);
    const toggleButton = document.getElementById(`toggle${inputId}`);

    if (passwordInput.type === 'password') {
        passwordInput.type = 'text';
       // toggleButton.classList.add('fa-eye-slash');
    } else {
        passwordInput.type = 'password';
        //toggleButton.classList.remove('fa-eye-slash');
    }
}

