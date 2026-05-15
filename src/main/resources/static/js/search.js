const recipebtn = document.getElementById("recipebtn");
const recipesearch = document.getElementById("recipesearch");

// 폼 자체가 전송될 때 체크하고 싶다면 form에 이벤트를 겁니다.
document.querySelector("form").addEventListener("submit", (e) => {
	
	const query = recipesearch.value.trim();
	
    if (recipesearch.value.trim() === "") {
        alert("검색어를 입력해주세요!");
        e.preventDefault(); // 검색어가 없으면 페이지 이동을 막음
		return
    }
	
	if (!query.includes("레시피")) {
	        alert("레시피 검색 시 'OOO 레시피'라고 검색해주세요!");
	        e.preventDefault(); // 서버 전송 막기
	        
	        //입력창 비우기
	        recipesearch.value = "";
	       
	    }
});