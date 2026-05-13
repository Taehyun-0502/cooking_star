/**
 * 
 */
const followBtn = document.getElementById("followBtn")


followBtn.addEventListener("click", () => {

    console.log("이벤트 작동")
    const followingUsername = followBtn.getAttribute("data-user")

    const isFollow = followBtn.getAttribute("data-follow");

    const form = new FormData();

    form.append("followingUser", followingUsername)

    let url = ""

    if (isFollow == "1") {
        url = "/follow/unFollowing"
    }
    if (isFollow == "0") {
        url = "/follow/following"
    }

    fetch(url, {
        method: "POST",
        body: form
    }).then(r => r.text())
        .then(r => {
            if (r > 0) {
                if (isFollow == "1") {
                    alert("언팔로우 되었습니다");
                    followBtn.innerText = "팔로우";
                    followBtn.setAttribute("data-follow", "0");
                } else {
                    alert("팔로우 되었습니다");
                    followBtn.innerText = "언팔로우";
                    followBtn.setAttribute("data-follow", "1");
                }
            } else {
                alert("처리 실패");
            }
        });

});



