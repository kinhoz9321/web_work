<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/test/delete.jsp</title>
</head>
<body>
<%
	//session scope 에 "nick" 이라는 키값으로 저장된 값 삭제하기
	session.removeAttribute("nick");
	//session scope 에 저장된 모든 값 삭제(초기화) 하기
	//session.invalidate();
%>
	<p>session scope 에 저장된 값을 삭제 했습니다.</p>
	<a href="../index.jsp">인덱스로 가기</a>
</body>
</html>