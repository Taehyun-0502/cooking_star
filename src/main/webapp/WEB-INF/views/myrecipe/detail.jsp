<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar.jsp" />

<div class="container-fluid page-header py-5" style="background: linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3)), url('/img/page-header.jpg') center center no-repeat; background-size: cover;">
	<h1 class="text-center text-white display-6">레시피 상세</h1>
	<ol class="breadcrumb justify-content-center mb-0">
		<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
		<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/myrecipe/allList">Recipes</a></li>
		<li class="breadcrumb-item active text-white">Detail</li>
	</ol>
</div>
<div class="container-fluid py-5 mt-4">
	<div class="container py-5">
		<div class="row g-5">
			
			<div class="col-lg-5">
				<div class="border rounded-4 overflow-hidden shadow-sm bg-white p-2">
					<c:choose>
						<c:when test="${not empty dto.recipeFileDTO and not empty dto.recipeFileDTO[0].fileName}">
							<div class="row g-2">
								<c:forEach items="${dto.recipeFileDTO}" var="fileDTO">
									<div class="col-12">
										<a href="${pageContext.request.contextPath}/files/myrecipe/${fileDTO.fileName}" target="_blank"> 
											<img src="${pageContext.request.contextPath}/files/myrecipe/${fileDTO.fileName}"
												class="img-fluid rounded-3 shadow-sm"
												alt="${dto.recipeTitle}"
												style="width: 100%; height: auto; max-height: 450px; object-fit: cover;">
										</a>
									</div>
								</c:forEach>
							</div>
						</c:when>
						<c:otherwise>
							<div class="d-flex flex-column align-items-center justify-content-center bg-light rounded-3 text-muted"
								style="width: 100%; height: 350px;">
								<i class="fas fa-utensils fa-3x mb-3 text-secondary"></i>
								<span>등록된 이미지가 없습니다.</span>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			
			<div class="col-lg-7">
				<div class="d-flex flex-column h-100">
					
					<div class="mb-2">
						<span class="badge bg-primary text-white px-3 py-2 rounded-pill fs-6 shadow-sm">
							<i class="fas fa-tag me-1"></i> ${dto.recipeCategory}
						</span>
					</div>
					
					<h2 class="fw-bold text-dark mb-3">${dto.recipeTitle}</h2>
					
					<div class="d-flex flex-wrap align-items-center text-muted gap-3 pb-3 mb-4 border-bottom text-sm">
						<div>
							<i class="fas fa-user-circle me-1 text-secondary"></i>
							작성자: <a href="/member/user?username=${dto.username}" class="text-primary fw-medium text-decoration-none">${dto.username}</a>
						</div>
						<div class="text-secondary">|</div>
						<div>
							<i class="fas fa-calendar-alt me-1 text-secondary"></i> ${dto.recipeDate}
						</div>
						<div class="text-secondary">|</div>
						<div>
							<i class="fas fa-eye me-1 text-secondary"></i> 조회수 ${dto.recipeHit}
						</div>
						<div class="text-secondary">|</div>
						<div>
							<i class="fas fa-heart text-danger me-1"></i> 좋아요 <span id="goodCount" class="fw-bold text-dark">${dto.recipeGoodCount}</span>
						</div>
					</div>

					<div class="p-4 bg-white border border-light-subtle rounded-4 shadow-sm mb-4">
						<h5 class="fw-bold text-secondary mb-3">
							<i class="fas fa-shopping-basket text-success me-2"></i>필수 재료 목록
						</h5>
						<p class="text-dark mb-0 lh-base" style="white-space: pre-wrap;">${dto.recipeBase}</p>
					</div>

					<div class="mb-4 flex-grow-1">
						<h5 class="fw-bold text-secondary mb-3">
							<i class="fas fa-blender text-warning me-2"></i>조리 방법
						</h5>
						<div class="p-4 rounded-4 bg-light text-dark lh-lg" style="white-space: pre-wrap; min-height: 150px;">${dto.recipeContents}</div>
					</div>

					<div class="d-flex flex-wrap justify-content-between align-items-center gap-2 pt-3 border-top">
						<button type="button" id="goodBtn" data-recipe-num="${dto.recipeNum}"
							class="btn ${isGood ? 'btn-danger' : 'btn-outline-danger'} rounded-pill px-4 py-2 transition-all shadow-sm">
							<i class="fa-heart ${isGood ? 'fas' : 'far'} me-2"></i>
							<span>${isGood ? '좋아요 취소' : '좋아요'}</span>
						</button>

						<c:if test="${pageContext.request.userPrincipal.name eq dto.username}">
							<div class="d-flex gap-2">
								<a href="/myrecipe/update?recipeNum=${dto.recipeNum}" class="btn btn-outline-warning px-4 rounded-pill shadow-sm">
									<i class="fas fa-edit me-1"></i> 수정
								</a>
								<a href="/myrecipe/delete?recipeNum=${dto.recipeNum}" class="btn btn-outline-danger px-4 rounded-pill shadow-sm" onclick="return confirm('정말 이 레시피를 삭제하시겠습니까?');">
									<i class="fas fa-trash-alt me-1"></i> 삭제
								</a>
							</div>
						</c:if>
					</div>
					
				</div>
			</div>
			
		</div>
	</div>
</div>
<jsp:include page="../common/footer.jsp" />
<script src="${pageContext.request.contextPath}/js/myRecipe/good.js"></script>
<jsp:include page="../common/scripts.jsp" />