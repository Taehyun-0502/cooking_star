<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>맛집 검색</title>

<style>
    .restaurant-container {
        max-width: 900px;
        margin: 40px auto;
        padding: 24px;
    }

    .search-box {
        display: flex;
        gap: 8px;
        margin-bottom: 24px;
    }

    .search-input {
        flex: 1;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 6px;
    }

    .search-btn {
        padding: 10px 18px;
        border: none;
        border-radius: 6px;
        background-color: #0d6efd;
        color: #fff;
        cursor: pointer;
    }

    .restaurant-card {
        border: 1px solid #e5e5e5;
        border-radius: 10px;
        padding: 18px;
        margin-bottom: 14px;
        background-color: #fff;
    }

    .restaurant-title {
        font-size: 20px;
        font-weight: 700;
        margin-bottom: 8px;
    }

    .restaurant-info {
        color: #555;
        margin-bottom: 4px;
    }

    .place-link {
        color: #0d6efd;
        text-decoration: none;
        font-weight: 600;
    }
</style>
</head>

<body>

<div class="restaurant-container">

    <h1>맛집 검색</h1>

    <form action="/spot/search" method="get" class="search-box">
        <input type="text"
               name="query"
               class="search-input"
               value="${query}"
               placeholder="예: 강남역 맛집, 홍대 파스타, 수원역 카페">

        <button type="submit" class="search-btn">검색</button>
    </form>

    <c:choose>
        <c:when test="${not empty list}">
            <c:forEach items="${list}" var="spot">
                <div class="restaurant-card">

                    <div class="restaurant-title">
                        <c:out value="${spot.placeName}" />
                    </div>

                    <div class="restaurant-info">
                        지번 주소:
                        <c:out value="${spot.addressName}" />
                    </div>

                    <div class="restaurant-info">
                        전화번호:
                        <c:out value="${spot.phone}" />
                    </div>

                    <a href="${spot.placeUrl}" target="_blank" class="place-link">
                        카카오맵에서 보기
                    </a>
	
	<button type="button" class="spotBtn" 
	data-place-name="${spot.placeName}" data-address-name="${spot.addressName}" 
	data-phone="${spot.phone}" data-url="${spot.placeUrl}">내 맛집 리스트에 추가</button>


                </div>
            </c:forEach>
        </c:when>

        <c:otherwise>
            <p>검색어를 입력하면 맛집 결과가 표시됩니다.</p>
        </c:otherwise>
    </c:choose>

</div>
<script src="/js/spot/spotAdd.js"></script>
</body>
</html>