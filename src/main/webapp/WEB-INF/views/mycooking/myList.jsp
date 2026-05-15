<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 요리 자랑 글</title>

<style>
    .my-cooking-container {
        max-width: 1100px;
        margin: 40px auto;
        padding: 24px;
    }

    .page-title {
        font-size: 28px;
        font-weight: 700;
        margin-bottom: 24px;
        border-bottom: 1px solid #eee;
        padding-bottom: 16px;
        color: #222;
    }

    .top-actions {
        display: flex;
        justify-content: flex-end;
        margin-bottom: 24px;
    }

    .cooking-list {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
        gap: 20px;
    }

    .cooking-card {
        border: 1px solid #e5e5e5;
        border-radius: 12px;
        background-color: #fff;
        overflow: hidden;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.04);
    }

    .image-box {
        width: 100%;
        height: 190px;
        background-color: #f5f5f5;
        overflow: hidden;
    }

    .cooking-img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        display: block;
    }

    .no-image {
        height: 190px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #999;
        background-color: #f8f8f8;
        font-size: 14px;
    }

    .card-body {
        padding: 18px;
    }

    .cooking-title {
        font-size: 20px;
        font-weight: 700;
        margin-bottom: 10px;
        color: #222;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .cooking-content {
        font-size: 14px;
        color: #555;
        line-height: 1.6;
        height: 44px;
        overflow: hidden;
        margin-bottom: 12px;
    }

    .cooking-meta {
        font-size: 13px;
        color: #888;
        margin-bottom: 16px;
    }

    .card-actions {
        display: flex;
        justify-content: flex-end;
        gap: 8px;
    }

    .btn {
        padding: 8px 12px;
        border-radius: 6px;
        border: none;
        text-decoration: none;
        cursor: pointer;
        font-size: 14px;
    }

    .btn-detail {
        background-color: #0d6efd;
        color: #fff;
    }

    .btn-write {
        background-color: #198754;
        color: #fff;
    }

    .empty-box {
        padding: 60px 20px;
        text-align: center;
        color: #777;
        background-color: #f8f8f8;
        border-radius: 12px;
    }
</style>
</head>

<body>

<div class="my-cooking-container">

    <h1 class="page-title">내 요리 자랑 글</h1>

    <div class="top-actions">
        <a href="${pageContext.request.contextPath}/mycooking/create" class="btn btn-write">
            글 작성하기
        </a>
    </div>

    <c:choose>
        <c:when test="${not empty myList}">

            <div class="cooking-list">

                <c:forEach items="${myList}" var="dto">

                    <div class="cooking-card">

                        <a href="${pageContext.request.contextPath}/mycooking/detail?cookingNum=${dto.cookingNum}">

                            <c:choose>
                                <c:when test="${not empty dto.list}">
                                    <div class="image-box">
                                        <img class="cooking-img"
                                             src="${pageContext.request.contextPath}/files/mycooking/${dto.list[0].fileName}"
                                             alt="${dto.cookingTitle}">
                                    </div>
                                </c:when>

                                <c:otherwise>
                                    <div class="no-image">
                                        등록된 이미지가 없습니다.
                                    </div>
                                </c:otherwise>
                            </c:choose>

                        </a>

                        <div class="card-body">

                            <div class="cooking-title">
                                <c:out value="${dto.cookingTitle}" />
                            </div>

                            <div class="cooking-content">
                                <c:out value="${dto.cookingContents}" />
                            </div>

                            <div class="cooking-meta">
                                글번호: ${dto.cookingNum}
                                <br>
                                작성일: ${dto.cookingDate}
                            </div>

                            <div class="card-actions">
                                <a href="${pageContext.request.contextPath}/mycooking/detail?cookingNum=${dto.cookingNum}"
                                   class="btn btn-detail">
                                    상세보기
                                </a>
                            </div>

                        </div>

                    </div>

                </c:forEach>

            </div>

        </c:when>

        <c:otherwise>
            <div class="empty-box">
                아직 작성한 요리 자랑 글이 없습니다.
            </div>
        </c:otherwise>
    </c:choose>

</div>
<ul class="pagination">
					<li class="page-item ${pager.pre?'':'disabled'}"><a
						class="page-link"
						href="./myList?page=${pager.pre?pager.start-1:pager.start}"
						aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
					</a></li>
					<c:forEach begin="${pager.start}" end="${pager.end}" var="i">
						<li class="page-item"><a class="page-link"
							href="./myList?page=${i}">${i}</a></li>
					</c:forEach>
					<li class="page-item  ${pager.next?'':'disabled'}"><a
						class="page-link"
						href="./myList?page=${pager.next?pager.end+1:pager.end}"
						aria-label="Next"> <span aria-hidden="true">&raquo;</span>
					</a></li>
				</ul>
</body>
</html>