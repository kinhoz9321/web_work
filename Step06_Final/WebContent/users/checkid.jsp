<%@page import="test.users.dao.UsersDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//inputId 라는 파라미터로 전달되는 문자열 읽어오기
	String inputId=request.getParameter("inputId");
	System.out.println("inputId:"+inputId);
	
	//DB에서 가입된 아이디가 이미 존재하는지 여부를 얻어낸다.
	boolean isExist=UsersDao.getInstance().isExist(inputId);
	
	//클라이언트에게 응답하기
%>
<%-- 
문자열이 불편하다
<%if(isExist){%>
	이미 존재 하는 아이디 입니다.
<%}else{ %>
	사용 가능한 아이디 입니다.
<%}%>
--%>
{"isExist":<%=isExist %>}
<%-- 
{"isExist":true} or {"isExist":false}

contentType="application/json; 으로 컨텐트 타입을 바꿔서 사용하면
오브젝트로 응답된다. 파싱할 필요가 없음.
contentType="text/html" 은 파싱 필요.
 --%>