<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/private/play.jsp</title>
</head>
<body>
	<%
	//로그인된 아이디 읽어오기
	String id=(String)session.getAttribute("id");
	%>
	<p><strong><%=id %></strong> 님 신나게 놀아 보아요!</p>
	<a href="../index.jsp">인덱스로 가기</a>
</body>
</html>
<!-- 
로그인이 되었을 때 동작하는 페이지
로그인을 안하면 정상동작을 안한다.
 -->