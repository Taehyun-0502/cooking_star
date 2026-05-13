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
	<h1>저장한 레시피</h1>
	
	<table>
		<thead>
			<tr>
				<th>레시피 제목</th>
				<th>레시피 링크</th>
			</tr>
		</thead>
		<tbody>
						<c:forEach items="${list}" var="d">
			<tr>
				
					
							<td><h3>${d.searchTitle}</h3></td>
							<td><a href="${d.link}" target="_blank" rel="noopener noreferrer"> ${d.link}</a></td>
							<td><button type="button" class="linkBtn" data-num="${d.searchNum}">삭제</button></td>

					
							
			</tr>
						</c:forEach>	
		</tbody>
	
	</table>
	
	
	
	<script src="/js/search/delete.js"></script>

</body>
</html>