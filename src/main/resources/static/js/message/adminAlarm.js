document.addEventListener("DOMContentLoaded", () => {
    const contextPath = window.COOKING_STAR_CONTEXT_PATH || "";
    const badge = document.getElementById("messageAlarmBadge");

    if (!badge || typeof SockJS === "undefined" || typeof Stomp === "undefined") {
        return;
    }

    const updateBadge = (count) => {
        const unreadCount = Number(count || 0);
        badge.textContent = unreadCount > 99 ? "99+" : String(unreadCount);
        badge.classList.toggle("d-none", unreadCount <= 0);
    };

    const showToast = (alarm) => {
        const toast = document.createElement("div");
        toast.className = "toast show position-fixed bottom-0 end-0 m-4";
        toast.style.zIndex = "2000";
        toast.setAttribute("role", "alert");
        toast.innerHTML = `
            <div class="toast-header">
                <strong class="me-auto">새 문의가 도착했습니다</strong>
                <small>${alarm.createdAt || ""}</small>
                <button type="button" class="btn-close ms-2 mb-1" aria-label="Close"></button>
            </div>
            <div class="toast-body">
                <a class="fw-bold text-primary d-block mb-1" href="${contextPath}/message/detail?messageNum=${alarm.messageNum}">
                    ${escapeHtml(alarm.title || "제목 없음")}
                </a>
                <div class="small text-muted mb-1">${escapeHtml(alarm.writerName || "작성자 없음")}</div>
                <div>${escapeHtml(alarm.contentPreview || "")}</div>
            </div>
        `;

        toast.querySelector(".btn-close").addEventListener("click", () => toast.remove());
        document.body.appendChild(toast);
        setTimeout(() => toast.remove(), 8000);
    };

    const escapeHtml = (value) => {
        return String(value)
            .replaceAll("&", "&amp;")
            .replaceAll("<", "&lt;")
            .replaceAll(">", "&gt;")
            .replaceAll('"', "&quot;")
            .replaceAll("'", "&#039;");
    };

    fetch(`${contextPath}/message/alarm/count`, {
        headers: {
            "X-Requested-With": "XMLHttpRequest"
        }
    })
        .then((response) => response.ok ? response.json() : 0)
        .then(updateBadge)
        .catch(() => updateBadge(0));

    const socket = new SockJS(`${contextPath}/ws`);
    const stompClient = Stomp.over(socket);
    stompClient.debug = null;

    stompClient.connect({}, () => {
        stompClient.subscribe("/topic/admin/messages", (message) => {
            const alarm = JSON.parse(message.body);
            updateBadge(alarm.unreadCount);
            showToast(alarm);
        });
    });
});
