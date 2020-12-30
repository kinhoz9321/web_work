<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//add.jsp?name=xxx&addr=xxx 형식으로 전송된 파라미터 추출하기
	String name=request.getParameter("name");
	String addr=request.getParameter("addr");
	System.out.println("이름:"+name+" 주소:"+addr);
	
%>
added!