<%@page import="test.member.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/test/member.jsp</title>
</head>
<body>
<%
	//request 객체에 "dto"라는 키값으로 저장된 MemberDto 객체의 참조값 얻어오기
	MemberDto dto=(MemberDto)request.getAttribute("dto");
//서블릿을 안거쳤기 때문에 dto=null 널포인트익셉션 발생 500번 탐.
%>
<p> 회원 정보 </p>
<p>번호 : <%=dto.getNum() %></p>
<p>이름 : <%=dto.getName() %></p>
<p>주소 : <%=dto.getAddr() %></p>
</body>
</html>