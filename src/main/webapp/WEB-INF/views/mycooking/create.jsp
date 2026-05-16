<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="jakarta.tags.core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar.jsp" />

<!-- Single Page Header start -->
<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">요리 자랑 글 작성</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/mycooking/myList">My Cooking</a></li>
        <li class="breadcrumb-item active text-white">Create</li>
    </ol>
</div>
<!-- Single Page Header End -->

<!-- My Cooking Create Start -->
<div class="container-fluid contact py-5">
    <div class="container py-5">
        <div class="p-5 bg-light rounded">
            <div class="row g-4">
                <div class="col-12 text-center mx-auto" style="max-width: 700px;">
                    <h1 class="text-primary">요리 자랑 글 등록</h1>
                    <p class="mb-4">나만의 요리와 사진을 공유해 보세요.</p>
                </div>

                <div class="col-lg-8 mx-auto">
                    <form action="/mycooking/create" method="post" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label class="form-label" for="cookingTitle">글 제목</label>
                            <input type="text" name="cookingTitle" id="cookingTitle" class="w-100 form-control border-0 py-3 mb-4"/>
                        </div>

                        <div class="mb-3">
                            <label class="form-label" for="cookingRecipe">요리 참고 레시피</label>
                            <input type="text" name="cookingRecipe" id="cookingRecipe" class="w-100 form-control border-0 py-3 mb-4"/>
                        </div>

                        <div class="mb-3">
                            <label class="form-label" for="cookingContents">글 내용</label>
                            <textarea type="text" name="cookingContents" id="cookingContents" class="w-100 form-control border-0 py-3 mb-4" style="min-height: 180px;">
                            </textarea>
                        </div>

                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <label class="form-label mb-0">요리 사진</label>
                            <button type="button" id="add" class="btn border-secondary rounded-pill px-4 text-primary bg-white">
                                <i class="fas fa-plus me-2"></i>file add
                            </button>
                        </div>

                        <div class="form-group bg-white rounded p-4 mb-4" id="fileform" data-file-size="0">
                            <span class="text-muted">첫 번째 사진이 대표 이미지로 사용됩니다.</span>
                            <!-- <label for="file">요리 사진</label>
                            <input type="file" class="form-control-file" id="attach"name="attach"> -->
                        </div>

                        <button type="submit" class="w-100 btn form-control border-secondary py-3 bg-white text-primary">글 등록</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- My Cooking Create End -->

<jsp:include page="../common/footer.jsp" />
<script src="${pageContext.request.contextPath}/js/mycooking/fileCreate.js"></script>
<c:if test="${not empty errorMessage}">
    <script>
        alert("${errorMessage}");
    </script>
</c:if>
<jsp:include page="../common/scripts.jsp" />
