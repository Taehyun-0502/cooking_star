<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Recipe 작성</h1>
	<form action="/myrecipe/create" method="post">
	<div>아이디<input type="text" name="username"> </div>
	<div>제목<input type="text" name="recipeTitle"> </div>
	<div>내용<input type="text" name="recipeContents"> </div>
	<div>좋아요<input type="text" name="recipeGood"> </div>
	<div>조회수<input type="text" name="recipeHit"> </div>
	<button type="submit">저장</button>
	</form>
</body>
</html>