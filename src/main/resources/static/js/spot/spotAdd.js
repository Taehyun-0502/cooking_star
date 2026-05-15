/**
 * 
 */

const spotBtns = document.querySelectorAll(".spotBtn");

spotBtns.forEach((btn) => {
    btn.addEventListener("click", () => {

        const form = new FormData();

        form.append("placeName", btn.dataset.placeName);
        form.append("addressName", btn.dataset.addressName);
        form.append("phone", btn.dataset.phone);
        form.append("placeUrl", btn.dataset.url);

        fetch("/spot/add", {
            method: "POST",
            body: form
        })
        .then(response => response.text())
        .then(result => {
            if (result > 0) {
                alert("내 맛집 리스트에 추가되었습니다.");

                btn.innerText = "이미 추가됨";
                btn.disabled = true;
                btn.classList.remove("btn-primary");
                btn.classList.add("btn-secondary");
                btn.classList.remove("spotBtn");
            } else {
                alert("추가에 실패했습니다.");
            }
        });
    });
});

