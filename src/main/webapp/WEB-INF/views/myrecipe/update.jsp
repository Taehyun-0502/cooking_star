<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar.jsp" />

<div class="container-fluid page-header py-5">
	<h1 class="text-center text-white display-6">레시피 수정</h1>
	<ol class="breadcrumb justify-content-center mb-0">
		<li class="breadcrumb-item"><a
			href="${pageContext.request.contextPath}/">Home</a></li>
		<li class="breadcrumb-item"><a
			href="${pageContext.request.contextPath}/myrecipe/allList">Recipes</a></li>
		<li class="breadcrumb-item active text-white">Update</li>
	</ol>
</div>
<div class="container-fluid contact py-5">
	<div class="container py-5">
		<div class="p-5 bg-light rounded">
			<div class="row g-4">
				<div class="col-12 text-center mx-auto" style="max-width: 700px;">
					<h1 class="text-primary">레시피 수정하기</h1>

				</div>
				<div class="col-lg-7 mx-auto">
					<form action="/myrecipe/update" method="post"
						enctype="multipart/form-data">
						<!-- 파일삭제버튼 클릭시 db에서 삭제되기전에 변수에담아 컨트롤러로 넘겨줌(로컬에서도 삭제하기위해) -->
						<input type="hidden" name="recipeNum" value="${dto.recipeNum}">

						<div class="mb-3">
							<label class="form-label">제목</label> <input type="text"
								name="recipeTitle" value="${dto.recipeTitle}"
								class="w-100 form-control border-0 py-3 mb-4">
						</div>
						<div class="mb-3">
							<label class="form-label">요리 종류 (카테고리)</label> <select
								name="recipeCategory"
								class="w-100 form-select border-0 py-3 mb-4"
								style="background-color: #fff;">
								<option value="" disabled>요리 종류를 선택해 주세요</option>
								<option value="한식"
									${dto.recipeCategory == '한식' ? 'selected' : ''}>한식</option>
								<option value="중식"
									${dto.recipeCategory == '중식' ? 'selected' : ''}>중식</option>
								<option value="일식"
									${dto.recipeCategory == '일식' ? 'selected' : ''}>일식</option>
								<option value="양식"
									${dto.recipeCategory == '양식' ? 'selected' : ''}>양식</option>
								<option value="디저트"
									${dto.recipeCategory == '디저트' ? 'selected' : ''}>디저트</option>
								<option value="기타"
									${dto.recipeCategory == '기타' ? 'selected' : ''}>기타/퓨전</option>
							</select>
						</div>

						<div class="mb-3">
							<label class="form-label">재료 목록</label> <input type="text"
								name="recipeBase" class="w-100 form-control border-0 py-3 mb-4"
								value="${dto.recipeBase}">
						</div>
						<div class="mb-3">
							<label class="form-label">요리방법</label>
							<textarea name="recipeContents"
								class="w-100 form-control border-0 py-3 mb-4" rows="10"
								style="resize: none;">${dto.recipeContents}</textarea>
						</div>

						<div class="mb-4">
							<div
								class="d-flex justify-content-between align-items-center mb-2">
								<label class="form-label mb-0">요리 사진 관리 (기존+신규 최대 5개)</label>
								<button type="button" id="btn-add-file"
									class="btn btn-sm btn-secondary">
									<i class="fas fa-plus"></i> 새 파일 추가
								</button>
							</div>

							<div id="existing-file-container" class="mb-3">
								<c:if
									test="${not empty dto.recipeFileDTO and not empty dto.recipeFileDTO[0].fileName}">
									<p class="text-muted small mb-1">기존 파일 (삭제하려면 [X]를 누르세요)</p>
									<div class="row g-2 mb-3">
										<c:forEach items="${dto.recipeFileDTO}" var="fileDTO">
											<div class="col-md-4 col-sm-6 existing-file-group">
												<div
													class="position-relative border rounded overflow-hidden bg-white text-center p-2"
													style="height: 120px;">
													<img
														src="${pageContext.request.contextPath}/files/${name}/${fileDTO.fileName}"
														class="img-fluid h-100" style="object-fit: cover;"
														alt="${fileDTO.oriName}">
													<button type="button"
														class="btn btn-danger btn-sm btn-delete-existing position-absolute top-0 end-0 m-1"
														data-file-num="${fileDTO.fileNum}">✕</button>
												</div>
											</div>
										</c:forEach>
									</div>
								</c:if>
							</div>

							<div id="delete-file-nums-hidden"></div>

							<div id="file-container"></div>
						</div>

						<div class="d-flex gap-2">
							<button type="submit"
								class="w-100 btn form-control border-secondary py-3 bg-white text-primary">수정
								완료</button>
							<a href="/myrecipe/detail?recipeNum=${dto.recipeNum}"
								class="w-100 btn form-control border-secondary py-3 bg-white text-secondary text-center">취소</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="${pageContext.request.contextPath}/js/myRecipe/update.js"></script>
<jsp:include page="../common/footer.jsp" />
<jsp:include page="../common/scripts.jsp" />