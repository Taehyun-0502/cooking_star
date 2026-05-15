<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<style>
.recipe-img {
	width: 250px;
	height: 250px;
	object-fit: cover;
	border-radius: 8px;
}
</style>

	<h1>디테일페이지</h1>

	<style>
.post-detail {
	max-width: 900px;
	margin: 40px auto;
	padding: 32px;
	border: 1px solid #e5e5e5;
	border-radius: 12px;
	background-color: #fff;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
	font-family: Arial, sans-serif;
}

.post-header {
	border-bottom: 1px solid #eee;
	padding-bottom: 20px;
	margin-bottom: 24px;
}

.post-title {
	font-size: 28px;
	font-weight: 700;
	margin-bottom: 12px;
	color: #222;
}

.post-meta {
	display: flex;
	gap: 16px;
	font-size: 14px;
	color: #777;
}

.post-section {
	margin-bottom: 32px;
}

.section-title {
	font-size: 18px;
	font-weight: 600;
	margin-bottom: 12px;
	color: #333;
	border-left: 4px solid #333;
	padding-left: 10px;
}

.post-content {
	font-size: 16px;
	line-height: 1.8;
	color: #333;
	white-space: pre-line;
}

.image-wrap {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
	gap: 16px;
}

.image-box {
	width: 100%;
	aspect-ratio: 1/1;
	overflow: hidden;
	border-radius: 10px;
	border: 1px solid #ddd;
	background-color: #f8f8f8;
}

.recipe-img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	display: block;
}

.empty-image {
	padding: 30px;
	text-align: center;
	color: #999;
	background-color: #f8f8f8;
	border-radius: 10px;
}

.post-actions {
	display: flex;
	justify-content: flex-end;
	gap: 8px;
	border-top: 1px solid #eee;
	padding-top: 20px;
}

.btn {
	padding: 8px 16px;
	border-radius: 6px;
	border: none;
	cursor: pointer;
	text-decoration: none;
	font-size: 14px;
}

.btn-list {
	background-color: #555;
	color: white;
}

.btn-update {
	background-color: #0d6efd;
	color: white;
}

.btn-delete {
	background-color: #dc3545;
	color: white;
}
</style>

	<article class="post-detail">

		<header class="post-header">
			<h1 class="post-title">
				글 제목 :
				<c:out value="${dto.cookingTitle}" />
			</h1>

			<div class="post-meta">
				<span>글번호: ${dto.cookingNum}</span> <span>작성일:
					${dto.cookingDate}</span> <span> 작성자: <a
					href="/member/user?username=${dto.username}" class="writer-link">
						<c:out value="${dto.username}" />
				</a>
				</span>
			</div>
		</header>

		<section class="post-section">
			<h2 class="section-title">요리 소개</h2>
			<div class="post-content">
				<c:out value="${dto.cookingContents}" />
			</div>
		</section>

		<section class="post-section">
			<h2 class="section-title">사진</h2>

			<c:choose>
				<c:when test="${not empty dto.list}">
				
					<div class="image-wrap">
						<c:forEach items="${dto.list}" var="file">
							<div class="image-box">
								<img class="recipe-img"
									src="${pageContext.request.contextPath}/files/${name}/${file.fileName}"
									alt="요리 이미지"> 
							</div>
						</c:forEach>
					</div>
				</c:when>

				<c:otherwise>
					<div class="empty-image">등록된 이미지가 없습니다.</div>
				</c:otherwise> 
			</c:choose>
		</section>

		<section class="post-section">
			<h2 class="section-title">참조 레시피</h2>
			<div class="post-content">
				<c:out value="${dto.cookingRecipe}" />
			</div>
		</section>

		<div class="post-actions">
			<a href="/" class="btn btn-list">목록</a> <a
				href="./update?cookingNum=${dto.cookingNum}" class="btn btn-update">수정</a>
			<!-- 삭제 버튼 시작 -->
			<form action="./delete" method="post"
				onsubmit="return confirm('정말 삭제하시겠습니까?');" style="display: inline;">
				<input type="hidden" name="cookingNum" value="${dto.cookingNum}">

				<c:if test="${not empty _csrf}">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}">
				</c:if>

				<button type="submit" class="btn btn-delete">삭제</button>
			</form>
		</div>

	</article>
	<%-- <a href="/myrecipe/update?recipeNum=${dto.recipeNum}"><button>수정</button></a>
		<a href="/myrecipe/allList"><button>리스트로 돌아가기</button></a>
		<button type="button" id="goodBtn" data-recipe-num="${dto.recipeNum}" >
		
		<c:choose>
			<c:when test="${isGood}">
				종아요 취소
			</c:when>
			
			<c:otherwise>
				좋아요
			</c:otherwise>
		
		</c:choose>
		
		</button> --%>

	<script src="/js/myRecipe/good.js"></script>
</body>
</html>