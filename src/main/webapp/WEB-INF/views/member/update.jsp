<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar.jsp" />

<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">정보 수정</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/member/mypage">My Page</a></li>
        <li class="breadcrumb-item active text-white">Update</li>
    </ol>
</div>
<div class="container-fluid contact py-5">
    <div class="container py-5">
        <div class="p-5 bg-light rounded-4 shadow-sm mx-auto" style="max-width: 600px;">
            <div class="row g-4 justify-content-center">
                <div class="col-lg-12">
                    
                    <%-- 💡 자바스크립트에서 폼을 인식할 수 있도록 id="updateForm"을 추가했습니다 --%>
                    <form:form id="updateForm" modelAttribute="memberDTO" method="post" enctype="multipart/form-data">
                        <form:hidden path="username" id="username" />
                        
                        <div class="row g-4">
                            
                            <div class="col-lg-12 text-center mb-3">
                                <div class="position-relative d-inline-block">
                                    <c:choose>
                                        <%-- 기존 프로필 이미지가 존재하는 경우 --%>
                                        <c:when test="${not empty memberDTO.profileDTO and not empty memberDTO.profileDTO.fileName}">
                                            <img id="profilePreview" 
                                                 src="${pageContext.request.contextPath}/files/profile/${memberDTO.profileDTO.fileName}" 
                                                 class="rounded-circle img-thumbnail shadow-sm" 
                                                 style="width: 130px; height: 130px; object-fit: cover;" 
                                                 alt="Profile">
                                        </c:when>
                                        <%-- 기존 이미지가 없는 경우 (기본 아바타 아이콘) --%>
                                        <c:otherwise>
                                            <div id="profilePreviewFallback" 
                                                 class="rounded-circle bg-white d-flex align-items-center justify-content-center shadow-sm border mx-auto" 
                                                 style="width: 130px; height: 130px;">
                                                <i class="fas fa-user fa-4x text-secondary"></i>
                                            </div>
                                            <img id="profilePreview" class="rounded-circle img-thumbnail shadow-sm d-none" style="width: 130px; height: 130px; object-fit: cover;">
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                
                                <%-- 실제 파일 선택 인풋 (name="attach"로 컨트롤러와 연결) --%>
                                <div class="mt-3 mx-auto" style="max-width: 350px;">
                                    <label for="attach" class="form-label text-muted small fw-bold">프로필 사진 변경</label>
                                    <input type="file" name="attach" id="attach" class="form-control border-0 shadow-sm" accept="image/*" onchange="previewImage(this);" />
                                </div>
                            </div>
                            
                            <div class="col-lg-12">
                                <label for="name" class="form-label fw-bold text-secondary">이름</label>
                                <form:input path="name" id="name" cssClass="w-100 form-control border-0 py-3 shadow-sm bg-white rounded" placeholder="Your Name" />
                                <form:errors path="name" cssClass="text-danger small" />
                            </div>
                            
                            <div class="col-lg-12">
                                <label for="email" class="form-label fw-bold text-secondary">이메일</label>
                                <form:input path="email" id="email" cssClass="w-100 form-control border-0 py-3 shadow-sm bg-white rounded" placeholder="Your Email" />
                                <form:errors path="email" cssClass="text-danger small" />
                            </div>

                            <div class="col-lg-12 mt-4">
                                <button type="submit" class="w-100 btn form-control btn-primary border-0 py-3 text-white rounded-pill shadow-sm fw-bold">수정 완료</button>
                            </div>
                        </div>
                    </form:form>
                    
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../common/footer.jsp" />
<jsp:include page="../common/scripts.jsp" />

<%-- 🌟 [가장 중요] 새로 분리해서 만든 member.js 파일을 여기서 불러옵니다 --%>
<script src="${pageContext.request.contextPath}/js/member/update.js"></script>