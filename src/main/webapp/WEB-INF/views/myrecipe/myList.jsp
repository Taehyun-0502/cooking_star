<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>list Page</h1>

	<div>
		<form action="./myList" method="get">
			<div class="input-group mb-3">
				<div>
					<select name="kind" class="custom-select">
						<option ${pager.kind eq 'v1'?'selected':''} value="v1"
							class="dropdown-item">Title</option>
						<option ${pager.kind eq 'v2'?'selected':''} value="v2"
							class="dropdown-item">Writer</option>
					</select> <input type="text" value="${pager.search}" name="search">
					<button type="submit" id="">검색</button>
				</div>
				</div>
				</form>
				<table class="table">
					<thead class="thead-dark">
						<!-- 제목은 힌번 나오면 됨 -->
						<tr>
							<th>글번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>좋아요</th>
							<th>조회수</th>
							<th>작성일</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach items="${dto}" var="d">
							<!-- 포이치 반복문 돌리는것 리스트에서꺼낸걸 d라는변수에 담자-->

							<tr>
								<td>${d.recipeNum}</td>
								<td><a href="/myrecipe/detail?recipeNum=${d.recipeNum}">${d.recipeTitle}</a></td>
								<td>${d.username}</td>
								<td>${d.recipeGoodCount}</td>
								<td>${d.recipeHit}</td>
								<td>${d.recipeDate}</td>
								</tr>

						</c:forEach>

					</tbody>
				</table>
				<a href="/myrecipe/create">
				<button type="button">레시피 작성</button>
				</a>

				<ul class="pagination">
					<li class="page-item ${pager.pre?'':'disabled'}"><a
						class="page-link"
						href="./mylList?page=${pager.pre?pager.start-1:pager.start}&search=${pager.search}&kind=${pager.kind}"
						aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
					</a></li>
					<c:forEach begin="${pager.start}" end="${pager.end}" var="i">
						<li class="page-item"><a class="page-link"
							href="./mylList?page=${i}&search=${pager.search}&kind=${pager.kind}">${i}</a></li>
					</c:forEach>
					<li class="page-item  ${pager.next?'':'disabled'}"><a
						class="page-link"
						href="./mylList?page=${pager.next?pager.end+1:pager.end}&kind=${pager.kind}&search=${pager.search}"
						aria-label="Next"> <span aria-hidden="true">&raquo;</span>
					</a></li>
				</ul></body>
</html>