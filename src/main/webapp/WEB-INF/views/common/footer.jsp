<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Footer Start -->
<div class="container-fluid bg-dark text-white-50 footer pt-5 mt-5">
    <div class="container py-5">
        <div class="pb-4 mb-4" style="border-bottom: 1px solid rgba(226, 175, 24, 0.5) ;">
            <div class="row g-4 align-items-center">
                <div class="col-lg-6">
                    <a href="${pageContext.request.contextPath}/">
                        <h1 class="text-primary mb-0">Cooking Star</h1>
                        <p class="text-secondary mb-0">Delicious Recipes</p>
                    </a>
                </div>
                <div class="col-lg-6">
                    <div class="row g-3 justify-content-lg-end">
                        <div class="col-sm-6">
                            <div class="footer-stats-card border rounded text-center p-4 shadow-sm">
                                <h5 class="mb-3">전체 회원 수</h5>
                                <p class="display-6 fw-bold mb-0">
                                    ${totalMemberCount}
                                </p>
                            </div>
                        </div>

                        <div class="col-sm-6">
                            <div class="footer-stats-card border rounded text-center p-4 shadow-sm">
                                <h5 class="mb-3">오늘 방문자 수</h5>
                                <p class="display-6 fw-bold mb-0">
                                    ${todayVisitCount}
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row g-5">
            <div class="col-lg-4 col-md-6">
                <div class="footer-item">
                    <h4 class="text-light mb-3">About Cooking Star</h4>
                    <p class="mb-4">세상의 모든 레시피와 맛집 정보를 공유하는 요리 커뮤니티입니다. 나만의 요리를 자랑하고 맛있는 레시피를 찾아보세요.</p>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="d-flex flex-column text-start footer-item">
                    <h4 class="text-light mb-3">Quick Links</h4>
                    <a class="btn-link" href="${pageContext.request.contextPath}/">Home</a>
                    <a class="btn-link" href="${pageContext.request.contextPath}/myrecipe/allList">레시피 모음</a>
                    <a class="btn-link" href="${pageContext.request.contextPath}/cart/search">Shop</a>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="d-flex flex-column text-start footer-item">
                    <h4 class="text-light mb-3">My Menu</h4>
                    <a class="btn-link" href="${pageContext.request.contextPath}/member/mypage">마이페이지</a>
                    <a class="btn-link" href="${pageContext.request.contextPath}/cart/list">장바구니</a>
                    <a class="btn-link" href="${pageContext.request.contextPath}/search/list">저장한 링크</a>
                    <a class="btn-link" href="${pageContext.request.contextPath}/spot/myList">내 맛집 리스트</a>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Footer End -->

<!-- Copyright Start -->
<div class="container-fluid copyright bg-dark py-4">
    <div class="container">
        <div class="row">
            <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                <span class="text-light"><a href="${pageContext.request.contextPath}/"><i class="fas fa-copyright text-light me-2"></i>Cooking Star</a>, All right reserved.</span>
            </div>
            <div class="col-md-6 my-auto text-center text-md-end text-white">
                Designed By <a class="border-bottom" href="https://htmlcodex.com">HTML Codex</a> Distributed By <a class="border-bottom" href="https://themewagon.com">ThemeWagon</a>
            </div>
        </div>
    </div>
</div>
<!-- Copyright End -->

<!-- Back to Top -->
<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>
