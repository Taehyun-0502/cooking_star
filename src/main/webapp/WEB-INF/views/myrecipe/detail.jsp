<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar.jsp" />

<!-- Single Page Header start -->
<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">레시피 상세</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/myrecipe/allList">Recipes</a></li>
        <li class="breadcrumb-item active text-white">Detail</li>
    </ol>
</div>
<!-- Single Page Header End -->

<!-- Single Product Start -->
<div class="container-fluid py-5 mt-5">
    <div class="container py-5">
        <div class="row g-4 mb-5">
            <div class="col-lg-8 col-xl-9">
                <div class="row g-4">
                    <div class="col-lg-6">
                        <div class="border rounded">
                           <c:choose>
        <c:when test="${not empty dto.recipeFileDTO and not empty dto.recipeFileDTO.fileName}">
            <a href="#">
                <img 
                    src="${pageContext.request.contextPath}/files/${name}/${dto.recipeFileDTO.fileName}" 
                    class="img-fluid rounded" 
                    alt="${dto.recipeTitle}"
                    style="width: 100%; height: 350px; object-fit: cover;">
            </a>
        </c:when>

        <c:otherwise>
            <div class="d-flex align-items-center justify-content-center bg-light rounded text-muted"
                 style="width: 100%; height: 350px;">
                등록된 이미지가 없습니다.
            </div>
        </c:otherwise>
    </c:choose>
                           <!-- 이미지가 등록 되지 않으면 이미지가 깨짐 -->
                            <%-- <a href="#">
                                <img src="/files/${name}/${dto.recipeFileDTO.fileName}" class="img-fluid rounded" alt="Image">
                            </a> --%>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <h4 class="fw-bold mb-3">${dto.recipeTitle}</h4>
                        <p class="mb-3">작성자: <a href="/member/user?username=${dto.username}">${dto.username}</a></p>
                        <p class="mb-3">작성일: ${dto.recipeDate}</p>
                        <div class="d-flex mb-4">
                            <div class="me-4">
                                <i class="fa fa-eye text-primary me-2"></i>조회수 ${dto.recipeHit}
                            </div>
                            <div>
                                <i class="fa fa-heart text-primary me-2"></i>좋아요 <span id="goodCount">${dto.recipeGoodCount}</span>
                            </div>
                        </div>
                        <p class="mb-4">${dto.recipeContents}</p>
                        
                        <div class="d-flex gap-2">
                            <button type="button" id="goodBtn" data-recipe-num="${dto.recipeNum}" class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary">
                                <i class="fa fa-heart me-2"></i>
                                <c:choose>
                                    <c:when test="${isGood}">좋아요 취소</c:when>
                                    <c:otherwise>좋아요</c:otherwise>
                                </c:choose>
                            </button>
                        </div>
                        
                        <div class="d-flex gap-2 mt-4">
                            <a href="/myrecipe/update?recipeNum=${dto.recipeNum}" class="btn border border-secondary rounded-pill px-4 py-2 text-primary">수정</a>
                            <a href="/myrecipe/allList" class="btn border border-secondary rounded-pill px-4 py-2 text-primary">목록으로</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Single Product End -->

<jsp:include page="../common/footer.jsp" />
<script src="${pageContext.request.contextPath}/js/myRecipe/good.js"></script>
<jsp:include page="../common/scripts.jsp" />