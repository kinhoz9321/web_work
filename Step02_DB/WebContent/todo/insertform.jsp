<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/todo/insertform.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../include/navbar.jsp"></jsp:include>
<div class="container">
	<nav>
		<ul class="breadcrumb">
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath}">Home</a></li>
			<li class="breadcrumb-item">
			<a href="${pageContext.request.contextPath}/todo/list.jsp">할일목록</a></li>
			<li class="breadcrumb-item">할일 추가 폼</li>
		</ul>
	</nav>
	<form action="${pageContext.request.contextPath}/todo/insert.jsp" method="post">
	<!-- 될 수 있으면 모든 경로는 절대 경로로 쓰는 것이 좋다. -->
		<div class="form-group">
			<label for="content">할 일</label>
			<input class="form-control" type="text" name="name"/>
		</div>
		<button class="btn btn-success" type="submit">추가</button>		
	</form>
</div>
</body>
</html>