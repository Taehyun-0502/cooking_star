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
	<h1>FOLLOWER LIST</h1>
	<table>
		<thead>
			<tr>
				<th>팔로잉 목록</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${follower}" var="d">
				<tr>

					<td><a href="/member/user?username=${d.followerUser}"> ${d.followerUser}</a></td>

				</tr>
			</c:forEach>
		</tbody>

	</table>

	
</body>
</html>