<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원가입</h1>
			
			
			<form action="/member/join" method="post" enctype="multipart/form-data">
			
			<div>
				<label>아이디</label>
				<input type="text" name="username" id="username">
			</div>
			<div>
				<label>비밀번호</label>
				<input type="password" name="password" id="password">
			</div>
			<div>
				<label>비밀번호 확인</label>
				<input type="password" name="passwordCheck" id="passwordCheck">
			</div>
			<div>
				<label>이름</label>
				<input type="text" name="name" id="name">
			</div>
			<div>
				<label>이메일</label>
				<input type="email" name="email" id="email">
			</div>
			
			<div class="form-group">
				<label for="file">profile</label>
				<input type="file" class="form-control-file" id="attach"name="attach">
			</div>
			
			
			
			<button type="submit" >회원 가입</button>
			
			
			
			</form>





</body>
</html>