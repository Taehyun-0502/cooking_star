/**
 * myrecipe/detail.jsp 하단에 스크립트(최근본 레시피 쿠키 저장용 js파일)
 */

document.addEventListener("DOMContentLoaded",function(){
	const usernameInput=document.getElementById("recentUsername")
	const recipeNumInput = document.getElementById("recentRecipeNum")
	
	if(usernameInput && recipeNumInput){
		const username=usernameInput.value
		const recipeNum=recipeNumInput.value
		
		if(username&&recipeNum){
			addRecentRecipe(username,recipeNum)
		}
	}
	
})
//쿠키만들기
function addRecentRecipe(username,recipeNum){
	const cookieName="recent_recipes_"+username
	
	let cookieValue=""
	const cookies=document.cookie.split(';')
	
	for(let i =0; i<cookies.length;i++){
		const c=cookies[i].trim()
		if(c.indexOf(cookieName+"=")==0){
			cookieValue=c.substring(cookieName.length+1,c.length)
			break
		}
	}
	// 2. 기존 번호들을 배열로 변환 (없으면 빈 배열)
	    let recipeArray = cookieValue ? cookieValue.split("/") : [];

	    // 3. 중복 제거: 방금 본 번호가 이미 배열에 있다면 싹 지움 (맨 앞으로 보내기 위함)
	    recipeArray = recipeArray.filter(num => num !== String(recipeNum));

	    // 4. 배열의 가장 첫 번째(맨 앞)에 현재 글 번호 추가
	    recipeArray.unshift(recipeNum);

	    // 5. 최근 본 레시피는 최대 4개까지만 저장
	    if (recipeArray.length > 4) {
	        recipeArray = recipeArray.slice(0, 4);
	    }

	    // 6. 다시 슬래시(/)로 묶어서 문자열로 변환 (예: "21/19/15")
	    const newCookieValue = recipeArray.join("/");

	    // 7. 쿠키 유효기간 설정 (7일)
	    const d = new Date();
	    d.setTime(d.getTime() + (7 * 24 * 60 * 60 * 1000));
	    const expires = "expires=" + d.toUTCString();

	    // 8. 최종 쿠키 굽기 (경로는 무조건 '/'로 설정해서 전체 페이지에서 접근 가능하게)
	    document.cookie = cookieName + "=" + newCookieValue + ";" + expires + ";path=/";
	    
	    console.log("최근 본 레시피 쿠키 저장 완료 -> ", newCookieValue);
	}
