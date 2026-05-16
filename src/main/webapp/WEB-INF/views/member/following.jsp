<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar.jsp" />

<!-- Single Page Header start -->
<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">팔로잉 목록</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/member/mypage">My Page</a></li>
        <li class="breadcrumb-item active text-white">Following</li>
    </ol>
</div>
<!-- Single Page Header End -->

<!-- Following List Start -->
<div class="container-fluid contact py-5">
    <div class="container py-5">
        <div class="p-5 bg-light rounded">
            <div class="row g-4 justify-content-center">
                <div class="col-lg-8">
                    <div class="bg-white p-4 rounded shadow-sm">
                        <h4 class="mb-4 text-dark border-bottom pb-3">내가 팔로우하는 유저</h4>
                        <div class="table-responsive">
                            <table class="table">
                                <thead class="bg-light">
                                    <tr>
                                        <th scope="col">아이디</th>
                                        <th scope="col" class="text-end">프로필 이동</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${following}" var="d">
                                        <tr>
                                            <td>
                                                <p class="mb-0 mt-2 font-weight-bold text-dark">${d.followingUser}</p>
                                            </td>
                                            <td class="text-end">
                                                <a href="/member/user?username=${d.followingUser}" class="btn border-secondary rounded-pill px-4 py-2 text-primary bg-white shadow-sm">
                                                    <i class="fas fa-user me-2"></i>방문하기
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty following}">
                                        <tr>
                                            <td colspan="2" class="text-center py-5 text-muted">팔로잉하는 유저가 없습니다.</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="text-center mt-5">
                        <a href="/member/mypage" class="btn border-secondary py-3 px-5 rounded-pill text-primary bg-white shadow-sm">
                            <i class="fas fa-arrow-left me-2"></i>마이페이지로 돌아가기
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Following List End -->

<jsp:include page="../common/footer.jsp" />
<jsp:include page="../common/scripts.jsp" />
