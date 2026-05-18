/**
 * 
 */
/**
 * 회원 정보 수정 및 프로필 관리 스크립트
 */

// 1. 파일 선택 시 화면에 즉시 이미지 미리보기
function previewImage(input) {
    if (input.files && input.files[0]) {
        const reader = new FileReader();
        
        reader.onload = function(e) {
            const preview = document.getElementById('profilePreview');
            const fallback = document.getElementById('profilePreviewFallback');
            
            // 미리보기 이미지 태그에 이미지 데이터 주입 및 출력
            if (preview) {
                preview.src = e.target.result;
                preview.classList.remove('d-none');
            }
            
            // 기본 아바타 아이콘 숨기기
            if (fallback) {
                fallback.classList.add('d-none');
            }
        };
        
        reader.readAsDataURL(input.files[0]);
    }
}

// 2. 폼 전송 전 유효성 검사 (필수 입력값 체크)
document.addEventListener("DOMContentLoaded", function() {
    const updateForm = document.getElementById("updateForm");
    
    if (updateForm) {
        updateForm.addEventListener("submit", function(e) {
            const nameInput = document.getElementById("name");
            const emailInput = document.getElementById("email");
            
            // 이름 입력 검증
            if (!nameInput.value.trim()) {
                alert("이름을 입력해주세요.");
                nameInput.focus();
                e.preventDefault(); // 폼 전송 막기
                return false;
            }
            
            // 이메일 입력 검증
            if (!emailInput.value.trim()) {
                alert("이메일을 입력해주세요.");
                emailInput.focus();
                e.preventDefault();
                return false;
            }
        });
    }
});