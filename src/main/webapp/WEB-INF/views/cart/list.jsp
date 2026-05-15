<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <meta charset="UTF-8">
    <title>나의 장바구니</title>
    <style>
        .cart-img { width: 100px; height: 100px; object-fit: cover; border-radius: 8px; }
        .product-name { font-size: 1.1rem; font-weight: bold; }
        .price-text { color: #e44d26; font-weight: bold; }
        .summary-box { background-color: #f8f9fa; border-radius: 10px; padding: 20px; position: sticky; top: 20px; }
        .subtotal-text { font-size: 0.9rem; color: #666; margin-top: 5px; }
    </style>
</head>
<body class="bg-light">
<script src="https://js.tosspayments.com/v1/payment"></script>
<div class="container mt-5 mb-5">
    <h2 class="mb-4"><i class="fas fa-shopping-cart"></i> 장바구니</h2>

    <div class="row">
        <div class="col-lg-8">
            <c:set var="totalPrice" value="0" />
            
            <c:if test="${empty list}">
                <div class="card p-5 text-center">
                    <p class="text-muted">장바구니가 비어 있습니다.</p>
                    <a href="/product/list" class="btn btn-outline-primary m-auto" style="width: 200px;">상품 보러 가기</a>
                </div>
            </c:if>

            <c:forEach items="${list}" var="d">
                <c:set var="totalPrice" value="${totalPrice + (d.productPrice * d.productEa)}" />
                <div class="card mb-3 shadow-sm product-card"> <div class="card-body">
                        <div class="row align-items-center">
                            <div class="col-md-2 text-center">
                                <img src="${d.productImg}" class="cart-img" alt="상품 이미지">
                            </div>
                            
                            <div class="col-md-4">
                                <div class="product-name">${d.productName}</div>
                                <div class="small text-muted">무료 배송</div>
                            </div>
                            
                            <div class="col-md-4 text-center">
                                <div class="price-text mb-2">
                                    <span class="price-value" data-price="${d.productPrice}">
                                        <fmt:formatNumber value="${d.productPrice}" pattern="#,###"/>
                                    </span>원
                                </div>
                                
                                <div class="input-group input-group-sm m-auto" style="width: 110px;">
                                    <input type="number" class="form-control text-center product-ea" value="${d.productEa}" min="1">
                                </div>
                                
                                <div class="subtotal-text">
                                    소계: <span class="product-subtotal font-weight-bold">
                                        <fmt:formatNumber value="${d.productPrice * d.productEa}" pattern="#,###"/>원
                                    </span>
                                </div>
                            </div>
                            
                            <div class="col-md-2 text-right">
                                <button class="btn btn-sm btn-outline-danger delete-btn" data-num="${d.cartNum}">
                                    <i class="fas fa-trash"></i> 삭제
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="col-lg-4">
            <div class="summary-box shadow-sm border">
                <h4 class="mb-4">결제 정보</h4>
                <div class="d-flex justify-content-between mb-2">
                    <span>총 상품 금액</span>
                    <span id="total-price-display">
                        <fmt:formatNumber value="${totalPrice}" pattern="#,###"/>원
                    </span>
                </div>
                <div class="d-flex justify-content-between mb-2">
                    <span>배송비</span>
                    <span class="text-success font-weight-bold">무료</span>
                </div>
                <hr>
                <div class="d-flex justify-content-between mb-4">
                    <span class="font-weight-bold">총 결제 예정 금액</span>
                    <span id="final-price-display" class="h4 font-weight-bold text-danger">
                        <fmt:formatNumber value="${totalPrice}" pattern="#,###"/>원
                    </span>
                </div>
                <button type="button" id="payment-btn" class="btn btn-primary btn-block btn-lg shadow">결제하기</button>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/js/cart/cartList.js"></script> 
</body>
</html>