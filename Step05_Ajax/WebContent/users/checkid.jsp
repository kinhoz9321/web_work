<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//ajax GET 방식 전송되는 입력한 아이디 읽어오기
	String inputId=request.getParameter("inputId");
	/*
		원래는 DAO 객체를 이용해서 회원 테이블을 검색해서
		해당 아이디가 이미 가입된 아이디인지 확인해야 하지만 테스트의 편의를 위해서
		"gura" 만 이미 회원 테이블에 존재한다고 가정하자.
	*/
	
	boolean isExist=false;
	//만일 입력한 아이디가 "gura" 라면
	if(inputId.equals("gura")){
		isExist=true; //이미 존재한다고 표시한다.
	}
		
%>
{"isExist":<%=isExist%>}

<%--
json
{"isExist":<%=isExist%>} =
{"isExist":true} or {"isExist":false}
--%>