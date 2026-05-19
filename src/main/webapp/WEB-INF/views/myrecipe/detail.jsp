<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar.jsp" />

<div class="container-fluid page-header py-5"
	style="background: linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3)), url('/img/page-header.jpg') center center no-repeat; background-size: cover;">
	<h1 class="text-center text-white display-6">레시피 상세</h1>
	<ol class="breadcrumb justify-content-center mb-0">
		<li class="breadcrumb-item"><a
			href="${pageContext.request.contextPath}/">Home</a></li>
		<li class="breadcrumb-item"><a
			href="${pageContext.request.contextPath}/myrecipe/allList">Recipes</a></li>
		<li class="breadcrumb-item active text-white">Detail</li>
	</ol>
</div>
<div class="container-fluid py-5 mt-4">
	<div class="container py-5">
		<div class="row g-5">

			<div class="col-lg-5">
				<div class="border rounded-4 overflow-hidden shadow-sm bg-white p-2">
					<c:choose>
						<c:when
							test="${not empty dto.recipeFileDTO and not empty dto.recipeFileDTO[0].fileName}">
							<div class="row g-2">
								<c:forEach items="${dto.recipeFileDTO}" var="fileDTO">
									<div class="col-12">
										<a
											href="${pageContext.request.contextPath}/files/myrecipe/${fileDTO.fileName}"
											target="_blank"> <img
											src="${pageContext.request.contextPath}/files/myrecipe/${fileDTO.fileName}"
											class="img-fluid rounded-3 shadow-sm"
											alt="${dto.recipeTitle}"
											style="width: 100%; height: auto; max-height: 450px; object-fit: cover;">
										</a>
									</div>
								</c:forEach>
							</div>
						</c:when>
						<c:otherwise>
							<div
								class="d-flex flex-column align-items-center justify-content-center bg-light rounded-3 text-muted"
								style="width: 100%; height: 350px;">
								<i class="fas fa-utensils fa-3x mb-3 text-secondary"></i> <span>등록된
									이미지가 없습니다.</span>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>

			<div class="col-lg-7">
				<div class="d-flex flex-column h-100">

					<div class="mb-2">
						<span
							class="badge bg-primary text-white px-3 py-2 rounded-pill fs-6 shadow-sm">
							<i class="fas fa-tag me-1"></i> ${dto.recipeCategory}
						</span>
					</div>

					<h2 class="fw-bold text-dark mb-3">${dto.recipeTitle}</h2>

					<div
						class="d-flex flex-wrap align-items-center text-muted gap-3 pb-3 mb-4 border-bottom text-sm">
						<div>
							<i class="fas fa-user-circle me-1 text-secondary"></i> 작성자: <a
								href="/member/user?username=${dto.username}"
								class="text-primary fw-medium text-decoration-none">${dto.username}</a>
						</div>
						<div class="text-secondary">|</div>
						<div>
							<i class="fas fa-calendar-alt me-1 text-secondary"></i>
							${dto.recipeDate}
						</div>
						<div class="text-secondary">|</div>
						<div>
							<i class="fas fa-eye me-1 text-secondary"></i> 조회수
							${dto.recipeHit}
						</div>
						<div class="text-secondary">|</div>
						<div>
							<i class="fas fa-heart text-danger me-1"></i> 좋아요 <span
								id="goodCount" class="fw-bold text-dark">${dto.recipeGoodCount}</span>
						</div>
					</div>

					<div
						class="p-4 bg-white border border-light-subtle rounded-4 shadow-sm mb-4">
						<h5 class="fw-bold text-secondary mb-3">
							<i class="fas fa-shopping-basket text-success me-2"></i>필수 재료 목록
						</h5>
						<p class="text-dark mb-0 lh-base" style="white-space: pre-wrap;">${dto.recipeBase}</p>
					</div>

					<div class="mb-4 flex-grow-1">
						<h5 class="fw-bold text-secondary mb-3">
							<i class="fas fa-blender text-warning me-2"></i>조리 방법
						</h5>
						<div class="p-4 rounded-4 bg-light text-dark lh-lg"
							style="white-space: pre-wrap; min-height: 150px;">${dto.recipeContents}</div>
					</div>

					<div
						class="d-flex flex-wrap justify-content-between align-items-center gap-2 pt-3 border-top">
						<button type="button" id="goodBtn"
							data-recipe-num="${dto.recipeNum}"
							class="btn ${isGood ? 'btn-danger' : 'btn-outline-danger'} rounded-pill px-4 py-2 transition-all shadow-sm">
							<i class="fa-heart ${isGood ? 'fas' : 'far'} me-2"></i> <span>${isGood ? '좋아요 취소' : '좋아요'}</span>
						</button>

						<div class="d-flex flex-wrap gap-2">
							<sec:authorize access="isAuthenticated()">
								<c:if
									test="${pageContext.request.userPrincipal.name ne dto.username}">
									<c:choose>
										<c:when test="${isBookmark}">
											<a
												href="${pageContext.request.contextPath}/bookmark/delete?recipeNum=${dto.recipeNum}"
												class="btn btn-outline-secondary px-4 rounded-pill shadow-sm">
												<i class="fas fa-bookmark me-1"></i> 북마크 취소
											</a>
										</c:when>
										<c:otherwise>
											<a
												href="${pageContext.request.contextPath}/bookmark/add?recipeNum=${dto.recipeNum}"
												class="btn btn-outline-primary px-4 rounded-pill shadow-sm">
												<i class="far fa-bookmark me-1"></i> 북마크
											</a>
										</c:otherwise>
									</c:choose>
								</c:if>
							</sec:authorize>
							<sec:authorize access="!isAuthenticated()">

								<a href="${pageContext.request.contextPath}/member/login"
									class="btn btn-outline-primary px-4 rounded-pill shadow-sm">
									<i class="far fa-bookmark me-1"></i> 북마크
								</a>

							</sec:authorize>
							<c:if
								test="${pageContext.request.userPrincipal.name eq dto.username}">
								<a href="/myrecipe/update?recipeNum=${dto.recipeNum}"
									class="btn btn-outline-warning px-4 rounded-pill shadow-sm">
									<i class="fas fa-edit me-1"></i> 수정
								</a>
								<form
									action="${pageContext.request.contextPath}/myrecipe/delete"
									method="post" onsubmit="return confirm('정말 이 레시피를 삭제하시겠습니까?');">

									<input type="hidden" name="recipeNum" value="${dto.recipeNum}">

									<button type="submit"
										class="btn btn-outline-danger px-4 rounded-pill shadow-sm">
										<i class="fas fa-trash-alt me-1"></i> 삭제
									</button>

								</form>
							</c:if>
						</div>
					</div>

				</div>
			</div>

		</div>
	</div>
