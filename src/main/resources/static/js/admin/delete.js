document.addEventListener("DOMContentLoaded", () => {
	document.addEventListener("click", (e) => {
		const deleteBtn = e.target.closest(".btn-delete");

		if (deleteBtn == null) {
			return;
		}

		const recipeNum = deleteBtn.getAttribute("data-num");
		const formData = new URLSearchParams();
		formData.append("recipeNum", recipeNum);

		fetch("../myrecipe/deleteM", {
			method: "POST",
			headers: {
				"Content-Type": "application/x-www-form-urlencoded"
			},
			body: formData
		})
			.then((response) => {
				if (!response.ok) {
					throw new Error("delete fail");
				}

				return response.json();
			})
			.then((result) => {
				if (result > 0) {
					alert("\uC0AD\uC81C \uB418\uC5C8\uC2B5\uB2C8\uB2E4");
					location.reload();
					return;
				}

				if (result === -1) {
					location.href = "../member/login";
					return;
				}

				alert("\uC0AD\uC81C\uC5D0 \uC2E4\uD328\uD588\uC2B5\uB2C8\uB2E4");
			})
			.catch((error) => {
				console.error(error);
				alert("\uC0AD\uC81C\uC5D0 \uC2E4\uD328\uD588\uC2B5\uB2C8\uB2E4");
			});
	});
});
