<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>나의 구매 내역</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .table thead { background-color: #343a40; color: white; }
        .product-img { width: 60px; height: 60px; object-fit: cover; border-radius: 5px; }
        .order-card { border-radius: 15px; overflow: hidden; }
        .status-badge { font-size: 0.8rem; padding: 5px 10px; border-radius: 20px; }
    </style>
</head>
<body class="bg-light">

<div class="container mt-5 mb-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="fas fa-receipt text-primary"></i> 나의 구매 내역</h2>
        <a href="/" class="btn btn-outline-secondary btn-sm">메인으로 돌아가기</a>
    </div>

    <div class="card shadow-sm order-card">
        <div class="card-body p-0">
            <table class="table table-hover mb-0">
                <thead>
                    <tr class="text-center">
                        <th>주문번호</th>
                        <th>상품명</th>
                        <th>단가</th>
                        <th>수량</th>
                        <th>총 결제금액</th>
                        <th>상태</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${empty list}">
                        <tr>
                            <td colspan="6" class="text-center p-5">
                                <i class="fas fa-box-open fa-3x text-muted mb-3"></i>
                                <p class="text-muted">구매하신 내역이 없습니다.</p>
                                <a href="/cart/search" class="btn btn-primary">쇼핑하러 가기</a>
                            </td>
                        </tr>
                    </c:if>

                    <c:forEach items="${list}" var="buy">
                        <tr class="text-center align-middle">
                            <td class="align-middle">#${buy.buyNum}</td>
                            <td class="text-left align-middle font-weight-bold">
                                ${buy.productName}
                            </td>
                            <td class="align-middle">
                                <fmt:formatNumber value="${buy.productPrice}" pattern="#,###"/>원
                            </td>
                            <td class="align-middle">${buy.productEa}개</td>
                            <td class="align-middle text-danger font-weight-bold">
                                <fmt:formatNumber value="${buy.buyPrice}" pattern="#,###"/>원
                            </td>
                            <td class="align-middle">
                                <span class="badge badge-success status-badge">결제완료</span>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    
    <div class="mt-4 p-4 bg-white border rounded shadow-sm d-flex justify-content-between align-items-center">
        <div>
            <h5 class="mb-1">재료가 도착했나요?</h5>
            <p class="text-muted mb-0 small">나만의 멋진 레시피를 요리자랑 게시판에 공유해보세요!</p>
        </div>
        <a href="/mycooking/create" class="btn btn-warning font-weight-bold text-white">요리자랑 하러가기</a>
    </div>
</div>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    // 서버에서 온 메시지를 전역 변수에 담아 JS 파일로 전달합니다.
    const serverMessage = "${msg}";
</script>
<script src="/js/buylist/list.js"></script>
</body>
</html>