</div>

<div class="container-fluid pb-5">
	<div class="container pb-5">
		<div class="bg-white border rounded-4 shadow-sm p-4">
			<div class="d-flex justify-content-between align-items-center mb-4">
				<h4 class="fw-bold mb-0">댓글</h4>
				<span class="text-muted">총 ${fn:length(comment)}개</span>
			</div>

			<sec:authorize access="isAuthenticated()">
				<form action="${pageContext.request.contextPath}/myrecipe/comment"
					method="post" class="mb-4">
					<input type="hidden" name="recipeNum" value="${dto.recipeNum}">
					<label for="contents" class="form-label fw-semibold">댓글 작성</label>
					<textarea id="contents" name="contents" class="form-control mb-3"
						rows="3" placeholder="댓글을 입력하세요." required></textarea>
					<div class="text-end">
						<button type="submit" class="btn btn-primary rounded-pill px-4">등록</button>
					</div>
				</form>
			</sec:authorize>

			<sec:authorize access="!isAuthenticated()">
				<div class="alert alert-light border mb-4">
					댓글을 작성하려면 로그인이 필요합니다. <a
						href="${pageContext.request.contextPath}/member/login"
						class="text-primary">로그인</a>
				</div>
			</sec:authorize>

			<c:choose>
				<c:when test="${empty comment}">
					<div class="text-center text-muted py-4">작성된 댓글이 없습니다.</div>
				</c:when>
				<c:otherwise>
					<div class="list-group list-group-flush">
						<c:forEach items="${comment}" var="reply">
							<div class="list-group-item px-0 py-3">
								<div
									class="d-flex justify-content-between align-items-center mb-2">
									<strong>${reply.username}</strong> <small class="text-muted">${reply.createDate}</small>
								</div>
								<p class="mb-0" style="white-space: pre-wrap;">${reply.contents}</p>
							</div>
							<div>
								<c:if
									test="${pageContext.request.userPrincipal.name eq reply.username}">
									<form action="/myrecipe/commentD" method="post">
										<input type="hidden" name="commentNum"
											value="${reply.commentNum}"> <input type="hidden"
											name="recipeNum" value="${dto.recipeNum}">
										<button type="submit" class="btn-delete">삭제</button>
									</form>
								</c:if>
							</div>
						</c:forEach>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>

<jsp:include page="../common/footer.jsp" />
<script src="${pageContext.request.contextPath}/js/myRecipe/good.js"></script>
<script src="${pageContext.request.contextPath}/js/myRecipe/myList.js"></script>
<jsp:include page="../common/scripts.jsp" />
