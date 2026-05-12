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

		<h1>MY PAGE</h1>
		
		
		<div>
			<table>
				<thead>
					<tr>
						<th>이름</th>
						<th>이메일</th>
					</tr>
				</thead>
				
				
				<tbody>
					<tr>
						<td>${myProfile.name}</td>
						<td>${myProfile.email}</td>
					</tr>
				
				</tbody>
				
			
			</table>
			<a href="/member/update">
			<button type="button">정보 수정</button>
			
			</a>
		
		</div>
		
		
		
</body>
</html>