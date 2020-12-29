<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//1. 폼 전송되는 아이디와 비밀번호를 읽어온다.
	String id=request.getParameter("id");
	String pwd=request.getParameter("pwd");
	
	//2. DB 에 해당 회원 정보가 있는지 select 해 본다.
	boolean isValid=false; //유효한 정보인지 여부
	// 아이디  : gura , 비밀번호 : 1234 가 DB에 저장된 유효한 정보라고 가정해 보자
	if(id.equals("gura") && pwd.equals("1234")){//둘다 일치해야지만 확인가능하기 때문에 && 사용
		isValid=true;
		//로그인 했다는 의미에서 session scope 에 "id" 라는 키값으로 로그인된 아이디를 담는다.
		session.setAttribute("id", id);
	}
	//3. 회원 정보가 맞으면 로그인 처리 후 응답, 틀리면 로그인 실패 라고 응답
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/test/login.jsp</title>
</head>
<body>
<%if(isValid){ %>
	<p>
		<strong><%=id %></strong> 회원님 로그인 되었습니다.
		<a href="${pageContext.request.contextPath}/index.jsp">확인</a>
	</p>
<%}else{ %>
	<p>
		아이디 혹은 비밀번호가 틀렸습니다.
		<a href="${pageContext.request.contextPath}/index.jsp">다시 시도</a>
	</p>
<%} %>
</body>
</html>