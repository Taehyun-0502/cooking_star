<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar.jsp" />

<!-- Single Page Header start -->
<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">상품 검색</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
        <li class="breadcrumb-item active text-white">Shop</li>
    </ol>
</div>
<!-- Single Page Header End -->

<!-- Product Search Start -->
<div class="container-fluid fruite py-5">
    <div class="container py-5">
        <div class="row g-4 mb-5">
            <div class="col-lg-8 mx-auto">
                <form action="./search" method="get" class="mb-4">
                    <div class="input-group">
                        <input type="text" name="query" placeholder="검색어를 입력하세요" value="${param.query}" class="form-control border-0 py-3">
                        <button type="submit" class="btn btn-primary">검색</button>
                    </div>
                </form>
            </div>
        </div>

        <div class="row g-4">
            <c:forEach items="${list}" var="d">
                <div class="col-md-6 col-lg-4">
                    <div class="card h-100 border border-secondary rounded product-card">
                        <img src="${d.productImg}" class="card-img-top p-3" alt="상품 이미지"
                             style="height: 220px; object-fit: cover;">

                        <div class="card-body d-flex flex-column">
                            <h6 class="card-title fw-bold">${d.productName}</h6>

                            <p class="small text-muted mb-2">상품명에 표시된 최소 무게 기준 최저가입니다.</p>

                            <p class="card-text text-primary fw-bold mb-3">
                                <fmt:formatNumber value="${d.productPrice}" pattern="#,###"/>원
                            </p>

                            <div class="input-group input-group-sm mb-3" style="width: 150px;">
                                <span class="input-group-text">수량</span>
                                <input type="number" class="form-control product-ea" value="1" min="1">
                            </div>

                            <button type="button" class="btn btn-sm btn-success add-cart-btn mt-auto"
                                    data-name="${d.productName}"
                                    data-price="${d.productPrice}"
                                    data-img="${d.productImg}">
                                장바구니 담기
                            </button>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<!-- Product Search End -->

<jsp:include page="../common/footer.jsp" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/cart/cart.js"></script>
<jsp:include page="../common/scripts.jsp" />
