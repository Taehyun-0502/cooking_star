<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>FOLLOWING LIST</h1>

	<table>
		<thead>
			<tr>
				<th>팔로잉 목록</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${following}" var="d">
				<tr>

					<td><a href="/member/user?username=${d.followingUser}"> ${d.followingUser}</a></td>

				</tr>
			</c:forEach>
		</tbody>

	</table>






</body>
</html>