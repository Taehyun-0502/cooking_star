<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar.jsp" />

<!-- Single Page Header start -->
<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">회원가입</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
        <li class="breadcrumb-item active text-white">Join</li>
    </ol>
</div>
<!-- Single Page Header End -->

<!-- Join Start -->
<div class="container-fluid contact py-5">
    <div class="container py-5">
        <div class="p-5 bg-light rounded">
            <div class="row g-4 justify-content-center">
                <div class="col-lg-7">
                    <form:form modelAttribute="memberDTO" method="post" enctype="multipart/form-data">
                        <div class="row g-3">
                            <div class="col-lg-12">
                                <label for="username" class="form-label">아이디</label>
                                <form:input path="username" id="username" cssClass="w-100 form-control border-0 py-3" placeholder="Your ID" />
                                <form:errors path="username" cssClass="text-danger" />
                            </div>
                            <div class="col-lg-6">
                                <label for="password" class="form-label">비밀번호</label>
                                <form:password path="password" id="password" cssClass="w-100 form-control border-0 py-3" placeholder="Your Password" />
                                <form:errors path="password" cssClass="text-danger" />
                            </div>
                            <div class="col-lg-6">
                                <label for="passwordCheck" class="form-label">비밀번호 확인</label>
                                <form:password path="passwordCheck" id="passwordCheck" cssClass="w-100 form-control border-0 py-3" placeholder="Repeat Password" />
                                <form:errors path="passwordCheck" cssClass="text-danger" />
                            </div>
                            <div class="col-lg-12">
                                <label for="name" class="form-label">이름</label>
                                <form:input path="name" id="name" cssClass="w-100 form-control border-0 py-3" placeholder="Your Name" />
                                <form:errors path="name" cssClass="text-danger" />
                            </div>
                            <div class="col-lg-12">
                                <label for="email" class="form-label">이메일</label>
                                <form:input path="email" id="email" cssClass="w-100 form-control border-0 py-3" placeholder="Your Email" />
                                <form:errors path="email" cssClass="text-danger" />
                            </div>
                            <div class="col-lg-12">
                                <label for="attach" class="form-label">프로필 이미지</label>
                                <input type="file" class="w-100 form-control border-0 py-3 bg-white" id="attach" name="attach">
                            </div>
                            <div class="col-lg-12 mt-4">
                                <button type="submit" class="w-100 btn form-control border-secondary py-3 bg-white text-primary">회원가입</button>
                            </div>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Join End -->

<jsp:include page="../common/footer.jsp" />
<jsp:include page="../common/scripts.jsp" />
