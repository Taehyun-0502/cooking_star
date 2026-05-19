<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar.jsp" />

<!-- Single Page Header start -->
<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">요리 자랑 상세</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/mycooking/allList">Cooking List</a></li>
        <li class="breadcrumb-item active text-white">Detail</li>
    </ol>
</div>
<!-- Single Page Header End -->

<!-- My Cooking Detail Start -->
<div class="container-fluid py-5">
    <div class="container py-5">
        <article class="bg-light rounded p-4 p-lg-5">
            <header class="border-bottom pb-4 mb-4">
                <p class="text-primary fw-bold mb-2">제목</p>
                <h1 class="text-dark mb-3">
                    <c:out value="${dto.cookingTitle}" />
                </h1>

                <div class="d-flex flex-wrap gap-4 text-muted">
                    <span>글번호: ${dto.cookingNum}</span>
                    <span>작성일: ${dto.cookingDate}</span>
                    <span>
                        작성자:
                        <a href="/member/user?username=${dto.username}" class="text-primary">
                            <c:out value="${dto.username}" />
                        </a>
                    </span>   
                </div>
                <div class="d-flex gap-4 text-muted mt-2">
                    <span><i class="fas fa-eye me-1"></i> 조회수: ${dto.cookingHit}</span>
                    <span>
                        <i class="fas fa-heart text-danger me-1"></i> 좋아요: 
                        <span id="goodCount" class="fw-bold text-dark">${dto.cookingGood}</span>
                    </span>
                </div>
            </header>

            <section class="mb-5">
                <h2 class="h4 mb-3 text-dark">요리 소개</h2>
                <div class="bg-white rounded p-4" style="white-space: pre-line;">
                    <c:out value="${dto.cookingContents}" />
                </div>
            </section>

            <section class="mb-5">
                <h2 class="h4 mb-3 text-dark">사진</h2>

                <c:choose>
                    <c:when test="${not empty dto.list}">
                        <div class="row g-4">
                            <c:forEach items="${dto.list}" var="file">
                                <div class="col-md-6 col-lg-4">
                                    <div class="border rounded bg-white overflow-hidden">
                                        <img class="img-fluid w-100"
                                            src="${pageContext.request.contextPath}/files/${name}/${file.fileName}"
                                            alt="요리 이미지"
                                            style="height: 240px; object-fit: cover;">
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="bg-white rounded p-5 text-center text-muted">등록된 이미지가 없습니다.</div>
                    </c:otherwise>
                </c:choose>
            </section>

            <section class="mb-5">
                <h2 class="h4 mb-3 text-dark">참고 레시피</h2>
                <div class="bg-white rounded p-4" style="white-space: pre-line;">
                     <a href="${dto.cookingRecipe}" target="_blank" rel="noopener noreferrer">
                    <c:out value="${dto.cookingRecipe}" />
                    </a>
                </div>
            </section>
            <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 border-top pt-4">
               
                <div class="d-flex gap-2">
                <button type="button" id="goodBtn" data-cooking-num="${dto.cookingNum}"
                    class="btn ${isGood ? 'btn-danger' : 'btn-outline-danger'} rounded-pill px-4 py-2 transition-all shadow-sm">
                    <i class="fa-heart ${isGood ? 'fas' : 'far'} me-2"></i>
                    <span>${isGood ? '좋아요 취소' : '좋아요'}</span>
                </button>
                    <a href="/mycooking/allList" class="btn border border-secondary rounded-pill px-4 py-2 text-primary bg-white">목록</a>
                    <a href="./update?cookingNum=${dto.cookingNum}" class="btn border border-secondary rounded-pill px-4 py-2 text-primary bg-white">수정</a>
                    <form action="./delete" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');" style="display: inline;">
                        <input type="hidden" name="cookingNum" value="${dto.cookingNum}">
                        <c:if test="${not empty _csrf}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                        </c:if>
                        <button type="submit" class="btn btn-danger rounded-pill px-4 py-2">삭제</button>
                    </form>
                </div>
                
            </div>
        </article>
    </div>
</div>
<!-- My Cooking Detail End -->

<jsp:include page="../common/footer.jsp" />
<jsp:include page="../common/scripts.jsp" />
<script src="${pageContext.request.contextPath}/js/mycooking/good.js"></script>
