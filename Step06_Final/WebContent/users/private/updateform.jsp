<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//세션 영역에 저장된 아이디를 이용해서 
	String id=(String)session.getAttribute("id");
	//DB 에 저장된 가입정보를 읽어온다. (dto 를 이용해서 input value에 가입 정보를 뿌려줘야 한다.)
	UsersDto dto=UsersDao.getInstance().getData(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/updateform.jsp</title>
</head>
<body>
<div class="container">
	<h1>가입정보 수정 폼 입니다.</h1>
	<form action="update.jsp" method="post">
		<div>
			<label for="id">아이디</label>
			<input type="text" id="id" value="<%=dto.getId() %>" disabled/><!-- dp용 -->
		</div>
		<div>
			<label for="pwd">비밀번호</label>
		</div>
		<div>
			<label for="email">이메일</label>
			<input type="text" id="email" name="email" value="<%=dto.getEmail()%>"/>
		</div>
		<button type="submit">수정</button>
		<button type="reset">취소</button>
	</form>
</div>
</body>
</html>