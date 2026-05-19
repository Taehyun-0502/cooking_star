/**
 * 
 */
document.addEventListener("DOMContentLoaded", function () {
    const goodBtn = document.getElementById("goodBtn");
    const goodCount = document.getElementById("goodCount");

    // 화면에 좋아요 버튼이 존재할 때만 실행
    if (goodBtn) {
        goodBtn.addEventListener("click", function () {
            // JSP 버튼에 심어둔 data-cooking-num 값을 가져옵니다.
            const cookingNum = goodBtn.getAttribute("data-cooking-num");

            // 스프링 시큐리티 CSRF 토큰 대응 (필요한 경우)
            const csrfToken = document.querySelector("meta[name='_csrf']")?.getAttribute("content");
            const csrfHeader = document.querySelector("meta[name='_csrf_header']")?.getAttribute("content");

            const headers = {
                'Content-Type': 'application/x-www-form-urlencoded'
            };
            if (csrfToken && csrfHeader) {
                headers[csrfHeader] = csrfToken;
            }

            // 🌟 우리가 만든 컨트롤러 주소로 비동기(Fetch) 요청 전달!
            fetch("/mycooking/good", {
                method: "POST",
                headers: headers,
                body: new URLSearchParams({ cookingNum: cookingNum })
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error("로그인이 필요하거나 서버 에러가 발생했습니다.");
                }
                return response.json(); // 서버가 준 CookingGoodResponseDTO 상자 열기
            })
            .then(data => {
                // data 안에는 { good: true/false, goodCount: 숫자 } 가 들어있습니다.
                
                const icon = goodBtn.querySelector("i");
                const text = goodBtn.querySelector("span");

                if (data.good) {
                    // 좋아요 등록 상태인 경우 👉 빨간 하트 채우기
                    goodBtn.classList.remove("btn-outline-danger");
                    goodBtn.classList.add("btn-danger");
                    icon.classList.remove("far");
                    icon.classList.add("fas");
                    text.textContent = "좋아요 취소";
                } else {
                    // 좋아요 취소 상태인 경우 👉 빈 하트 만들기
                    goodBtn.classList.remove("btn-danger");
                    goodBtn.classList.add("btn-outline-danger");
                    icon.classList.remove("fas");
                    icon.classList.add("far");
                    text.textContent = "좋아요";
                }

                // 🌟 서버가 준 정확한 최신 카운트로 화면 숫자 갱신!
                goodCount.textContent = data.goodCount;
            })
            .catch(error => {
                console.error("Error:", error);
                alert("좋아요 처리에 실패했습니다. 로그인을 확인해 주세요.");
            });
        });
    }
});