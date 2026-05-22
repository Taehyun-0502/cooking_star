<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar.jsp" />

<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">문의 관리</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
        <li class="breadcrumb-item active text-white">Message</li>
    </ol>
</div>

<div class="container-fluid py-5">
    <div class="container py-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="mb-0">문의 목록</h2>
        </div>

        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead>
                    <tr class="text-center">
                        <th scope="col">번호</th>
                        <th scope="col">유형</th>
                        <th scope="col">제목</th>
                        <th scope="col">내용</th>
                        <th scope="col">작성자</th>
                        <th scope="col">이메일</th>
                        <th scope="col">상태</th>
                        <th scope="col">작성일</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty list}">
                            <tr>
                                <td colspan="8" class="text-center py-5">접수된 문의가 없습니다.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${list}" var="message">
                                <tr>
                                    <td class="text-center">${message.messageNum}</td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${message.messageType eq 'ERROR'}">오류 신고</c:when>
                                            <c:when test="${message.messageType eq 'ACCOUNT'}">계정 문의</c:when>
                                            <c:otherwise>일반 문의</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/message/detail?messageNum=${message.messageNum}"
                                           class="text-primary">
                                            ${message.title}
                                        </a>
                                    </td>
                                    <td style="max-width: 320px; white-space: pre-wrap;">${message.contents}</td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${message.writerType eq 'MEMBER'}">${message.username}</c:when>
                                            <c:otherwise>${message.guestName}</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">${message.guestEmail}</td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${message.readYn eq 'Y'}">
                                                <span class="badge bg-success rounded-pill px-3 py-2">읽음</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-warning text-dark rounded-pill px-3 py-2">미확인</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">${message.createDate}</td>
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
