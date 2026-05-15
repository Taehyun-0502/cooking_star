/**
 * 
 */

const spotBtns = document.querySelectorAll(".spotBtn");

spotBtns.forEach((btn) => {
    btn.addEventListener("click", () => {

        const placeName = btn.dataset.placeName;
        const addressName = btn.dataset.addressName;
        const phone = btn.dataset.phone;
        const url = btn.dataset.url;

        let form = new FormData();

        form.append("placeName",placeName)
        form.append("addressName",addressName)
         form.append("phone",phone)
         form.append("placeUrl",url)

         fetch("/spot/add",{
            method:"POST",
            body:form
         }).then(response=>response.text())
         .then(result=>{

            if(result>0){
                alert("맛집 리스트에 추가 되었습니다")

            }
            else{
                alert("추가에 실패 했습니다")
            }
         })



        console.log(placeName);
        console.log(addressName);
        console.log(phone);
        console.log(url);
    });
});

