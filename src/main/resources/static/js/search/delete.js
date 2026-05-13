/**
 * 
 */

const listBtn = document.getElementsByClassName("linkBtn")

for(let d of listBtn){
	
	d.addEventListener("click",()=>{
	
		const num=d.getAttribute("data-num")
		
		let form = new FormData();
		console.log(num)	
		
		
		form.append("searchNum",num)
		
		fetch("/search/delete",{
			method:"POST",
			body:form
		}).then(r=>r.text())
		.then(r=>{
			if(r>0){
				alert("삭제 성공")
				/* 리다이렉트 또는 ajax를 이용해서 리스트 다시보기*/
			}
		})
		
		
	})
	
}


