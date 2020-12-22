<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/test/buy.jsp</title>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	/*
		/test/buy.jsp?num=999&type=ABC
		
		위와 같은 get 방식 요청 파라미트 추출하기
		num 이라는 파라미터명으로 999 라는 문자열과
		type 이라는 파라미터명으로 ABC 라는 문자열이 전송된다.
	*/
	//읽어온 파라미터를 숫자로 바꾸고 싶으면 아래와 같이 바꾸면 된다. *자주사용*
	int num=Integer.parseInt(request.getParameter("num"));
	
	//문자형식
	//String a=request.getParameter("num");
	String type=request.getParameter("type");
	System.out.println("num: "+num+"type: "+type);
	%>
	<p>구입하신 상품은 ABC 갯수는 999 개 입니다.</p>
	<p>구입하신 상품은 <%=type%> 갯수는 <%=num%> 개 입니다.</p>
</body>
</html>