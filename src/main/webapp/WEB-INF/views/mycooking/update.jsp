<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>요리 자랑 수정</title>

<style>
.update-container {
	max-width: 900px;
	margin: 40px auto;
	padding: 32px;
	border: 1px solid #e5e5e5;
	border-radius: 12px;
	background-color: #fff;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
	font-family: Arial, sans-serif;
}

.update-title {
	font-size: 28px;
	font-weight: 700;
	margin-bottom: 24px;
	border-bottom: 1px solid #eee;
	padding-bottom: 16px;
}

.form-group {
	margin-bottom: 24px;
}

.form-group label {
	display: block;
	font-weight: 600;
	margin-bottom: 8px;
	color: #333;
}

.form-control {
	width: 100%;
	box-sizing: border-box;
	padding: 12px;
	border: 1px solid #ddd;
	border-radius: 8px;
	font-size: 15px;
}

textarea.form-control {
	min-height: 160px;
	resize: vertical;
	line-height: 1.6;
}

.image-list {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
	gap: 16px;
	margin-top: 12px;
}

.image-item {
	border: 1px solid #ddd;
	border-radius: 10px;
	padding: 10px;
	background-color: #fafafa;
}

.image-box {
	width: 100%;
	aspect-ratio: 1/1;
	overflow: hidden;
	border-radius: 8px;
	background-color: #eee;
	margin-bottom: 8px;
}

.recipe-img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	display: block;
}

.delete-check {
	display: flex;
	align-items: center;
	gap: 6px;
	font-size: 14px;
	color: #555;
}

.empty-file {
	padding: 20px;
	color: #999;
	background-color: #f8f8f8;
	border-radius: 8px;
	text-align: center;
}

.button-area {
	display: flex;
	justify-content: flex-end;
	gap: 8px;
	margin-top: 32px;
	border-top: 1px solid #eee;
	padding-top: 20px;
}

.btn {
	padding: 10px 18px;
	border-radius: 6px;
	border: none;
	cursor: pointer;
	text-decoration: none;
	font-size: 14px;
}

.btn-submit {
	background-color: #0d6efd;
	color: #fff;
}

.btn-list {
	background-color: #555;
	color: #fff;
}

.btn-detail {
	background-color: #6c757d;
	color: #fff;
}
</style>
</head>

<body>

	<div class="update-container">

		<h1 class="update-title">요리 자랑 수정</h1>

		<form action="./update" method="post" enctype="multipart/form-data">

			<!-- 글 번호 -->
			<input type="hidden" name="cookingNum" value="${dto.cookingNum}">

			<div class="form-group">
				<label for="cookingTitle">제목</label> <input type="text"
					id="cookingTitle" name="cookingTitle" class="form-control"
					value="${dto.cookingTitle}" required>
			</div>

			<div class="form-group">
				<label for="cookingContents">요리 소개</label>
				<textarea id="cookingContents" name="cookingContents"
					class="form-control" required>${dto.cookingContents}</textarea>
			</div>

			<div class="form-group">
				<label for="cookingRecipe">참조 레시피</label>
				<textarea id="cookingRecipe" name="cookingRecipe"
					class="form-control">${dto.cookingRecipe}</textarea>
			</div>

			<div class="form-group">
				<label>기존 이미지</label>

				<c:choose>
    <c:when test="${not empty dto.list}">
        <div class="image-list">
            <c:forEach items="${dto.list}" var="file">
                <div class="image-item">

                    <div class="image-box">
                        <img class="recipe-img"
                             src="${pageContext.request.contextPath}/files/${name}/${file.fileName}"
                             alt="요리 이미지">
                    </div>

                    <label class="delete-check">
                        <input type="checkbox"
                               class="delete-file-check"
                               name="deleteFileNums"
                               value="${file.fileNum}">
                        이 이미지 삭제
                    </label>

                </div>
            </c:forEach>
        </div>
    </c:when>

    <c:otherwise>
        <div class="empty-file">
            등록된 이미지가 없습니다.
        </div>
    </c:otherwise>
</c:choose>
			</div>

			<div class="form-group">
				<label>새 이미지 추가</label>

				<div id="new-file-area">
					<!-- 이미지 추가 버튼을 누르면 input이 여기에 생성됨 -->
				</div>

				<button type="button" id="add-file-btn" class="btn btn-detail"
					style="margin-top: 10px;">이미지 추가</button>

				<div id="file-count-message"
					style="margin-top: 8px; color: #666; font-size: 14px;">최대
					5장까지 등록할 수 있습니다.</div>
			</div>

			<div class="button-area">
				<a href="/" class="btn btn-list">목록</a> <a
					href="./detail?cookingNum=${dto.cookingNum}" class="btn btn-detail">취소</a>

				<button type="submit" class="btn btn-submit">수정 완료</button>
			</div>

		</form>

	</div>
	<script src="/js/mycooking/updateFileCreate.js"></script>
	<c:if test="${not empty errorMessage}">
    <script>
        alert("${errorMessage}");
    </script>
</c:if>

</body>
</html>