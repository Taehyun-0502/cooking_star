/**
 * 
 */
$(document).ready(function() {
    $(".add-cart-btn").click(function() {
        const btn = $(this);
        const cardBody = btn.closest(".card-body");
        
        const productName = btn.data("name");
        const productPrice = btn.data("price");
        const productImg = btn.data("img");
        const productEa = cardBody.find(".product-ea").val();

        $.ajax({
            type: "POST",
            url: "./insert", 
            data: {
                productName: productName,
                productPrice: productPrice,
                productImg: productImg,
                productEa: productEa
            },
            success: function(result) {
                if(result == -1) {
                    alert("로그인이 필요한 서비스입니다.");
                    location.href = "/member/login"; 
                } else if(result > 0) {
                    if(confirm("장바구니에 담겼습니다. 장바구니로 이동하시겠습니까?")) {
                        location.href = "./list";
                    }
                } else {
                    alert("장바구니 담기에 실패했습니다.");
                }
            },
            error: function() {
                alert("서버 통신 중 오류가 발생했습니다.");
            }
        });
    });
});