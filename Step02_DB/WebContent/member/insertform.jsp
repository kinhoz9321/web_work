<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/member/insertform.jsp</title>
<link rel="stylesheet" href="../css/bootstrap.css" />
</head>
<body>
	<div class="container">
		<h1>회원 추가 폼 입니다.</h1>
		<form action="insert.jsp" method="post">
			이름<input type="text" name="name"/>
			주소<input type="text" name="addr"/>
			<button type="submit">추가</button>
		</form>
	</div>
</body>
</html>