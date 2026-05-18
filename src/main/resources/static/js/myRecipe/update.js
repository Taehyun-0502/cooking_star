/**
 * 
 */
document.addEventListener("DOMContentLoaded", function() {
    const fileContainer = document.getElementById("file-container");
    const existingContainer = document.getElementById("existing-file-container");
    const deleteHiddenContainer = document.getElementById("delete-file-nums-hidden");
    const btnAddFile = document.getElementById("btn-add-file");

    // 1. [새 파일 추가] 버튼 클릭 이벤트
    btnAddFile.addEventListener("click", function() {
        // 현재 화면에 남아있는 기존 파일 이미지 개수 계산
        const existingCount = existingContainer ? existingContainer.querySelectorAll(".existing-file-group").length : 0;
        // 새로 추가하겠다고 만들어둔 파일 input창 개수 계산
        const newFileCount = fileContainer.querySelectorAll(".file-group").length;

        // ★ [기존 파일 수 + 신규 파일 수]가 5개를 넘지 못하게 방어벽 작동!
        if ((existingCount + newFileCount) >= 5) {
            alert("첨부파일은 기존 파일을 포함하여 최대 5개까지만 유지할 수 있습니다.");
            return;
        }

        // 새로운 파일 input 행 생성 (컨트롤러와 이름을 맞추기 위해 name="attach" 필수)
        const newFileGroup = document.createElement("div");
        newFileGroup.className = "d-flex align-items-center mb-2 file-group";
        newFileGroup.innerHTML = `
            <input type="file" name="attach" class="form-control border-0 py-3 me-2">
            <button type="button" class="btn btn-danger btn-remove-file" style="padding: 10px 15px;">삭제</button>
        `;

        fileContainer.appendChild(newFileGroup);
    });

    // 2. 신규 추가된 파일창 행 삭제 버튼 이벤트 (이벤트 위임)
    fileContainer.addEventListener("click", function(e) {
        if (e.target && e.target.classList.contains("btn-remove-file")) {
            e.target.closest(".file-group").remove();
        }
    });

    // 3. 🌟 기존 파일 우측 상단 [X] 버튼 클릭 시 동작 (화면에서 지우고 서버로 보낼 지울 파일 번호 수집)
    if (existingContainer) {
        existingContainer.addEventListener("click", function(e) {
            if (e.target && e.target.classList.contains("btn-delete-existing")) {
                if (confirm("이 사진을 정말 삭제하시겠습니까?\n(글 수정 완료 시 실제로 서버에서 삭제됩니다.)")) {
                    // 삭제 버튼에 심어둔 파일의 PK 번호(fileNum)를 추출합니다.
                    const fileNum = e.target.getAttribute("data-file-num");

                    // 컨트롤러가 수집할 수 있게 hidden 태그 생성: name="deleteFiles"
                    const hiddenInput = document.createElement("input");
                    hiddenInput.type = "hidden";
                    hiddenInput.name = "deleteFiles";
                    hiddenInput.value = fileNum;
                    deleteHiddenContainer.appendChild(hiddenInput);

                    // 화면에서도 해당 이미지 카드를 부드럽게 날려버립니다.
                    e.target.closest(".existing-file-group").remove();
                }
            }
        });
    }
});