<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한글 인코딩 처리 (중요!)
	//request.setCharacterEncoding("utf-8");
	String msg=request.getParameter("msg");
	System.out.println("클라이언트가 전송한 문자열 :"+msg);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/test/tweet.jsp</title>
</head>
<body>
	<p>전송된 문자열 : <strong><%=msg %></strong></p>
</body>
</html>