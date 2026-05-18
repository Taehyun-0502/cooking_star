document.addEventListener("DOMContentLoaded", function() {
    
    document.querySelectorAll('.btn-delete').forEach(button => {
        button.addEventListener('click', function() {
            
            const recipeNum = this.getAttribute('data-num');

            if (confirm(recipeNum + "번 레시피를 정말 삭제하시겠습니까?")) {
                
                const formData = new URLSearchParams();
                formData.append('recipeNum', recipeNum);

                // 서버로 비동기 요청 시작
                fetch('./delete', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: formData
                })
                .then(response => {
                    // 서버가 500 에러를 던지면 여기서 먼저 잡아냅니다.
                    if (!response.ok) {
                        throw new Error("서버에서 에러가 발생했습니다. 상태코드: " + response.status);
                    }
                    return response.json(); // 정상적일 때만 JSON 변환
                })
                .then(result => {
                    // ★ 변수 선언 영역 (이 구역 안에서 result를 안전하게 사용합니다)
                    if (result > 0) {
                        alert("삭제되었습니다.");
                        location.href = "./myList"; 
                    } else if (result === -1) {
                        alert("로그인이 필요합니다.");
                        location.href = "/member/login"; 
                    } else {
                        alert("삭제 실패했습니다. (본인 글이 아니거나 존재하지 않는 글입니다.)");
                    }
                })
                .catch(error => {
                    // 500 에러나 자바스크립트 문법 에러는 모두 이쪽으로 떨어집니다.
                    console.error("에러 상세 발생:", error);
                    alert("삭제 처리 중 문제가 발생했습니다. 서버 콘솔을 확인하세요.");
                });
            }
        });
    });
    
});