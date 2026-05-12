<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원가입</h1>
			
			<form:form  modelAttribute="memberDTO" method="post" enctype="multipart/form-data">
				<div>
					<label>아이디</label>
					<form:input path="username" id="username"/>
					<form:errors path="username"></form:errors>
				</div>
				<div>
					<label>비밀번호</label>
					<form:password path="password" id="password"/>
					<form:errors path="password"></form:errors>
				</div>
				<div>
					<label>비밀번호 확인</label>
					<form:password path="passwordCheck" id="passwordCheck"/>
					<form:errors path="passwordCheck"></form:errors>
				</div>
			
				<div>
					<label>이름</label>
					<form:input path="name" id="name"/>
					<form:errors path="name"></form:errors>
				</div>
				<div>
					<label>이메일</label>
					<form:input path="email"  id="email" />
					<form:errors path="email"></form:errors>
				</div>
			<div class="form-group">
				<label for="file">profile</label>
				<input type="file" class="form-control-file" id="attach"name="attach">
			</div>
			
			<button type="submit" >회원 가입</button>
			</form:form>
			





</body>
</html>