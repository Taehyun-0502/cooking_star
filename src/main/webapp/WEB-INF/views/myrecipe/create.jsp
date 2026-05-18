<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar.jsp" />

<!-- Single Page Header start -->
<div class="container-fluid page-header py-5">
	<h1 class="text-center text-white display-6">레시피 작성</h1>
	<ol class="breadcrumb justify-content-center mb-0">
		<li class="breadcrumb-item"><a
			href="${pageContext.request.contextPath}/">Home</a></li>
		<li class="breadcrumb-item"><a
			href="${pageContext.request.contextPath}/myrecipe/allList">Recipes</a></li>
		<li class="breadcrumb-item active text-white">Create</li>
	</ol>
</div>
<!-- Single Page Header End -->

<!-- Create Recipe Start -->
<div class="container-fluid contact py-5">
	<div class="container py-5">
		<div class="p-5 bg-light rounded">
			<div class="row g-4">
				<div class="col-12 text-center mx-auto" style="max-width: 700px;">
					<h1 class="text-primary">새 레시피 등록</h1>
					<p class="mb-4">나만의 특별한 레시피를 공유해 보세요.</p>
				</div>
				<div class="col-lg-7 mx-auto">
					<form action="/myrecipe/create" method="post"
						enctype="multipart/form-data">
						<div class="mb-3">
							<label class="form-label">아이디</label> <input type="text" readonly
								value="<sec:authentication property='principal.username'/>"
								name="username"
								class="w-100 form-control border-0 py-3 mb-4 bg-white">
						</div>
						<div class="mb-3">
							<label class="form-label">제목</label> <input type="text" value="${dto.recipeTitle}"
								name="recipeTitle" class="w-100 form-control border-0 py-3 mb-4">
						</div>
						<div class="mb-3">
							<label class="form-label">내용</label>
							<textarea name="recipeContents"
								class="w-100 form-control border-0 py-3 mb-4" rows="10"
								style="resize: none;">${dto.recipeContents}</textarea>
						</div>

						<div class="mb-4">
							<div
								class="d-flex justify-content-between align-items-center mb-2">
								<label class="form-label mb-0">요리 사진 (최대 5개)</label>
								<button type="button" id="btn-add-file"
									class="btn btn-sm btn-secondary">
									<i class="fas fa-plus"></i> 파일 추가
								</button>
							</div>

							<div id="file-container">
								<div class="d-flex align-items-center mb-2 file-group">
									<input type="file" name="attach"
										class="form-control border-0 py-3 me-2">
								</div>
							</div>
						</div>

						<button type="submit"
							class="w-100 btn form-control border-secondary py-3 bg-white text-primary">저장</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Create Recipe End -->
<script src="/js/myRecipe/create.js"></script>
<c:if test="${not empty message}">
    <script>
        alert("${message}");
    </script>
</c:if>
<jsp:include page="../common/footer.jsp" />
<jsp:include page="../common/scripts.jsp" />