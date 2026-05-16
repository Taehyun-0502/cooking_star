<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar.jsp" />

<!-- Single Page Header start -->
<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">내 요리 자랑</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
        <li class="breadcrumb-item active text-white">My Cooking</li>
    </ol>
</div>
<!-- Single Page Header End -->

<!-- My Cooking Start-->
<div class="container-fluid fruite py-5">
    <div class="container py-5">
        <div class="row g-4">
            <div class="col-lg-12">
                <div class="row g-4 mb-4">
                    <div class="col-6"></div>
                    <div class="col-6 text-end">
                        <a href="${pageContext.request.contextPath}/mycooking/create" class="btn border-secondary py-3 px-4 rounded-pill text-primary bg-white">
                            <i class="fas fa-edit me-2"></i>글 작성하기
                        </a>
                    </div>
                </div>
                
                <c:choose>
                    <c:when test="${not empty myList}">
                        <div class="row g-4">
                            <c:forEach items="${myList}" var="dto">
                                <div class="col-md-6 col-lg-4 col-xl-3">
                                    <div class="rounded position-relative fruite-item border border-secondary h-100 d-flex flex-column">
                                        <div class="fruite-img">
                                            <a href="${pageContext.request.contextPath}/mycooking/detail?cookingNum=${dto.cookingNum}">
                                                <c:choose>
                                                    <c:when test="${not empty dto.list}">
                                                        <img src="${pageContext.request.contextPath}/files/mycooking/${dto.list[0].fileName}" 
                                                             class="img-fluid w-100 rounded-top" 
                                                             alt="${dto.cookingTitle}"
                                                             style="height: 200px; object-fit: cover;">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="d-flex align-items-center justify-content-center bg-light rounded-top" style="height: 200px;">
                                                            <span class="text-muted small">등록된 이미지가 없습니다.</span>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </a>
                                        </div>
                                        <div class="p-4 rounded-bottom flex-grow-1 d-flex flex-column">
                                            <h4 class="text-truncate">${dto.cookingTitle}</h4>
                                            <p class="text-muted small mb-3" style="height: 3rem; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; white-space: normal;">
                                                ${dto.cookingContents}
                                            </p>
                                            <div class="mt-auto">
                                                <div class="d-flex justify-content-between flex-lg-wrap align-items-center">
                                                    <p class="text-dark fs-6 fw-bold mb-0">No. ${dto.cookingNum}</p>
                                                    <a href="${pageContext.request.contextPath}/mycooking/detail?cookingNum=${dto.cookingNum}" 
                                                       class="btn border border-secondary rounded-pill px-3 text-primary">
                                                        <i class="fa fa-eye me-2 text-primary"></i> 상세보기
                                                    </a>
                                                </div>
                                                <div class="mt-2 text-muted small">
                                                    작성일: ${dto.cookingDate}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center p-5 bg-light rounded">
                            <h4 class="text-muted">아직 작성한 요리 자랑 글이 없습니다.</h4>
                        </div>
                    </c:otherwise>
                </c:choose>

                <div class="col-12 mt-5">
                    <div class="pagination d-flex justify-content-center">
                        <a href="./myList?page=${pager.pre?pager.start-1:pager.start}" 
                           class="rounded ${pager.pre ? '' : 'disabled'}">&laquo;</a>
                        
                        <c:forEach begin="${pager.start}" end="${pager.end}" var="i">
                            <a href="./myList?page=${i}" 
                               class="rounded">${i}</a>
                        </c:forEach>
                        
                        <a href="./myList?page=${pager.next?pager.end+1:pager.end}" 
                           class="rounded ${pager.next ? '' : 'disabled'}">&raquo;</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- My Cooking End-->

<jsp:include page="../common/footer.jsp" />
<jsp:include page="../common/scripts.jsp" />
