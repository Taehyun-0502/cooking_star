<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="./common/header.jsp" />
<jsp:include page="./common/navbar.jsp" />

<!-- Hero Start -->
<div class="container-fluid py-5 mb-5 hero-header">
    <div class="container py-5">
        <div class="row g-5 align-items-center">
            <div class="col-md-12 col-lg-7">
                <h4 class="mb-3 text-secondary">100% Healthy & Delicious</h4>
                <h1 class="mb-5 display-3 text-primary">${gemini}</h1>
                
                <div class="position-relative mx-auto">
                    <form action="${pageContext.request.contextPath}/search/result" method="get">
                        <input class="form-control border-2 border-secondary w-75 py-3 px-4 rounded-pill" type="text" placeholder="레시피 검색" id="recipesearch" name="query">
                        <button type="submit" id="recipebtn" class="btn btn-primary border-2 border-secondary py-3 px-4 position-absolute rounded-pill text-white h-100" style="top: 0; right: 25%;">검색</button>
                    </form>
                </div>
            </div>
            
            <div class="col-md-12 col-lg-5">
                <div class="card border-secondary shadow-sm rounded">
                    <div class="card-header bg-primary text-white py-3">
                        <h5 class="mb-0 text-center text-white"><i class="fas fa-fire me-2"></i>실시간 인기 레시피</h5>
                    </div>
                    <div class="card-body p-0">
                        <ul class="list-group list-group-flush">
                            <c:choose>
                                <c:when test="${not empty ranking}">
                                    <c:forEach items="${ranking}" var="rank" varStatus="vs">
                                        <li class="list-group-item d-flex justify-content-between align-items-center py-3">
                                            <div>
                                                <span class="badge bg-secondary me-3" style="width: 30px;">${vs.count}</span>
                                                <strong class="text-dark">${rank.keyword}</strong>
                                            </div>
                                            <span class="badge bg-light text-primary border border-primary rounded-pill">
                                                ${rank.count}회 검색
                                            </span>
                                        </li>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <li class="list-group-item text-center py-5 text-muted">
                                        아직 검색 기록이 없습니다.
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                    <div class="card-footer bg-white text-center py-2">
                        <jsp:useBean id="now" class="java.util.Date" />
                        <small class="text-muted">
                            <fmt:formatDate value="${now}" pattern="yyyy년 MM월 dd일" /> 집계된 데이터입니다.
                        </small>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Hero End -->

<!-- My Cooking Section Start -->
<div class="container-fluid featurs py-5">
    <div class="container py-5">
        <div class="text-center mx-auto mb-5" style="max-width: 700px;">
            <h1 class="display-4">요리 왕 갤러리</h1>
            <p>회원님들이 직접 만든 정성 가득한 요리를 만나보세요.</p>
        </div>
        <div class="row g-4">
            <c:forEach items="${myCookingList}" var="dto">
                <div class="col-md-6 col-lg-3">
                    <div class="featurs-item text-center rounded bg-light p-4 h-100 border border-secondary">
                        <div class="mb-4">
                            <a href="${pageContext.request.contextPath}/mycooking/detail?cookingNum=${dto.cookingNum}">
                                <c:choose>
                                    <c:when test="${not empty dto.list}">
                                        <c:choose>
                                            <c:when test="${not empty dto.list[0].fileName}">
                                                <img src="${pageContext.request.contextPath}/files/mycooking/${dto.list[0].fileName}"
                                                     alt="${dto.cookingTitle}"
                                                     class="img-fluid rounded"
                                                     style="width: 100%; height: 180px; object-fit: cover;">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/files/mycooking/noimage.jpg"
                                                     alt="기본 이미지"
                                                     class="img-fluid rounded"
                                                     style="width: 100%; height: 180px; object-fit: cover;">
                                            </c:otherwise> 
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/resources/img/noimage2.jpg"
                                             alt="기본 이미지"
                                             class="img-fluid rounded"
                                             style="width: 100%; height: 180px; object-fit: cover;">
                                    </c:otherwise>
                                </c:choose>
                            </a>
                        </div>
                        <div class="featurs-content text-center">
                            <h5>
                                <a href="${pageContext.request.contextPath}/mycooking/detail?cookingNum=${dto.cookingNum}"
                                   class="text-dark text-decoration-none">
                                    ${dto.cookingTitle}
                                </a>
                            </h5>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<!-- My Cooking Section End -->

<!-- Spot Search Start -->
<div class="container-fluid py-5 bg-light">
    <div class="container py-5">
        <div class="text-center mx-auto mb-5" style="max-width: 700px;">
            <h1 class="display-4">맛집 검색</h1>
            <p>내 주변의 맛있는 맛집을 찾아보세요.</p>
        </div>
        <form action="${pageContext.request.contextPath}/spot/search" method="get" class="d-flex justify-content-center">
            <input type="text"
                   name="query"
                   class="form-control border-secondary w-50 py-3 px-4 rounded-pill me-2"
                   value="${query}"
                   placeholder="예: 강남역 맛집, 홍대 파스타">
            <button type="submit" class="btn btn-primary border-secondary py-3 px-4 rounded-pill text-white">검색</button>
        </form>
    </div>
</div>
<!-- Spot Search End -->

<jsp:include page="./common/footer.jsp" />
<script src="${pageContext.request.contextPath}/js/search.js"></script>
<jsp:include page="./common/scripts.jsp" />
