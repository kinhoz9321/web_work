<%@page import="test.todo.dao.TodoDao"%>
<%@page import="test.member.dao.MemberDao"%>
<%@page import="test.todo.dto.TodoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/todo/insert.jsp</title>
<link rel="stylesheet" href="../css/bootstrap.css" />
<%
	//한글이 깨지지 않도록
	request.setCharacterEncoding("utf-8");
	//폼 전송되는 파라미터 추출
	String content=request.getParameter("content");
	//DB에 저장할 내용을 Dto에 담는다
	TodoDto dto=new TodoDto();
	dto.setContent(content);
	//Dao를 이용해서 DB에 저장한다.
	TodoDao dao=new TodoDao();
	boolean isSuccess=dao.insert(dto);//new TodoDao().insert(dto);
	
	//결과를 응답한다.
%>
</head>
<body>
<%--
	<%if(isSuccess){ %>
		<p>회원 1명의 정보를 추가했습니다</p><a href="list.jsp">확인</a>
	<%}else{ %>
		<p>회원 정보 추가 실패! <a href="insertform.jsp">다시 입력하기</a></p>
	<%} %>
--%>
	<%if(isSuccess){ %>
		<script>
			location.href="list.jsp";
		</script>
		<!-- 순간적으로 /todo/insert.jsp를 거쳐서 /todo/list.jsp로 간다 -->
	<%}else{ %>
		
		<p>글자 수가 너무 많습니다. <a href="list.jsp">목록으로 돌아가기</a></p>
	<%} %>
</body>
</html>