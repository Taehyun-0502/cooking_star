<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!-- Spinner Start -->
<div id="spinner"
	class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
	<div class="spinner-grow text-primary" role="status"></div>
</div>
<!-- Spinner End -->

<!-- Navbar start -->
<div class="container-fluid fixed-top">
	<div class="container px-0">
		<nav class="navbar navbar-light bg-white navbar-expand-xl">
			<a href="${pageContext.request.contextPath}/" class="navbar-brand"><h1
					class="text-primary display-6">Cooking Star</h1></a>
			<button class="navbar-toggler py-2 px-3" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
				<span class="fa fa-bars text-primary"></span>
			</button>
			<div class="collapse navbar-collapse bg-white" id="navbarCollapse">
				<div class="navbar-nav mx-auto">
					<a href="${pageContext.request.contextPath}/"
						class="nav-item nav-link">Home</a> <a
						href="${pageContext.request.contextPath}/cart/search"
						class="nav-item nav-link">Shop</a>

					<div class="nav-item dropdown">
						<a href="#" class="nav-link dropdown-toggle"
							data-bs-toggle="dropdown">Pages</a>
						<div class="dropdown-menu m-0 bg-secondary rounded-0">
							<a href="${pageContext.request.contextPath}/cart"
								class="dropdown-item">Cart</a> <a
								href="${pageContext.request.contextPath}/mycooking/allList"
								class="dropdown-item">요리자랑 리스트</a> <a
								href="${pageContext.request.contextPath}/myrecipe/allList"
								class="dropdown-item">레시피 모음</a>
						</div>
					</div>

					<sec:authorize access="isAuthenticated()">
						<div class="nav-item dropdown">
							<a href="#" class="nav-link dropdown-toggle"
								data-bs-toggle="dropdown">My Menu</a>
							<div class="dropdown-menu m-0 bg-secondary rounded-0">
								<a href="${pageContext.request.contextPath}/myrecipe/myList"
									class="dropdown-item">나의 레시피</a> <a
									href="${pageContext.request.contextPath}/search/list"
									class="dropdown-item">저장한 링크 리스트</a> <a
									href="${pageContext.request.contextPath}/mycooking/create"
									class="dropdown-item">요리 왕 글 작성</a> <a
									href="${pageContext.request.contextPath}/mycooking/myList"
									class="dropdown-item">나의 요리 왕 게시글 보기</a> <a
									href="${pageContext.request.contextPath}/spot/myList"
									class="dropdown-item">내 맛집 리스트</a>
							</div>
						</div>
					</sec:authorize>
					<sec:authorize access="hasAnyRole('ADMIN','MANAGER')">
						<div class="nav-item dropdown">
							<a href="#" class="nav-link dropdown-toggle"
								data-bs-toggle="dropdown">Admin</a>
							<div class="dropdown-menu m-0 bg-secondary rounded-0">
								<a href="${pageContext.request.contextPath}/admin/dashboard"
									class="dropdown-item">Dashboard</a>
								<a href="${pageContext.request.contextPath}/admin/memberList"
									class="dropdown-item">Member Management</a>
								<a href="${pageContext.request.contextPath}/admin/recipeList"
									class="dropdown-item">Recipe Management</a>
							</div>
						</div>
					</sec:authorize>
				</div>

				<div class="d-flex m-3 me-0">
					<sec:authorize access="isAuthenticated()">
						<a href="${pageContext.request.contextPath}/cart/search"
							class="btn border border-secondary btn-md-square rounded-circle bg-white me-4 my-auto">
							<i class="fas fa-search text-primary"></i>
						</a>
						<a href="${pageContext.request.contextPath}/cart/list"
							class="position-relative me-4 my-auto"> <i
							class="fa fa-shopping-bag fa-2x"></i>
						</a>
						<a href="${pageContext.request.contextPath}/buylist/list"
							class="position-relative me-4 my-auto"><i
							class="fas fa-receipt fa-2x text-primary"></i></a>
						<a href="${pageContext.request.contextPath}/member/mypage"
							class="my-auto me-4"> <i class="fas fa-user fa-2x"></i>
						</a>
						<form action="${pageContext.request.contextPath}/member/logout"
							method="post" class="d-inline my-auto">
							<button type="submit"
								class="btn btn-primary text-white rounded-pill px-3 py-2">로그아웃</button>
						</form>
					</sec:authorize>

					<sec:authorize access="!isAuthenticated()">
						<a href="${pageContext.request.contextPath}/member/join"
							class="me-3 my-auto text-dark text-decoration-none">회원가입</a>
						<a href="${pageContext.request.contextPath}/member/login"
							class="btn btn-primary text-white rounded-pill px-4 py-2 my-auto">로그인</a>
					</sec:authorize>
				</div>
			</div>
		</nav>
	</div>
</div>
<!-- Navbar End -->
