<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>레시피 검색 결과</title>
    <!-- 부트스트랩을 연결해줘야 카드가 예쁘게 나옵니다 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

    <div class="container mt-5">
        <h2 class="mb-4">
            <span class="text-primary">'${searchQuery}'</span> 레시피 검색 결과
        </h2>
        <hr>

        <!-- [중요] JS가 데이터를 뿌려줄 장소입니다. -->
        <!-- 컨트롤러에서 보낸 searchQuery를 data-query 속성에 저장합니다. -->
        <div id="recipeResult" class="row g-4" data-query="${searchQuery}">
            <div class="text-center py-5">
                <div class="spinner-border text-primary" role="status"> </div>
                
            </div>
        </div>
    </div>

    <!-- 우리가 만든 JS 파일 연결 (경로 확인 필수!) -->
    <script src="/js/result.js"></script>
</body>
</html>