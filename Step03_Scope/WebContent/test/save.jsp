<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	/*
		요청 파라미터 (폼전송 혹은 GET 방식 전송)를 읽어낼 때는
		.getParameter() 메소드를 이용한다.
		.getAttribute() 메소드를 사용하는 실수들을 많이 합니다. setAttribute 를 읽어낼 때 사용.
		주의 바랍니당!!! 용도가 서로 다릅니다.
	*/
	String nick=request.getParameter("nick");
	
	//이번에는 응답하고 나서 페이지 이동을 해도 읽어낼 수 있도록 HttpSession 객체에 저장을 한다. session 기본 객체.
	//"nick"이라는 키값으로 String type 저장하기
	session.setAttribute("nick", nick);
	//60초 동안 어떤 요청도 하지 않으면 자동으로 삭제 되도록 설정
	session.setMaxInactiveInterval(60);
	/*
	*중요 익혀두기*
	session scope (세션 영역) 에 담은 데이터가 삭제 되는 경우는
	1. 새로운 요청을 하지 않고 30분이 경과 했을 때 (기본시간)
	2. 웹브라우저를 닫았을 때
	3. HttpSession 객체의 메소드를 이용해서 강제로 삭제 했을 때
	*/
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/test/save.jsp</title>
</head>
<body>
	<p><strong><%=nick %></strong>이라는 닉네임을 기억 하겠습니다.</p>
	<p>60초 동안 아무런 요청을 하지 않거나 웹브라우저를 닫으면 자동 삭제 됩니다.</p>
	<a href="../index.jsp">인덱스로 이동하기</a>
</body>
</html>