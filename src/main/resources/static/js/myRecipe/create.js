/**
 * 
 */
document.addEventListener("DOMContentLoaded", function() {
    const fileContainer = document.getElementById("file-container");//생성되는 파일 추가창 div태그
    const btnAddFile = document.getElementById("btn-add-file"); //파일추가버튼

    //파일 추가 버튼 클릭 이벤트
    btnAddFile.addEventListener("click", function() {
        // 현재 화면에 있는 .file-group(파일 입력란) 개수를 체크
        const currentFiles = fileContainer.querySelectorAll(".file-group").length;

        // 설계하셨던 최대 5개 제한 차단막
        if (currentFiles >= 5) {
            alert("첨부파일은 최대 5개까지만 추가 가능합니다.");
            return; 
        }

        // 새로운 파일 입력창 묶음(div) 생성
        const newFileGroup = document.createElement("div");
        newFileGroup.className = "d-flex align-items-center mb-2 file-group";

        // 태그 동적 삽입 (컨트롤러 파라미터와 맞추기 위해 name="attach" 필수)
        newFileGroup.innerHTML = `
            <input type="file" name="attach" class="form-control border-0 py-3 me-2">
            <button type="button" class="btn btn-danger btn-remove-file" style="padding: 10px 15px;">삭제</button>
        `;

        // div 태그 안에 안에 붙여넣기
        fileContainer.appendChild(newFileGroup);
    });

    // 2. 동적으로 생성된 삭제 버튼 클릭 이벤트
    fileContainer.addEventListener("click", function(e) {
        // 클릭된 요소가 삭제 버튼인지 확인
        if (e.target && e.target.classList.contains("btn-remove-file")) {
            // 가장 가까운 부모 줄(.file-group)을 찾아서 통째로 삭제
            e.target.closest(".file-group").remove();
        }
    });
});