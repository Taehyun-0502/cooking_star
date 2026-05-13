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
			
				<!-- 포이치 반복문 돌리는것 리스트에서꺼낸걸 d라는변수에 담자-->

				<tr>
					<td>${dto.recipeNum}</td>
					<td>${dto.recipeTitle}</td>
					<td>${dto.recipeContents}</td>
					<td><a href="/member/user?username=${dto.username}">${dto.username}</a></td>
					<td>${dto.recipeGood}</td>
					<td>${dto.recipeHit}</td>
					<td>${dto.recipeDate}</td>
				</tr>
			<div><img src="/files/${name}/${dto.recipeFileDTO.fileName}"></div>

			
				
		</tbody>
	</table>
		<a href="/myrecipe/update?recipeNum=${dto.recipeNum}"><button>수정</button></a>
		<a href="/myrecipe/allList"><button>리스트로 돌아가기</button></a>
		<button type="button" id="likeBtn">좋아요</button>
		<script src="/js/myRecipe/good.js"></script>
</body>
</html>