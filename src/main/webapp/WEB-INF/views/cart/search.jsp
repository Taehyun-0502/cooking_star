<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1 class="mt-5">상품 검색</h1>
    
    <form action="./search" method="get" class="mb-4">
        <input type="text" name="query" placeholder="검색어를 입력하세요" value="${param.query}" class="form-control d-inline-block w-50">
        <button type="submit" class="btn btn-primary">검색</button>
    </form> 

    
    <c:forEach items="${list}" var="d">
    <div class="card mb-3" style="max-width: 540px;">
        <div class="row no-gutters align-items-center">
            <div class="col-md-4">
                <img src="${d.productImg}" class="card-img p-2" alt="상품 이미지" 
                     style="height: 150px; object-fit: cover;">
            </div>
            <div class="col-md-8">
                <div class="card-body">
                    <h6 class="card-title font-weight-bold">${d.productName}</h6>
                    
                    <p class="small text-muted mb-1">* 해당 상품명에 표기된 최소 무게 기준 최저가입니다.</p>
                    
                    <p class="card-text text-danger font-weight-bold mb-2">
                        <fmt:formatNumber value="${d.productPrice}" pattern="#,###"/>원
                    </p>

                    <div class="input-group input-group-sm mb-2" style="width: 150px;">
                        <div class="input-group-prepend">
                            <span class="input-group-text">수량</span>
                        </div>
                        <input type="number" class="form-control product-ea" value="1" min="1">
                    </div>

                    <button type="button" class="btn btn-sm btn-success add-cart-btn" 
                            data-name="${d.productName}" 
                            data-price="${d.productPrice}" 
                            data-img="${d.productImg}">
                        장바구니 담기
                    </button>
                </div>
            </div>
        </div>
    </div>
</c:forEach>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/js/cart/cart.js"></script>
</body>
</html>