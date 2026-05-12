<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>디테일페이지</h1>
	<table class="table">
		<thead class="thead-dark">
			<!-- 제목은 힌번 나오면 됨 -->
			<tr>
				<th>글번호</th>
				<th>제목</th>
				<th>내용</th>
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
					<td>${d.recipeTitle}</td>
					<td>${d.recipeContents}</td>
					<td>${d.username}</td>
					<td>${d.recipeGood}</td>
					<td>${d.recipeHit}</td>
					<td>${d.recipeDate}</td>
				</tr>
			<img src="/files/${name}/${d.recipeFileDTO.fileName}">

			</c:forEach>

		</tbody>
	</table>

</body>
</html>