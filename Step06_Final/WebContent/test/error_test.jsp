<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/test/error_test.jsp</title>
</head>
<body>
	<%
		//"myName" 이라는 이름의 파라미터가 넘어오지 않기 때문에 null 이다.
		String myName=request.getParameter("myName");
	
		//null 이기 때문에 myName.length() 는 NullPointerException 을 발생시킨다.
		//500번 오류가 발생한다.
		int length=myName.length();
	%>
</body>
</html>