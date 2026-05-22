document.addEventListener("DOMContentLoaded", () => {
    const form = document.querySelector('form[action$="/message/create"]');

    if (!form) {
        return;
    }

    form.addEventListener("submit", async (event) => {
        event.preventDefault();

        if (!form.reportValidity()) {
            return;
        }

        const action = form.getAttribute("action");
        const contextPath = action.replace(/\/message\/create$/, "");

        try {
            const response = await fetch(action, {
                method: "POST",
                body: new FormData(form),
                headers: {
                    "X-Requested-With": "XMLHttpRequest"
                }
            });

            if (!response.ok) {
                alert("문의 접수 중 오류가 발생했습니다.");
                return;
            }

            alert("문의가 접수되었습니다.");
            location.href = `${contextPath}/`;
        } catch (error) {
            alert("문의 접수 중 오류가 발생했습니다.");
        }
    });
});
