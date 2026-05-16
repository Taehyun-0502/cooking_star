<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar.jsp" />

<script src="https://js.tosspayments.com/v1/payment"></script>

<!-- Single Page Header start -->
<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">장바구니</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
        <li class="breadcrumb-item active text-white">Cart</li>
    </ol>
</div>
<!-- Single Page Header End -->

<!-- Cart Page Start -->
<div class="container-fluid py-5">
    <div class="container py-5">
        <h2 class="mb-4 text-primary"><i class="fas fa-shopping-cart me-2"></i>장바구니</h2>

        <div class="row g-4">
            <div class="col-lg-8">
                <c:set var="totalPrice" value="0" />

                <c:if test="${empty list}">
                    <div class="bg-light rounded p-5 text-center">
                        <p class="text-muted mb-4">장바구니가 비어 있습니다.</p>
                        <a href="/cart/search" class="btn border border-secondary rounded-pill px-4 py-2 text-primary bg-white">상품 보러 가기</a>
                    </div>
                </c:if>

                <c:forEach items="${list}" var="d">
                    <c:set var="totalPrice" value="${totalPrice + (d.productPrice * d.productEa)}" />
                    <div class="bg-light rounded p-4 mb-3 product-card">
                        <div class="row align-items-center g-4">
                            <div class="col-md-2 text-center">
                                <img src="${d.productImg}" class="img-fluid rounded" alt="상품 이미지" style="width: 100px; height: 100px; object-fit: cover;">
                            </div>

                            <div class="col-md-4">
                                <div class="h5 mb-2">${d.productName}</div>
                                <div class="small text-muted">무료 배송</div>
                            </div>

                            <div class="col-md-4 text-center">
                                <div class="text-primary fw-bold mb-2">
                                    <span class="price-value" data-price="${d.productPrice}">
                                        <fmt:formatNumber value="${d.productPrice}" pattern="#,###"/>
                                    </span>원
                                </div>

                                <div class="input-group input-group-sm m-auto" style="width: 110px;">
                                    <input type="number" class="form-control text-center product-ea" value="${d.productEa}" min="1">
                                </div>

                                <div class="small text-muted mt-2">
                                    소계: <span class="product-subtotal fw-bold">
                                        <fmt:formatNumber value="${d.productPrice * d.productEa}" pattern="#,###"/>원
                                    </span>
                                </div>
                            </div>

                            <div class="col-md-2 text-md-end text-center">
                                <button class="btn btn-sm border border-secondary rounded-pill px-3 text-primary bg-white delete-btn" data-num="${d.cartNum}">
                                    <i class="fas fa-trash me-1"></i>삭제
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <div class="col-lg-4">
                <div class="bg-light rounded p-4 border position-sticky" style="top: 120px;">
                    <h4 class="mb-4">결제 정보</h4>
                    <div class="d-flex justify-content-between mb-2">
                        <span>총 상품 금액</span>
                        <span id="total-price-display">
                            <fmt:formatNumber value="${totalPrice}" pattern="#,###"/>원
                        </span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span>배송비</span>
                        <span class="text-success fw-bold">무료</span>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-between mb-4">
                        <span class="fw-bold">총 결제 예정 금액</span>
                        <span id="final-price-display" class="h4 fw-bold text-danger">
                            <fmt:formatNumber value="${totalPrice}" pattern="#,###"/>원
                        </span>
                    </div>
                    <button type="button" id="payment-btn" class="btn btn-primary w-100 btn-lg shadow">결제하기</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Cart Page End -->

<jsp:include page="../common/footer.jsp" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/cart/cartList.js"></script>
<jsp:include page="../common/scripts.jsp" />
