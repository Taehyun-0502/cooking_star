<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/navbar.jsp" />

<!-- Single Page Header start -->
<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">레시피 모음</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
        <li class="breadcrumb-item active text-white">Recipes</li>
    </ol>
</div>
<!-- Single Page Header End -->

<!-- Fruits Shop Start-->
<div class="container-fluid fruite py-5">
    <div class="container py-5">
        <div class="row g-4">
            <div class="col-lg-12">
                <div class="row g-4">
                    <div class="col-xl-3">
                        <form action="./allList" method="get" id="searchForm">
                            <div class="input-group w-100 mx-auto d-flex">
                                <select name="kind" class="form-select border-0 bg-light py-3">
                                    <option ${pager.kind eq 'v1'?'selected':''} value="v1">제목</option>
                                    <option ${pager.kind eq 'v2'?'selected':''} value="v2">작성자</option>
                                    <option ${pager.kind eq 'v3'?'selected':''} value="v3">카테고리</option>
                                    <option ${pager.kind eq 'v4'?'selected':''} value="v4">재료</option>
                                </select>
                                <input type="text" name="search" value="${pager.search}" class="form-control p-3" placeholder="keywords" aria-describedby="search-icon-1">
                                <button type="submit" id="search-icon-1" class="input-group-text p-3"><i class="fa fa-search"></i></button>
                            </div>
                        </form>
                    </div>
                    <div class="col-6"></div>
                    <div class="col-xl-3 text-end">
                        <a href="${pageContext.request.contextPath}/myrecipe/create" class="btn border-secondary py-3 px-4 rounded-pill text-primary bg-white">
                            <i class="fas fa-edit me-2"></i>레시피 작성
                        </a>
                    </div>
                </div>
                
                <div class="row g-4 mt-2">
                    <div class="col-lg-12">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">글번호</th>
                                        <th scope="col">카테고리</th>
                                        <th scope="col">제목</th>
                                        <th scope="col">작성자</th>
                                        <th scope="col">좋아요</th>
                                        <th scope="col">조회수</th>
                                        <th scope="col">작성일</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${dto}" var="d">
                                        <tr>
                                            <td><p class="mb-0 mt-4">${d.recipeNum}</p></td>
                                            <td><p class="mb-0 mt-4">${d.recipeCategory}</p></td>
                                            <td><p class="mb-0 mt-4"><a href="/myrecipe/detail?recipeNum=${d.recipeNum}">${d.recipeTitle}</a></p></td>
                                            <td><p class="mb-0 mt-4">${d.username}</p></td>
                                            <td><p class="mb-0 mt-4">${d.recipeGoodCount}</p></td>
                                            <td><p class="mb-0 mt-4">${d.recipeHit}</p></td>
                                            <td><p class="mb-0 mt-4">${d.recipeDate}</p></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                    <div class="col-12">
                        <div class="pagination d-flex justify-content-center mt-5">
                            <a href="./allList?page=${pager.pre?pager.start-1:pager.start}&search=${pager.search}&kind=${pager.kind}" 
                               class="rounded ${pager.pre ? '' : 'disabled'}">&laquo;</a>
                            
                            <c:forEach begin="${pager.start}" end="${pager.end}" var="i">
                                <a href="./allList?page=${i}&search=${pager.search}&kind=${pager.kind}" 
                                   class="rounded">${i}</a>
                            </c:forEach>
                            
                            <a href="./allList?page=${pager.next?pager.end+1:pager.end}&kind=${pager.kind}&search=${pager.search}" 
                               class="rounded ${pager.next ? '' : 'disabled'}">&raquo;</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Fruits Shop End-->

<jsp:include page="../common/footer.jsp" />
<jsp:include page="../common/scripts.jsp" />