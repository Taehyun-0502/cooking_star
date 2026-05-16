<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar.jsp" />

<!-- Single Page Header start -->
<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">유저 페이지</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
        <li class="breadcrumb-item active text-white">User Page</li>
    </ol>
</div>
<!-- Single Page Header End -->

<!-- User Page Start -->
<div class="container-fluid contact py-5">
    <div class="container py-5">
        <div class="p-5 bg-light rounded">
            <div class="row g-4 justify-content-center">
                <div class="col-lg-10">
                    <div class="text-center mb-5">
                        <h2 class="mt-4 mb-2 text-dark font-weight-bold">${targetuser} 님의 공간</h2>
                        
                        <c:if test="${loginUser ne targetuser}">
                            <div class="mt-4">
                                <button type="button" id="followBtn" 
                                        data-user="${targetuser}" 
                                        data-follow="${isFollow}"
                                        class="btn border-secondary py-3 px-5 rounded-pill text-primary bg-white shadow-sm">
                                    <c:choose>
                                        <c:when test="${isFollow > 0}">
                                            <i class="fas fa-user-minus me-2"></i>언 팔로우
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-user-plus me-2"></i>팔로우
                                        </c:otherwise>
                                    </c:choose>
                                </button>
                            </div>
                        </c:if>
                    </div>

                    <div class="bg-white p-4 rounded shadow-sm">
                        <h4 class="mb-4 text-dark border-bottom pb-3">레시피 목록</h4>
                        <div class="table-responsive">
                            <table class="table">
                                <thead class="bg-light">
                                    <tr>
                                        <th scope="col" style="width: 20%;">레시피 글 번호</th>
                                        <th scope="col">레시피 제목</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${list}" var="d">
                                        <tr>
                                            <td><p class="mb-0 mt-2">${d.recipeNum}</p></td>
                                            <td><p class="mb-0 mt-2"><a href="/myrecipe/detail?recipeNum=${d.recipeNum}" class="text-primary">${d.recipeTitle}</a></p></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- User Page End -->

<jsp:include page="../common/footer.jsp" />
<script src="${pageContext.request.contextPath}/js/follow/follow.js"></script>
<jsp:include page="../common/scripts.jsp" />
