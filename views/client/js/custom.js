(function () {
    'use strict';

    var tinyslider = function () {
        var el = document.querySelectorAll('.testimonial-slider');

        if (el.length > 0) {
            var slider = tns({
                container: '.testimonial-slider',
                items: 1,
                axis: "horizontal",
                controlsContainer: "#testimonial-nav",
                swipeAngle: false,
                speed: 700,
                nav: true,
                controls: true,
                autoplay: true,
                autoplayHoverPause: true,
                autoplayTimeout: 3500,
                autoplayButtonOutput: false
            });
        }
    };
    tinyslider();


    var sitePlusMinus = function () {

        var value,
            quantity = document.getElementsByClassName('quantity-container');

        function createBindings(quantityContainer) {
            var quantityAmount = quantityContainer.getElementsByClassName('quantity-amount')[0];
            var increase = quantityContainer.getElementsByClassName('increase')[0];
            var decrease = quantityContainer.getElementsByClassName('decrease')[0];
            increase.addEventListener('click', function (e) {
                increaseValue(e, quantityAmount);
            });
            decrease.addEventListener('click', function (e) {
                decreaseValue(e, quantityAmount);
            });
        }

        function init() {
            for (var i = 0; i < quantity.length; i++) {
                createBindings(quantity[i]);
            }
        };

        function increaseValue(event, quantityAmount) {
            value = parseInt(quantityAmount.value, 10);

            console.log(quantityAmount, quantityAmount.value);

            value = isNaN(value) ? 0 : value;
            value++;
            quantityAmount.value = value;
        }

        function decreaseValue(event, quantityAmount) {
            value = parseInt(quantityAmount.value, 10);

            value = isNaN(value) ? 0 : value;
            if (value > 0) value--;

            quantityAmount.value = value;
        }

        init();

    };
    sitePlusMinus();
})()

// Thay đổi tiêu đề
let p_tag = document.getElementById("mxh-changing");
let maxWidth = 768;

function checkScreen() {
    if (window.innerWidth <= maxWidth) {
        p_tag.textContent = "MXH";
    }
    else {
        p_tag.textContent = "Mạng xã hội";
    }
}
checkScreen();
window.addEventListener("resize", checkScreen);

let button = document.getElementById("scroll-to-top");
// Scroll to top
window.onscroll = function scrollToTop() {
    (document.body.scrollTop > 150 || document.documentElement.scrollTop > 150) ? (button.style.display = "block") : (button.style.display = "none");
}
button.addEventListener("click", function () {
    document.body.scrollTop = 0;
    document.documentElement.scrollTop = 0;
});
