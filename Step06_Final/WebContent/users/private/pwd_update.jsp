<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// session scope 에서 수정할 회원의 아이디
	String id=(String)session.getAttribute("id");
	// 폼전송되는 파라미터에서 구 비밀번호, 새 비밀번호 읽어오기
	String pwd=request.getParameter("pwd");
	String newPwd=request.getParameter("newPwd");
	// DB 에 수정 반영하고 작업 성공 여부 확인하기
	UsersDto dto=new UsersDto();
	dto.setId(id);
	dto.setPwd(pwd);
	dto.setNewPwd(newPwd);
	boolean isSuccess=UsersDao.getInstance().updatePwd(dto);
	//응답하기
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/pwd_update.jsp</title>
</head>
<body>
<div class="container">
	<%if(isSuccess){ //비밀번호 수정 성공이면
		//다시 로그인 하도록 로그아웃 처리를 한다.
		session.removeAttribute("id");%>
		<p>
			<strong><%=id %></strong>비밀번호를 수정했습니다.
			<a href="${pageContext.request.contextPath}/users/loginform.jsp">다시 로그인 하기</a>
		</p>
	<%}else{ %>
		<p>
			이전 비밀번호가 일치 하지 않습니다.
			<a href="pwd_updateform.jsp">다시 시도</a>
		</p>
	<%} %>
</div>
</body>
</html>