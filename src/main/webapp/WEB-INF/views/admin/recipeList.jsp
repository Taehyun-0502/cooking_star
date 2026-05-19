<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar.jsp" />

<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">Recipe Management</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/dashboard">Admin</a></li>
        <li class="breadcrumb-item active text-white">Recipes</li>
    </ol>
</div>

<div class="container-fluid py-5">
    <div class="container py-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="mb-0">레시피 목록</h2>
            <a href="${pageContext.request.contextPath}/admin/dashboard"
               class="btn border-secondary rounded-pill px-4 text-primary bg-white">
                대시보드
            </a>
        </div>

        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead>
                    <tr>
                        <th scope="col">글 번호</th>
                        <th scope="col">제목</th>
                        <th scope="col">작성자</th>
                        <th scope="col">좋아요</th>
                        <th scope="col">조회수</th>
                        <th scope="col">작성일</th>
                        <th scope="col">상세</th>
                        <th scope="col">관리</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty recipeList}">
                            <tr>
                                <td colspan="7" class="text-center py-5">조회된 레시피가 없습니다.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${recipeList}" var="recipe">
                                <tr>
                                    <td>${recipe.recipeNum}</td>
                                    <td>${recipe.recipeTitle}</td>
                                    <td>${recipe.username}</td>
                                    <td>${recipe.recipeGoodCount}</td>
                                    <td>${recipe.recipeHit}</td>
                                    <td>${recipe.recipeDate}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/myrecipe/detail?recipeNum=${recipe.recipeNum}"
                                           class="btn btn-sm border-secondary rounded-pill px-3 text-primary bg-white">
                                            보기
                                        </a>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="btn btn-sm btn-outline-danger btn-delete"
                                                data-num="${recipe.recipeNum}">
                                            <i class="fas fa-trash-alt"></i> 삭제
                                        </button>
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
<script src="${pageContext.request.contextPath}/js/admin/delete.js"></script>
