<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>user page </h1>
		<c:if test="${loginUser ne targetuser}">
			<button type="button" id="followBtn" data-user="${targetuser}" data-follow="${isFollow}">
				<c:choose>
					<c:when test="${isFollow>0}">
						언 팔로우
					</c:when>
					<c:otherwise>
						팔로우		
					</c:otherwise>
				</c:choose>
			</button>
		</c:if>
		<table>
			<thead>
				<tr>
					<th>레시피 글 번호</th>
					<th>레시피 제목</th>
				</tr>
			</thead>
			
			<tbody>
	<c:forEach items="${list}" var="d">
				<tr>
					
	
	<td>${d.recipeNum}</td>
	<td><a href="/myrecipe/detail?recipeNum=${d.recipeNum}">${d.recipeTitle}</a></td>
	
	
					
					
				</tr>
	</c:forEach>
			</tbody>
			
		
		</table>
		
		


<script src="/js/follow/follow.js"></script>

</body>
</html>