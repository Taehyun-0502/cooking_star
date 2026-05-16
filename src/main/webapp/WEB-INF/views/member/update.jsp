<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar.jsp" />

<!-- Single Page Header start -->
<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">정보 수정</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/member/mypage">My Page</a></li>
        <li class="breadcrumb-item active text-white">Update</li>
    </ol>
</div>
<!-- Single Page Header End -->

<!-- Update Start -->
<div class="container-fluid contact py-5">
    <div class="container py-5">
        <div class="p-5 bg-light rounded">
            <div class="row g-4 justify-content-center">
                <div class="col-lg-7">
                    <form:form modelAttribute="memberDTO" method="post" enctype="multipart/form-data">
                        <form:hidden path="username" id="username" />
                        
                        <div class="row g-3">
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

                            <div class="col-lg-12 mt-4">
                                <button type="submit" class="w-100 btn form-control border-secondary py-3 bg-white text-primary">수정 완료</button>
                            </div>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Update End -->

<jsp:include page="../common/footer.jsp" />
<jsp:include page="../common/scripts.jsp" />
