<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index.jsp</title>
</head>
<body>
	<h1>인덱스 페이지 입니다.</h1>
	<ul>
		<li><a href="fortune">오늘의 운세</a></li>
		<li><a href="member">회원 한명의 정보 보기</a></li>
		<li><a href="test/fortune.jsp">서블릿을 거치지 않고 fortune.jsp</a></li>
		<li><a href="test/member.jsp">서블릿을 거치지 않고 member.jsp</a></li>
	</ul>
	<form action="test/save.jsp" method="post">
		<input type="text" name="nick" placeholder="닉네임 입력"/>
		<button type="submit">닉네임 기억 시키기</button>
	</form>
</body>
</html>
<!-- 
서블릿 거쳐가면 내용이 나오고,
jsp 직접가면 내용이 null임
이것은 리퀘스트에 담은 것은 응답하고 나면 사라진다는 것을 알아야 함.
 -->