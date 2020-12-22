<%@page import="test.todo.dao.TodoDao"%>
<%@page import="test.todo.dto.TodoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/todo/delete.jsp</title>
<link rel="stylesheet" href="../css/bootstrap.css" />
<%
	//삭제할 글번호를 읽어와서
	String num=request.getParameter("num");
	int strNum=Integer.parseInt(num);
	//int num=Integer.parseInt(request.getParameter("num"));
	
	//삭제하고
	TodoDto dto=new TodoDto();
	dto.setNum(strNum);
	
	TodoDao dao=new TodoDao();
	boolean isSuccess=dao.delete(dto);
	//boolean isSuccess=new TodoDao().delete(num);
	
	/* 
		웹브라우저에게 특정 경로로 요청을 다시 하라고 응답한다 (리다일렉트 응답)
		결과적으로
		<script>
			location.href="list.jsp";
		</script>
		를 로딩한것과 같게 동작된다.(이동이 더 빠르다.)
		요청을 다시하라고 강요하는 거 자체가 응답이다.
		response.sendRedirect(cPath+"/todo/list.jsp"); 이게 응답.
		
		이거 자체가 응답이기 때문에 html 마크업을 출력하지 않아도 됨. (맞는 것 익숙해지기.)
	*/
	
	String cPath=request.getContextPath(); //context path 읽어오기
	response.sendRedirect(cPath+"/todo/list.jsp"); //절대경로를 전달한다. 항상 절대 경로를 사용하기.
	//cPath = /Step02_DB 와 같다.
%>
</head>
<body>
	<%-- 
	<%if(isSuccess) {%>
		<p>할일 하나를 삭제 했습니다.</p><a href="list.jsp">확인</a>
	<%}else{ %>
		<p>할일 삭제 실패</p><a href="list.jsp">할일 목록으로 돌아가기</a>
	<%} %>
	--%>
</body>
</html>