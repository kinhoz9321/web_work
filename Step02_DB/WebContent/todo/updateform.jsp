<%@page import="test.todo.dao.TodoDao"%>
<%@page import="test.todo.dto.TodoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/todo/updateform.jsp</title>
<link rel="stylesheet" href="../css/bootstrap.css" />
<%
	//수정할 할 일 번호를 읽어온다
	int num=Integer.parseInt(request.getParameter("num"));
	//수정할 할일 정보를 DB로부터 얻어온다.
	TodoDao dao=TodoDao.getInstance();
	TodoDto dto=dao.getData(num);
	//수정 폼을 응답한다.
%>
</head>
<body>
	<%--
	<div class="container">
	<h1>회원 정보 수정 폼 입니다.</h1>
		<form action="update.jsp" method="post">
			<!-- 번호가 바뀌어서는 안되니까 Hidden 처리. display용. -->
				<input type="hidden" name="num" value="<%=dto.getNum()%>"/><br />
				번호<input type="text" value="<%=dto.getNum() %>" disabled/><br />
			할일<input type="text" name="content" value="<%=dto.getContent() %>" ><br />
			<input type="hidden" name="regdate" value="<%=dto.getRegdate() %>" /><br />
			날짜<input type="text" value="<%=dto.getRegdate() %>" disabled/><br />
			<button type="submit">수정 확인</button>
			<button type="reset">취소</button>
		</form>
	</div>
	--%>
	<div class="container">
		<h1>할일 수정 폼입니다.</h1>
		<form action="update.jsp" method="post">
		
			<input type="hidden" name="num" value="<%=dto.getNum()%>"/>
			<label for="num">번호</label>
			<input type="text" id="num" value="<%=dto.getNum()%>" disabled/><br />
			
			<label for="content">할 일</label>
			<input type="text" name="content" id="content" value="<%=dto.getContent()%>"/><br />
			
			<label for="regdate">날짜</label>
			<input type="text" id="regdate" value="<%=dto.getRegdate()%>" disabled/>
			
			<button type="submit">수정 확인</button>
			<button type="reset">취소</button>
		</form>
	</div>
</body>
</html>