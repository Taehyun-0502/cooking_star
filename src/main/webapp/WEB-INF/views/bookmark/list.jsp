<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar.jsp" />

<div class="container-fluid page-header py-5">
	<h1 class="text-center text-white display-6">북마크 목록</h1>
	<ol class="breadcrumb justify-content-center mb-0">
		<li class="breadcrumb-item">
			<a href="${pageContext.request.contextPath}/">Home</a>
		</li>
		<li class="breadcrumb-item">
			<a href="${pageContext.request.contextPath}/member/mypage">My Page</a>
		</li>
		<li class="breadcrumb-item active text-white">Bookmark</li>
	</ol>
</div>

<div class="container-fluid py-5">
	<div class="container py-5">
		<div class="d-flex justify-content-between align-items-center mb-4">
			<h2 class="mb-0">내가 북마크한 레시피</h2>
			<a href="${pageContext.request.contextPath}/member/mypage"
				class="btn border-secondary rounded-pill px-4 text-primary bg-white">
				마이페이지
			</a>
		</div>

		<div class="table-responsive">
			<table class="table table-hover align-middle">
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">레시피 번호</th>
						<th scope="col">작성자</th>
						<th scope="col">상세 보기</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty list}">
							<tr>
								<td colspan="4" class="text-center py-5">북마크한 레시피가 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${list}" var="bookmark">
								<tr>
									<td>${bookmark.bookmarkNum}</td>
									<td>${bookmark.recipeNum}</td>
									<td>${bookmark.username}</td>
									<td>
										<a href="${pageContext.request.contextPath}/myrecipe/detail?recipeNum=${bookmark.recipeNum}"
											class="btn btn-sm border-secondary rounded-pill px-3 text-primary bg-white">
											보기
										</a>
									</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
	</div>
</div>

<jsp:include page="../common/footer.jsp" />
<jsp:include page="../common/scripts.jsp" />
