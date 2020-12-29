<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/index.jsp</title>
</head>
<body>
	<h1>인덱스 페이지 입니다.</h1>
	<form action="test/tweet.jsp" method="post">
		<input type="text" name="msg" placeholder="서버에 할 말 입력"/>
		<button type="submit">전송</button>
	</form>
	<%
		//로그인된 아이디가 있는지 읽어와 보기 (로그인했으면 gura 안했으면 null)
		String id=(String)session.getAttribute("id");
	%>
	
	<%if(id==null){ %>
	
		<h2>가상의 로그인 폼</h2>
		<form action="test/login.jsp" method="post">
			<input type="text" name="id" placeholder="아이디"/>
			<input type="password" name="pwd" placeholder="비밀번호"/>
			<button type="submit">로그인</button>
		</form>
	
	<%}else{ %>
		<!-- 신기하다! -->
		<p>
			<strong><%=id %></strong> 님 로그인 중...
			<a href="test/logout.jsp">로그아웃</a>
		</p>
	<%} %>
	<ul>
		<li><a href="private/play.jsp">놀러 가기(로그인 필요)</a></li>
		<li><a href="private/study.jsp">공부하러 가기(로그인 필요)</a></li>
	</ul>
</body>
</html>
<!-- 
우리가 경험했던 페이지를 직접 만들어보기
로그인을 해야만 들어갈 수 있다던가,
로그인을 하고 나서 누구님 어서오세요, 누구님 같이 공부해봐요 등.. 닉네임이나 아이디 계속 쫓아다니는거라던가..
신기함!


 -->