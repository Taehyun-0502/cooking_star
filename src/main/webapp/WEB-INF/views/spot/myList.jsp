<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar.jsp" />

<!-- Single Page Header start -->
<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">내 맛집 리스트</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
        <li class="breadcrumb-item active text-white">My Spots</li>
    </ol>
</div>
<!-- Single Page Header End -->

<!-- My Spot List Start -->
<div class="container-fluid py-5">
    <div class="container py-5">
        <div class="d-flex justify-content-end mb-4">
            <a href="${pageContext.request.contextPath}/spot/search" class="btn btn-success rounded-pill px-4 py-2">
                맛집 검색하러 가기
            </a>
        </div>

        <c:choose>
            <c:when test="${not empty myList}">
                <div class="row g-4">
                    <c:forEach items="${myList}" var="spot">
                        <div class="col-md-6 col-lg-4">
                            <div class="bg-light rounded p-4 h-100 d-flex flex-column">
                                <div class="mb-3">
                                    <h3 class="h5 text-primary mb-3">
                                        <c:out value="${spot.placeName}" />
                                    </h3>

                                    <div class="text-muted mb-2">
                                        <strong>주소:</strong>
                                        <c:out value="${spot.addressName}" />
                                    </div>

                                    <div class="text-muted mb-3">
                                        <strong>전화번호:</strong>
                                        <c:choose>
                                            <c:when test="${not empty spot.phone}">
                                                <c:out value="${spot.phone}" />
                                            </c:when>
                                            <c:otherwise>
                                                등록된 전화번호 없음
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <div class="mt-auto d-flex justify-content-end gap-2">
                                    <a href="${spot.placeUrl}"
                                       target="_blank"
                                       class="btn btn-primary rounded-pill px-3">
                                        지도 보기
                                    </a>

                                    <form action="${pageContext.request.contextPath}/spot/delete"
                                          method="post"
                                          onsubmit="return confirm('내 맛집 리스트에서 삭제하시겠습니까?');"
                                          style="display:inline;">

                                        <input type="hidden" name="spotNum" value="${spot.spotNum}">

                                        <c:if test="${not empty _csrf}">
                                            <input type="hidden"
                                                   name="${_csrf.parameterName}"
                                                   value="${_csrf.token}">
                                        </c:if>

                                        <button type="submit" class="btn btn-danger rounded-pill px-3">
                                            삭제
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>

            <c:otherwise>
                <div class="bg-light rounded p-5 text-center text-muted">
                    아직 저장한 맛집이 없습니다.
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<!-- My Spot List End -->

<jsp:include page="../common/footer.jsp" />
<jsp:include page="../common/scripts.jsp" />
