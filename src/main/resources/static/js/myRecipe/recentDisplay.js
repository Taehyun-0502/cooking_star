/**
 * 인덱스에 뿌려줄 최근 본 레시피 목록 (인덱스에 스크립트)
 */

/**
 * 메인 페이지 최근 본 레시피 출력 시스템
 */
document.addEventListener("DOMContentLoaded", function() {
    const usernameInput = document.getElementById("mainUsername");
    if (!usernameInput) return; // 로그인 안 되어 있으면 중단

    const username = usernameInput.value;
    const cookieName = "recent_recipes_" + username;

    // 1. 쿠키 값 읽어오기
    let cookieValue = "";
    const cookies = document.cookie.split(';');
    for (let i = 0; i < cookies.length; i++) {
        const c = cookies[i].trim();
        if (c.indexOf(cookieName + "=") == 0) {
            cookieValue = c.substring(cookieName.length + 1, c.length);
            break;
        }
    }

    const container = document.getElementById("recentRecipeContainer");
    const noMessage = document.getElementById("noRecentMessage");

    // 2. 만약 쿠키가 비어있다면 안내 문구 띄우고 종료
    if (!cookieValue) {
        if (noMessage) noMessage.style.display = "block";
        return;
    }

    // 3. 쿠키 문자열("8/13/27")을 배열로 쪼개기
    const recipeNums = cookieValue.split("/");

    // 🌟 4. 스프링 컨트롤러에게 비동기(Fetch)로 데이터 요청하기
    // FormData를 사용해 List<Long>으로 매핑될 수 있도록 파라미터 구성
    const params = new URLSearchParams();
    recipeNums.forEach(num => params.append("recipeNums", num));

    fetch("/myrecipe/recentList", { // 🛑 질문자님의 컨트롤러 주소 구조에 맞게 조절하세요 (/myrecipe 뗌/붙임 체크)
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            // 스프링 시큐리티를 사용 중이라면 CSRF 토큰 처리가 필요할 수 있습니다. 
            // 만약 여기서 403 에러가 나면 시큐리티 설정을 확인하거나 헤더에 CSRF 토큰을 실어야 합니다.
        },
        body: params.toString()
    })
    .then(response => response.json())
    .then(data => {
        if (!data || data.length === 0) {
            if (noMessage) noMessage.style.display = "block";
            return;
        }

        // 5. 서버에서 받아온 레시피 목록 화면에 그리기
        let html = "";
        data.forEach(recipe => {
            // 이미지 파일이 없을 경우를 대비한 기본 이미지 설정
            let imgPath = ""; 
			if(recipe.recipeFileDTO[0].fileName == null){
				imgPath= "/files/mycooking/noimage.jpg"; 
			}
			
			
            if (recipe.recipeFileDTO && recipe.recipeFileDTO.length > 0 && recipe.recipeFileDTO[0].fileName) {
                // 기존 프로젝트 파일 업로드 경로 구조에 맞춰 수정하세요
                imgPath = "/files/myRecipe/" + recipe.recipeFileDTO[0].fileName; 
            }

            // 부트스트랩 카드 스타일로 레시피 나열 (기존 allList 디자인을 참고해서 다듬으셔도 좋습니다!)
            html += `
                <div class="col-md-3 col-sm-6">
                    <div class="card h-100 shadow-sm">
                        <img src="${imgPath}" class="card-img-top" alt="레시피 이미지" style="height: 180px; object-fit: cover;">
                        <div class="card-body">
                            <h5 class="card-title text-truncate">
                                <a href="/myrecipe/detail?recipeNum=${recipe.recipeNum}" class="text-dark text-decoration-none fw-bold">
                                    ${recipe.recipeTitle}
                                </a>
                            </h5>
                            <p class="card-text text-muted small">조회수 ${recipe.recipeHit || 0}</p>
                        </div>
                    </div>
                </div>
            `;
        });

        container.innerHTML = html;
    })
    .catch(error => {
        console.error("최근 본 레시피 로드 중 오류 발생:", error);
    });
});