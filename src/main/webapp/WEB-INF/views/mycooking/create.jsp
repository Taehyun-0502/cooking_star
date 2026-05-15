<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c"  uri="jakarta.tags.core"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>요리자랑 글 작성 폼</h1>
	
		<form action="/mycooking/create" method="post" enctype="multipart/form-data">
				<div>
					<label>글 제목</label>
					<input type="text" name="cookingTitle" id="cookingTitle"/>
					
				</div>
				<div>
					<label>요리 참조 레시피</label>
					<input type="text" name="cookingRecipe" id="cookingRecipe"/>
					
				</div>
				<div>
					<label>글 내용</label>
					<textarea type="text" name="cookingContents" id="cookingContents">
					</textarea>
				</div>
			<div>
				<button type="button" id="add">file add</button>
			</div>
			
			<div class="form-group" id="fileform" data-file-size="0">
			<span>첫번째 사진이 홈페이지에서 출력됩니다</span>
				<!-- <label for="file">음식 사진</label>
				<input type="file" class="form-control-file" id="attach"name="attach"> -->
			</div>
			
			<button type="submit" >글 등록</button>
			</form>
	
	<script src="/js/mycooking/fileCreate.js"></script>
	<c:if test="${not empty errorMessage}">
    <script>
        alert("${errorMessage}");
    </script>
</c:if>
</body>
</html>