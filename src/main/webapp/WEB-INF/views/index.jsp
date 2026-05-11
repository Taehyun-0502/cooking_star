<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>HOME </h1>
	
	<a href="/member/join">회원 가입</a>
	<a href="/member/login">로그인</a>
<%-- 	<sec:authorize access="isAutenticated()"> --%>
	<a href="/myrecipe/create">개인 레시피 작성</a>
	
	<%-- </sec:authorize> --%>
	
	
</body>
</html>