<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//1. GET 방식 파라미터로 전달되는 수정할 글번호를 읽어온다.
	int num=Integer.parseInt(request.getParameter("num"));
	//2. 글번호를 이용해서 수정할 글정보를 DB 에서 읽어온다.
	CafeDto dto=CafeDao.getInstance().getData(num);
	//3. 글 수정 폼을 응답한다.
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cafe/private/updateform.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../../include/navbar.jsp">
	<jsp:param value="cafe" name="thisPage"/>
</jsp:include>
<div class="container">
	<nav>
		<ul class="breadcrumb">
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath}">Home</a>
			</li>
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath}/cafe/list.jsp">글 목록</a>
			</li>
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath}/cafe/detail.jsp">글 내용</a>
			</li>
			<li class="breadcrumb-item">글 수정</li>
		</ul>
	</nav>
</div>
<div class="container">
	<form action="update.jsp" method="post">
		<input class="form-control" type="hidden" name="num" value="<%=dto.getNum()%>"/>
		<div class="form-group">
			<label>작성자</label>
			<input class="form-control" type="text" value="<%=dto.getWriter() %>" disabled/>
		</div>
		<div class="form-group">
			<label for="title">제목</label>
			<input class="form-control" type="text" name="title" id="title" value="<%=dto.getTitle()%>"/>
		</div>
		<div class="form-group">
			<label for="content">내용</label>
			<textarea class="form-control" name="content" id="content"><%=dto.getContent() %></textarea>
		</div>
		<button type="submit" class="btn btn-success">수정</button>
		<button type="reset" class="btn btn-danger">취소</button>
	</form>
</div>
</body>
</html>