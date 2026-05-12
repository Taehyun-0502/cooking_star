const recipebtn = document.getElementById("recipebtn");
const recipesearch = document.getElementById("recipesearch");

// 폼 자체가 전송될 때 체크하고 싶다면 form에 이벤트를 겁니다.
document.querySelector("form").addEventListener("submit", (e) => {
    if (recipesearch.value.trim() === "") {
        alert("검색어를 입력해주세요!");
        e.preventDefault(); // 검색어가 없으면 페이지 이동을 막음
    }
});