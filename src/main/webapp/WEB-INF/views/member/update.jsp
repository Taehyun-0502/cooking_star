<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
		<h1>수정 폼</h1>
			<form:form method="post" enctype="multipart/form-data" modelAttribute="memberDTO">
				
				<div>
					
					<form:hidden  path="username" id="username" />
					
				</div>		


				<div>
					<label>name</label>
					<form:input path="name" id="name" />
					<form:errors path="name"></form:errors>
				</div>
				
				<div>
					<label>email</label>
					<form:input path="email" id="email"/>
					<form:errors path="email"></form:errors>			
				</div>
			
				<button type="submit">수정하기</button>
			
			
			
			</form:form>


</body>
</html>