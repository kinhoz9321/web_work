<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/member/insertform.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../include/navbar.jsp"></jsp:include>
<div class="container">
	<nav><!-- 현재 어디에 있는지 확인할 수 있는 navbar -->
		<ul class="breadcrumb"><!-- breadcrumb(빵부스러기 이동경로) Home/회원목록 이렇게 출력됨 -->
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath}">Home</a>
			</li>
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath}/member/list.jsp">회원목록</a>
			</li>
			<li class="breadcrumb-item active">회원 추가 폼</li><!-- depth(페이지 깊이) 추가 -->
		</ul>
	</nav>
	<form action="insert.jsp" method="post">
		<div class="form-group">
			<label for="name">이름</label>
			<input class="form-control" type="text" name="name" id="name"/>
			<small class="form-text text-muted">이름을 예쁘게 적으세요</small>
		</div>
		<div class="form-group">
			<label for="addr">주소</label>
			<input type="text" name="addr" id="addr" class="form-control" />
			<small class="form=text text-muted">실제 사는 주소를 작성하세요</small>
		</div>
		<button class="btn btn-success" type="submit">추가</button>
	</form>
</div>
</body>
</html>