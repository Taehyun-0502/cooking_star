document.addEventListener("DOMContentLoaded", () => {
    const resultDiv = document.getElementById("recipeResult");
    const query = resultDiv.dataset.query; // JSP에서 넘겨준 검색어 추출

    if (!query) {
        resultDiv.innerHTML = "<p>검색어가 없습니다.</p>";
        return;
    }

    let formData = new FormData();
    formData.append("query", query);

    // 실제 네이버 API 데이터를 가져오는 서버 컨트롤러 호출
    fetch("/search/blog", {
        method: "POST",
        body: formData
    })
    .then(r => r.json())
    .then(data => {
        let html = "";
        
        if (!data.items || data.items.length === 0) {
            resultDiv.innerHTML = "<div class='col-12 text-center py-5'>검색 결과가 없습니다.</div>";
            return;
        }

        data.items.forEach(item => {
            // HTML 태그 제거
            const cleanTitle = item.title.replace(/<[^>]*>?/g, '');
            const cleanDesc = item.description.replace(/<[^>]*>?/g, '');

            html += `
                <div class="col-md-6 col-lg-4">
                    <div class="card h-100 shadow-sm">
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title text-truncate">${cleanTitle}</h5>
                            <p class="card-text small text-muted text-overflow-3">${cleanDesc}</p>
                            <a href="${item.link}" target="_blank" class="btn btn-outline-primary mt-auto">블로그로 이동</a>
							
                        </div>
                    </div>
                </div>`;
        });
//저장버튼 만들어야할곳
        resultDiv.innerHTML = html;
    })
    .catch(err => {
        console.error(err);
        resultDiv.innerHTML = "<p class='text-center'>데이터 로딩 중 오류가 발생했습니다.</p>";
    });
});