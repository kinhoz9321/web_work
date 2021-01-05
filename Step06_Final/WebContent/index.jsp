<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//session scope 에 "id" 라는 키값으로 저장된 문자열이 있는지 읽어와 본다.
	String id=(String)session.getAttribute("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/index.jsp</title>
</head>
<body>
<div class="container">
	<%-- 만일 id 가 null 이 아니면 로그인을 한 상태이다. --%>
	<%if(id!=null){ %>
		<p>
			<strong><%=id %></strong>님 로그인 중...
			<a href="users/logout.jsp">로그아웃</a>
		</p>
	<%} %>
	<h1>인덱스 페이지 입니다.</h1>
	<ul>
		<li><a href="users/signup_form.jsp">회원가입</a></li>
		<li><a href="users/loginform.jsp">로그인</a></li>
	</ul>
</div>
</body>
</html>