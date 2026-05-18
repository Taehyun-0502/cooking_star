<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar.jsp" />

<!-- Single Page Header start -->
<div class="container-fluid page-header py-5">
	<h1 class="text-center text-white display-6">맛집 검색</h1>
	<ol class="breadcrumb justify-content-center mb-0">
		<li class="breadcrumb-item"><a
			href="${pageContext.request.contextPath}/">Home</a></li>
		<li class="breadcrumb-item active text-white">Spot Search</li>
	</ol>
</div>
<!-- Single Page Header End -->

<!-- Spot Search Start -->
<div class="container-fluid py-5">
	<div class="container py-5">
		<div class="row g-4 mb-5">
			<div class="col-lg-8 mx-auto">
				<form action="/spot/search" method="get" class="d-flex gap-2">
					<input type="text" name="query" class="form-control border-0 py-3"
						value="${query}" placeholder="예: 강남역 맛집, 홍대 파스타, 수원역 카페">

					<input type="hidden" name="page" value="1">


					<button type="submit" class="btn btn-primary px-4">검색</button>
				</form>
			</div>
		</div>

		<c:choose>
			<c:when test="${not empty list}">
				<div class="row g-4">
					<c:forEach items="${list}" var="spot">
						<div class="col-md-6 col-lg-4">
							<div class="bg-light rounded p-4 h-100 d-flex flex-column">
								<div class="mb-3">
									<h3 class="h5 text-primary mb-3">
										<c:out value="${spot.placeName}" />
									</h3>

									<div class="text-muted mb-2">
										<strong>지번 주소:</strong>
										<c:out value="${spot.addressName}" />
									</div>

									<div class="text-muted mb-3">
										<strong>전화번호:</strong>
										<c:out value="${spot.phone}" />
									</div>
								</div>

								<div class="mt-auto d-flex flex-wrap gap-2">
									<a href="${spot.placeUrl}" target="_blank"
										class="btn border border-secondary rounded-pill px-3 text-primary bg-white">
										카카오맵에서 보기 </a>

									<c:choose>
										<c:when test="${spot.saved}">
											<button type="button" class="btn btn-secondary" disabled>
												이미 추가됨</button>
										</c:when>

										<c:otherwise>
											<button type="button" class="spotBtn btn btn-primary"
												data-place-name="${spot.placeName}"
												data-address-name="${spot.addressName}"
												data-phone="${spot.phone}" data-url="${spot.placeUrl}">
												내 맛집 리스트에 추가</button>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<c:if test="${pager.end > 0}">
					<nav class="mt-5">
						<ul class="pagination justify-content-center d-flex flex-row">

							<c:if test="${pager.pre}">
								<c:url var="preUrl" value="/spot/search">
									<c:param name="query" value="${query}" />
									<c:param name="page" value="${pager.start - 1}" />
								</c:url>

								<li class="page-item"><a class="page-link" href="${preUrl}">&laquo;</a>
								</li>
							</c:if>

							<c:forEach begin="${pager.start}" end="${pager.end}" var="i">
								<c:url var="pageUrl" value="/spot/search">
									<c:param name="query" value="${query}" />
									<c:param name="page" value="${i}" />
								</c:url>

								<li class="page-item ${pager.page == i ? 'active' : ''}"><a
									class="page-link" href="${pageUrl}">${i}</a></li>
							</c:forEach>

							<c:if test="${pager.next}">
								<c:url var="nextUrl" value="/spot/search">
									<c:param name="query" value="${query}" />
									<c:param name="page" value="${pager.end + 1}" />
								</c:url>

								<li class="page-item"><a class="page-link"
									href="${nextUrl}">&raquo;</a></li>
							</c:if>

						</ul>
					</nav>
				</c:if>
			</c:when>

			<c:otherwise>
				<div class="bg-light rounded p-5 text-center text-muted">검색어를
					입력하면 맛집 결과가 표시됩니다.</div>
			</c:otherwise>
		</c:choose>
	</div>
</div>
<!-- Spot Search End -->

<jsp:include page="../common/footer.jsp" />
<script src="${pageContext.request.contextPath}/js/spot/spotAdd.js"></script>
<jsp:include page="../common/scripts.jsp" />
