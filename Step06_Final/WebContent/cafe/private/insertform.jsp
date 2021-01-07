<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/private/insertform.jsp</title>
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
			<li class="breadcrumb-item">새 글 작성</li>
		</ul>
	</nav>
</div>
<div class="container">
	<form action="insert.jsp" method="post">
		<div class="form-group">
			<label for="title">제목</label>
			<input class="form-control" type="text" name="title" id="title"/>
		</div>
		<div class="form-group">
			<label for="content">내용</label>
			<textarea class="form-control" name="content" id="content" ></textarea>
		</div>
		<button class="btn btn-success" type="submit">저장</button>
		<button class="btn btn-danger"><a href="${pageContext.request.contextPath}/cafe/list.jsp" style="color:white">취소</a></button>
	</form>
</div>
</body>
</html>