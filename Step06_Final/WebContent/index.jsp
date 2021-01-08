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
<jsp:include page="include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="include/navbar.jsp"></jsp:include>
<div class="container">
	<%-- 만일 id 가 null 이 아니면 로그인을 한 상태이다. --%>
	<%if(id!=null){ %>
		<div>
			<a href="users/private/info.jsp" style="color:orange"><%=id %></a>님 로그인 중
			<button class="btn btn-outline-danger btn-sm">
				<a href="users/logout.jsp" style="color:red">로그아웃</a>
			</button>
		</div>
	<%} %>
	<ul class="list-group">
		<li class="list-group-item"><a href="users/signup_form.jsp" style="color:black">회원가입</a></li>
		<li class="list-group-item"><a href="users/loginform.jsp" style="color:black">로그인</a></li>
		<li class="list-group-item"><a href="cafe/list.jsp" style="color:black">카페 글 목록 보기</a></li>
		<li class="list-group-item"><a href="file/list.jsp" style="color:black">자료실 목록 보기</a></li>
	</ul>
</div>
</body>
</html>