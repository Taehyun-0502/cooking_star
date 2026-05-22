<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar.jsp" />

<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">문의하기</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
        <li class="breadcrumb-item active text-white">Message</li>
    </ol>
</div>

<div class="container-fluid contact py-5">
    <div class="container py-5">
        <div class="p-5 bg-light rounded">
            <div class="row g-4">
                <div class="col-12 text-center mx-auto" style="max-width: 700px;">
                    <h1 class="text-primary">문의사항 입력</h1>
                    <p class="mb-4">궁금한 내용을 남겨주시면 관리자가 확인 후 처리합니다.</p>
                </div>

                <div class="col-lg-8 mx-auto">
                    <form action="${pageContext.request.contextPath}/message/create" method="post">
                        <sec:authorize access="isAnonymous()">
                            <div class="mb-3">
                                <label class="form-label" for="guestName">이름</label>
                                <input type="text" name="guestName" id="guestName" class="w-100 form-control border-0 py-3" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label" for="guestEmail">이메일</label>
                                <input type="email" name="guestEmail" id="guestEmail" class="w-100 form-control border-0 py-3" required>
                            </div>
                        </sec:authorize>

                        <div class="mb-3">
                            <label class="form-label" for="messageType">문의 유형</label>
                            <select name="messageType" id="messageType" class="w-100 form-control border-0 py-3" required>
                                <option value="">문의 유형을 선택하세요</option>
                                <option value="GENERAL">일반 문의</option>
                                <option value="ACCOUNT">계정 문의</option>
                                <option value="ERROR">오류 신고</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label" for="title">제목</label>
                            <input type="text" name="title" id="title" class="w-100 form-control border-0 py-3" required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label" for="contents">내용</label>
                            <textarea name="contents" id="contents" class="w-100 form-control border-0 py-3" rows="8" required></textarea>
                        </div>

                        <button type="submit" class="w-100 btn form-control border-secondary py-3 bg-white text-primary">문의 등록</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />
<script src="${pageContext.request.contextPath}/js/message/createResult.js"></script>
<jsp:include page="../common/scripts.jsp" />
