const clientKey ='test_ck_6bJXmgo28ewL0npojYKEVLAnGKWx';
const tossPayments = TossPayments(clientKey);

$(document).ready(function() {

    // 1. 수량 변경 시 실시간 업데이트 (fetch 방식)
    $(".product-ea").on("change", async function() {
        const input = $(this);
        const card = input.closest(".product-card");
        const cartNum = card.find(".delete-btn").data("num");
        const productEa = parseInt(input.val(), 10) || 1;

        if (productEa < 1) {
            alert("최소 수량은 1개입니다.");
            input.val(1);
            return;
        }

        try {
            // fetch는 기본적으로 에러가 발생해도 catch로 바로 가지 않으므로 응답 확인이 필요합니다.
            const response = await fetch("./updateEa", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded",
                },
                body: new URLSearchParams({
                    cartNum: cartNum,
                    productEa: productEa
                })
            });

			if (!response.ok) {
			    throw new Error("네트워크 응답에 문제가 있습니다.");
			}

            const result = await response.json(); // 서버에서 리턴한 int 값

            if (result > 0) {
                const price = parseInt(card.find(".price-value").data("price")) || 0;
                const subtotal = price * productEa;
                
                card.find(".product-subtotal").text(subtotal.toLocaleString('ko-KR') + "원");
                updateTotalLayout();
            }
        } catch (error) {
            console.error("수량 업데이트 실패:", error);
            alert("수량 변경 중 오류가 발생했습니다.");
        }
    });

    // 2. 삭제 버튼 클릭 시 즉시 삭제 (fetch 방식)
    $(".delete-btn").on("click", async function() {
        if (!confirm("정말 삭제하시겠습니까?")) return;

        const btn = $(this);
        const cartNum = btn.data("num");
        const card = btn.closest(".product-card"); // .card에서 .product-card로 수정

        try {
            const response = await fetch("./delete", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded",
                },
                body: new URLSearchParams({ cartNum: cartNum })
            });

            if (!response.ok) throw new Error("삭제 요청 실패");

            const result = await response.json();

            if (result > 0) {
                // 삭제 효과 추가 (선택)
                card.fadeOut(300, function() {
                    $(this).remove();
                    updateTotalLayout();
                });
            }
        } catch (error) {
            console.error("삭제 실패:", error);
            alert("삭제 중 오류가 발생했습니다.");
        }
    });

    // 3. 화면의 총 결제 금액을 다시 계산하는 함수 (이 부분은 동일)
    function updateTotalLayout() {
        let total = 0;
        $(".product-card").each(function() {
            const price = parseInt($(this).find(".price-value").data("price")) || 0;
            const ea = parseInt($(this).find(".product-ea").val()) || 0;
            total += (price * ea);
        });

        const formattedTotal = total.toLocaleString('ko-KR') + "원";
        $("#total-price-display").text(formattedTotal);
        $("#final-price-display").text(formattedTotal);
    }
	
	
	//결제하기 >>토스연동
	$("#payment-btn").on("click", function() {
	    // .text()를 하면 "15,000원"이라는 글자가 통째로 옵니다.
	    // replace(/[^0-9]/g, '')는 숫자(0-9)가 아닌 모든 것(쉼표, '원')을 빈칸으로 바꿔버립니다.
	    const totalAmountText = $("#final-price-display").text();
	    const totalAmount = parseInt(totalAmountText.replace(/[^0-9]/g, '')) || 0;

	    console.log("최종 결제 금액:", totalAmount);

	    if (totalAmount <= 0) {
	        alert("결제할 상품이 없습니다.");
	        return;
	    }

	    // 토스 결제창 호출 로직 실행...
	    tossPayments.requestPayment('카드', {
	        amount: totalAmount,
	        orderId: 'ORDER_' + new Date().getTime(),
	        orderName: '장바구니 상품 결제',
	        // ... 나머지 정보들
	    });
	});
});