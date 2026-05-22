<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar.jsp" />

<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">문의 상세</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/message/list">Message</a></li>
        <li class="breadcrumb-item active text-white">Detail</li>
    </ol>
</div>

<div class="container-fluid py-5">
    <div class="container py-5">
        <c:choose>
            <c:when test="${empty detail}">
                <div class="bg-light rounded p-5 text-center">
                    <h2 class="mb-3">문의 내용을 찾을 수 없습니다.</h2>
                    <a href="${pageContext.request.contextPath}/message/list"
                       class="btn border-secondary rounded-pill px-4 text-primary bg-white">
                        목록으로
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="mb-0">${detail.title}</h2>
                    <a href="${pageContext.request.contextPath}/message/list"
                       class="btn border-secondary rounded-pill px-4 text-primary bg-white">
                        목록으로
                    </a>
                </div>

                <div class="bg-light rounded p-4 p-lg-5">
                    <div class="row g-4 mb-4">
                        <div class="col-md-3">
                            <div class="bg-white rounded p-3 h-100">
                                <p class="text-muted mb-1">문의 번호</p>
                                <strong>${detail.messageNum}</strong>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="bg-white rounded p-3 h-100">
                                <p class="text-muted mb-1">문의 유형</p>
                                <strong>
                                    <c:choose>
                                        <c:when test="${detail.messageType eq 'ERROR'}">오류 신고</c:when>
                                        <c:when test="${detail.messageType eq 'ACCOUNT'}">계정 문의</c:when>
                                        <c:otherwise>일반 문의</c:otherwise>
                                    </c:choose>
                                </strong>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="bg-white rounded p-3 h-100">
                                <p class="text-muted mb-1">읽음 여부</p>
                                <c:choose>
                                    <c:when test="${detail.readYn eq 'Y'}">
                                        <span class="badge bg-success rounded-pill px-3 py-2">읽음</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-warning text-dark rounded-pill px-3 py-2">미확인</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="bg-white rounded p-3 h-100">
                                <p class="text-muted mb-1">작성일</p>
                                <strong>${detail.createDate}</strong>
                            </div>
                        </div>
                    </div>

                    <div class="bg-white rounded p-4 mb-4">
                        <h5 class="mb-3">작성자 정보</h5>
                        <div class="row g-3">
                            <div class="col-md-4">
                                <p class="text-muted mb-1">작성 구분</p>
                                <strong>
                                    <c:choose>
                                        <c:when test="${detail.writerType eq 'MEMBER'}">회원</c:when>
                                        <c:otherwise>비회원</c:otherwise>
                                    </c:choose>
                                </strong>
                            </div>
                            <div class="col-md-4">
                                <p class="text-muted mb-1">작성자</p>
                                <strong>
                                    <c:choose>
                                        <c:when test="${detail.writerType eq 'MEMBER'}">${detail.username}</c:when>
                                        <c:otherwise>${detail.guestName}</c:otherwise>
                                    </c:choose>
                                </strong>
                            </div>
                            <div class="col-md-4">
                                <p class="text-muted mb-1">이메일</p>
                                <strong>${detail.guestEmail}</strong>
                            </div>
                        </div>
                    </div>

                    <div class="bg-white rounded p-4">
                        <h5 class="mb-3">문의 내용</h5>
                        <div style="white-space: pre-wrap;">${detail.contents}</div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />
<jsp:include page="../common/scripts.jsp" />
