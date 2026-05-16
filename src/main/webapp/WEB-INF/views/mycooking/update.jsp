<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar.jsp" />

<!-- Single Page Header start -->
<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">요리 자랑 수정</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/mycooking/myList">My Cooking</a></li>
        <li class="breadcrumb-item active text-white">Update</li>
    </ol>
</div>
<!-- Single Page Header End -->

<!-- My Cooking Update Start -->
<div class="container-fluid contact py-5">
    <div class="container py-5">
        <div class="p-5 bg-light rounded">
            <div class="row g-4">
                <div class="col-12 text-center mx-auto" style="max-width: 700px;">
                    <h1 class="text-primary">요리 자랑 수정</h1>
                    <p class="mb-4">작성한 요리 자랑 글과 사진을 수정해 보세요.</p>
                </div>

                <div class="col-lg-9 mx-auto">
                    <form action="./update" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="cookingNum" value="${dto.cookingNum}">

                        <div class="mb-3">
                            <label class="form-label" for="cookingTitle">제목</label>
                            <input type="text"
                                id="cookingTitle" name="cookingTitle" class="w-100 form-control border-0 py-3 mb-4"
                                value="${dto.cookingTitle}">
                        </div>

                        <div class="mb-3">
                            <label class="form-label" for="cookingContents">요리 소개</label>
                            <textarea id="cookingContents" name="cookingContents"
                                class="w-100 form-control border-0 py-3 mb-4" style="min-height: 180px;">${dto.cookingContents}</textarea>
                        </div>

                        <div class="mb-4">
                            <label class="form-label" for="cookingRecipe">참고 레시피</label>
                            <textarea id="cookingRecipe" name="cookingRecipe"
                                class="w-100 form-control border-0 py-3 mb-4" style="min-height: 140px;">${dto.cookingRecipe}</textarea>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">기존 이미지</label>

                            <c:choose>
                                <c:when test="${not empty dto.list}">
                                    <div class="row g-4">
                                        <c:forEach items="${dto.list}" var="file">
                                            <div class="col-md-6 col-lg-4 image-item">
                                                <div class="border rounded bg-white p-3 h-100">
                                                    <div class="overflow-hidden rounded mb-3 bg-light" style="aspect-ratio: 1/1;">
                                                        <img class="img-fluid w-100 h-100"
                                                            src="${pageContext.request.contextPath}/files/${name}/${file.fileName}"
                                                            alt="요리 이미지"
                                                            style="object-fit: cover;">
                                                    </div>

                                                    <label class="d-flex align-items-center gap-2 mb-0 text-muted">
                                                        <input type="checkbox"
                                                            class="delete-file-check"
                                                            name="deleteFileNums"
                                                            value="${file.fileNum}">
                                                        이미지 삭제
                                                    </label>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:when>

                                <c:otherwise>
                                    <div class="bg-white rounded p-4 text-center text-muted">
                                        등록된 이미지가 없습니다.
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="mb-4">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <label class="form-label mb-0">새 이미지 추가</label>
                                <button type="button" id="add-file-btn" class="btn btn-detail"
                                    style="margin-top: 10px;">이미지 추가</button>
                            </div>

                            <div id="new-file-area">
                            </div>

                            <div id="file-count-message"
                                style="margin-top: 8px; color: #666; font-size: 14px;">최대
                                5장까지 등록할 수 있습니다.</div>
                        </div>

                        <div class="d-flex justify-content-end gap-2 border-top pt-4">
                            <a href="/" class="btn btn-list">목록</a>
                            <a href="./detail?cookingNum=${dto.cookingNum}" class="btn btn-detail">취소</a>

                            <button type="submit" class="btn btn-submit">수정 완료</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- My Cooking Update End -->

<jsp:include page="../common/footer.jsp" />
<script src="${pageContext.request.contextPath}/js/mycooking/updateFileCreate.js"></script>
<c:if test="${not empty errorMessage}">
    <script>
        alert("${errorMessage}");
    </script>
</c:if>
<jsp:include page="../common/scripts.jsp" />
