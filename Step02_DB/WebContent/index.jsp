<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/index.jsp</title>
<link rel="stylesheet" href="css/bootstrap.css" />
</head>
<body>
<div class="container">
	<h1>인덱스 페이지 입니다.</h1>
	<ul>
		<li><a href="member/list.jsp">회원 목록 보기</a></li>
		<!-- 
		아래의 링크가 동작하도록 해보세요.
		목록보기, 추가, 수정, 삭제 기능을 모두 구현하세요.
		test.todo.dto
		test.todo.dao 패키지도 만들고 
		TodoDto, 
		TodoDao 도 만드세요.
		
		모두 구현후 bootstrap scc 도 모든 페이지에 적용 시켜 보세요.
		 -->
		<li><a href="todo/list.jsp">할일 목록 보기</a></li>
	</ul>
</div>
</body>
</html>