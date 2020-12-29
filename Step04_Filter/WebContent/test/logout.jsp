<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//1. 세션 영역에 "id"라는 키값으로 저장된 값을 삭제한다.
	session.removeAttribute("id");
	
	//2. 응답하기(특정 페이지(index.jsp)로 요청을 다시 하라고 리다일렉트 응답)
	/*
	request.getContextPath()는 프로젝트의 Context path명을 반환한다.

	요청 : http://localhost:8080/example/test.jsp 

	리턴값 : /example
	*/
	String cPath=request.getContextPath();
	response.sendRedirect(cPath+"/index.jsp");
	//웹브라우저에게 이 경로로 요청을 다시해 라고 지시하는 것. 결과적으로 페이지가 새로고침되는 효과가 된다. 리다일렉트 자체도 응답이다.
	/*
	forward 이동과 분명히 다름. 포워드는 서버내에서의 이동이고
	리다일렉트는 응답을 다시하라고 강요하는 것.
	리다일렉트도 구사할 줄 알아야 함.
	리다일렉트는 절대경로. 경로를 잘못작성하면 꼬임.
	
	이렇게 이동하는데 이 이동이 너무 빨라서 우리 눈에는 꼭 index.jsp 가 refresh(새로고침) 하는 것 처럼 보임. (logout.jsp 를 거치지 않고)
	/index.jsp (GET request)-> /test/logout.jsp (redirect move)-> /index.jsp
	*/
%>