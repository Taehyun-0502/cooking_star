<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<h1>로그인</h1>
			
			<form action="/member/login" method="post">
			
				<div>
					<label>아이디</label>
					<input type="text" name="username" id="username" value="${cookie.rememberId.value}" />
					
				</div>
				<div>
					<label>비밀번호</label>
					<input type="password" name="password" id="password">
					
				</div>
				<div>
					<label>id 저장하기</label>
					<input type="checkbox" name="rememberId" value="1" id="rememberId" >
				</div>
			<button type="submit">로그인</button>
			
			</form>



</body>
</html>