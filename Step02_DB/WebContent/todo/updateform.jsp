<%@page import="test.todo.dao.TodoDao"%>
<%@page import="test.todo.dto.TodoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/todo/updateform.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
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
<jsp:include page="../include/navbar.jsp"></jsp:include>
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
	<nav>
		<ul class="breadcrumb">
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath}">Home</a>
			</li>
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath}/member/list.jsp">할일목록</a>
			</li>
			<li class="breadcrumb-item">할일목록 수정 폼</li>
		</ul>
	</nav>
	<form action="update.jsp" method="post">
		<div class="form-group">
			<label for="num">번호</label>
			<input class="form-control" type="hidden" name="num" value="<%=dto.getNum()%>"/>
			<input class="form-control" type="text" id="num" value="<%=dto.getNum()%>" disabled/><br />
		</div>
		<div class="form-group">
			<label for="content">할일</label>
			<input class="form-control" type="text" name="content" id="content" value="<%=dto.getContent()%>"/><br />
		</div>
		<div class="form-group">
			<label for="regdate">날짜</label>
			<input class="form-control" type="text" id="regdate" value="<%=dto.getRegdate()%>" disabled/><br />
		</div>
			<button class="btn btn-success" type="submit">수정 확인</button>
			<button class="btn btn-danger" type="reset">취소</button>
		</form>
	</div>
</body>
</html>