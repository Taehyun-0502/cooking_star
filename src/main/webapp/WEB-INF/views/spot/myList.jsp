<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 맛집 리스트</title>

<style>
    .spot-container {
        max-width: 1000px;
        margin: 40px auto;
        padding: 24px;
    }

    .page-title {
        font-size: 28px;
        font-weight: 700;
        margin-bottom: 24px;
        border-bottom: 1px solid #eee;
        padding-bottom: 16px;
    }

    .spot-list {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        gap: 18px;
    }

    .spot-card {
        border: 1px solid #e5e5e5;
        border-radius: 12px;
        padding: 20px;
        background-color: #fff;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.04);
    }

    .spot-name {
        font-size: 20px;
        font-weight: 700;
        margin-bottom: 10px;
        color: #222;
    }

    .spot-info {
        font-size: 14px;
        color: #555;
        margin-bottom: 8px;
        line-height: 1.5;
    }

    .spot-actions {
        display: flex;
        justify-content: flex-end;
        gap: 8px;
        margin-top: 16px;
    }

    .btn {
        padding: 8px 12px;
        border-radius: 6px;
        border: none;
        text-decoration: none;
        cursor: pointer;
        font-size: 14px;
    }

    .btn-map {
        background-color: #0d6efd;
        color: white;
    }

    .btn-delete {
        background-color: #dc3545;
        color: white;
    }

    .empty-box {
        padding: 40px;
        text-align: center;
        color: #777;
        background-color: #f8f8f8;
        border-radius: 12px;
    }

    .top-actions {
        display: flex;
        justify-content: flex-end;
        margin-bottom: 20px;
    }

    .btn-search {
        background-color: #198754;
        color: white;
    }
</style>
</head>

<body>

<div class="spot-container">

    <h1 class="page-title">내 맛집 리스트</h1>

    <div class="top-actions">
        <a href="${pageContext.request.contextPath}/spot/search" class="btn btn-search">
            맛집 검색하러 가기
        </a>
    </div>

    <c:choose>
        <c:when test="${not empty myList}">
            <div class="spot-list">

                <c:forEach items="${myList}" var="spot">
                    <div class="spot-card">

                        <div class="spot-name">
                            <c:out value="${spot.placeName}" />
                        </div>

                        <div class="spot-info">
                            <strong>주소:</strong>
                            <c:out value="${spot.addressName}" />
                        </div>

                        <div class="spot-info">
                            <strong>전화번호:</strong>
                            <c:choose>
                                <c:when test="${not empty spot.phone}">
                                    <c:out value="${spot.phone}" />
                                </c:when>
                                <c:otherwise>
                                    등록된 전화번호 없음
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="spot-actions">
                            <a href="${spot.placeUrl}"
                               target="_blank"
                               class="btn btn-map">
                                지도 보기
                            </a>

                            <form action="${pageContext.request.contextPath}/spot/delete"
                                  method="post"
                                  onsubmit="return confirm('이 맛집을 리스트에서 삭제하시겠습니까?');"
                                  style="display:inline;">

                                <input type="hidden" name="spotNum" value="${spot.spotNum}">

                                <c:if test="${not empty _csrf}">
                                    <input type="hidden"
                                           name="${_csrf.parameterName}"
                                           value="${_csrf.token}">
                                </c:if>

                                <button type="submit" class="btn btn-delete">
                                    삭제
                                </button>
                            </form>
                        </div>

                    </div>
                </c:forEach>

            </div>
        </c:when>

        <c:otherwise>
            <div class="empty-box">
                아직 저장한 맛집이 없습니다.
            </div>
        </c:otherwise>
    </c:choose>

</div>

</body>
</html>