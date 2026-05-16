<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar.jsp" />

<!-- Single Page Header start -->
<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">마이페이지</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
        <li class="breadcrumb-item active text-white">My Page</li>
    </ol>
</div>
<!-- Single Page Header End -->

<!-- My Page Start -->
<div class="container-fluid contact py-5">
    <div class="container py-5">
        <div class="p-5 bg-light rounded">
            <div class="row g-4 justify-content-center">
                <div class="col-lg-8">
                    <div class="text-center mb-5">
                        <div class="position-relative mx-auto" style="width: 200px; height: 200px;">
                            <img class="img-fluid rounded-circle border border-5 border-white shadow-sm w-100 h-100" 
                                 style="object-fit: cover;"
                                 src="/files/${name}/${myProfile.profileDTO.fileName}" 
                                 alt="Profile Image">
                        </div>
                        <h2 class="mt-4 mb-2 text-dark font-weight-bold">${myProfile.name}</h2>
                        <p class="text-muted mb-4">${myProfile.email}</p>
                    </div>

                    <div class="row g-4 text-center mb-5">
                        <div class="col-6">
                            <a href="/member/follower" class="d-block p-4 bg-white rounded shadow-sm hover-zoom text-decoration-none">
                                <h3 class="text-primary display-6">${follower}</h3>
                                <p class="text-muted mb-0">Follower</p>
                            </a>
                        </div>
                        <div class="col-6">
                            <a href="/member/following" class="d-block p-4 bg-white rounded shadow-sm hover-zoom text-decoration-none">
                                <h3 class="text-primary display-6">${following}</h3>
                                <p class="text-muted mb-0">Following</p>
                            </a>
                        </div>
                    </div>

                    <div class="text-center">
                        <a href="/member/update" class="btn border-secondary py-3 px-5 rounded-pill text-primary bg-white shadow-sm">
                            <i class="fas fa-user-edit me-2"></i>정보 수정
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- My Page End -->

<jsp:include page="../common/footer.jsp" />
<jsp:include page="../common/scripts.jsp" />
