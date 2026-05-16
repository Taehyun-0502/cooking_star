document.addEventListener("DOMContentLoaded", () => {
    const recipesearch = document.getElementById("recipesearch");

    if (!recipesearch) {
        return;
    }

    const recipeSearchForm = recipesearch.closest("form");

    if (!recipeSearchForm) {
        return;
    }

    recipeSearchForm.addEventListener("submit", (e) => {
        const query = recipesearch.value.trim();

        if (query === "") {
            alert("검색어를 입력해주세요!");
            e.preventDefault();
            return;
        }

        if (!query.includes("레시피")) {
            alert("레시피 검색 시 'OOO 레시피'라고 검색해주세요!");
            e.preventDefault();
            recipesearch.value = "";
        }
    });
});
