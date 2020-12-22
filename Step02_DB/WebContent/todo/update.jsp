<%@page import="test.todo.dao.TodoDao"%>
<%@page import="test.member.dao.MemberDao"%>
<%@page import="test.todo.dto.TodoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/todo/update.jsp</title>
<link rel="stylesheet" href="../css/bootstrap.css" />
<%--
	request.setCharacterEncoding("utf-8");
	int num=Integer.parseInt(request.getParameter("num"));
	String content=request.getParameter("content");
	String regdate=request.getParameter("regdate");
	TodoDto dto=new TodoDto();
	dto.setNum(num);
	dto.setContent(content);
	dto.setRegdate(regdate);
	TodoDao dao=new TodoDao();
	boolean isSuccess=dao.update(dto);
--%>
<%
	//인코딩 설정
	request.setCharacterEncoding("utf-8");
	//수정할 할일번호, 내용을 읽어온다.
	int num=Integer.parseInt(request.getParameter("num"));
	String content=request.getParameter("content");
	//Dto 에 담고
	TodoDto dto=new TodoDto();
	dto.setNum(num);
	dto.setContent(content);
	//DB에 수정 반영
	TodoDao dao=TodoDao.getInstance();
	boolean isSuccess=dao.update(dto);	
	//응답
%>

</head>
<body>
<div class="container">
	<%if(isSuccess){ %>
		<p>
			<strong><%=num %></strong> 번 할일을 수정했습니다.
			<a href="list.jsp">목록보기</a>
		</p>
	<%}else{ %>
		<p>
			수정 실패!
			<a href="updateform.jsp?num=<%=num%>">다시 작성</a>
		</p>
	<%} %>
</div>
	
</body>
</html>