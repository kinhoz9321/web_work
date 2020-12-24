<%@page import="test.member.dao.MemberDao"%>
<%@page import="test.member.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/member/updateform.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<%
	//1. 수정할 회원의 번호를 읽어온다
	int num=Integer.parseInt(request.getParameter("num"));
	//2. DB에서 해당회원의 정보를 얻어온다.
	MemberDto dto=MemberDao.getInstance().getData(num);
	//3. 수정 form 에 기본 값으로 넣어주면서 응답한다.
%>
</head>
<body>
<jsp:include page="../include/navbar.jsp"></jsp:include>
<div class="container">
	<nav>
		<ul class="breadcrumb">
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath}">Home</a>
			</li>
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath}/member/list.jsp">회원목록</a>
			</li>
			<li class="breadcrumb-item">회원정보 수정 폼</li>
		</ul>
	</nav>
	<form action="update.jsp" method="post">
		<!-- 아래 2줄 중요하니까 자세히 살피기! -->
		<!-- 회원정보를 수정 반영할 때 번호도 필요하기 때문에 폼 제출될 때 같이 제출되도록 한다. -->
		<div class="form-group">
			<label for="num">번호</label>
			<input class="form-control" type="hidden" name="num" value="<%=dto.getNum()%>"/>
			<input class="form-control" type="text" value="<%=dto.getNum()%>"disabled/><br />
		</div>
		<div class="form-group">
			<label for="name">이름</label>
			<input class="form-control" type="text" name="name" value="<%=dto.getName()%>"/><br />
		</div>
		<div class="form-group">
			<label for="addr">주소</label>
			<input class="form-control" type="text" name="addr" value="<%=dto.getAddr()%>"/>
		</div>
		<!-- 
		수정 form에 기본값은 value 속성으로 넣어준다. 
		수정하다 취소 누르면 기본값으로 돌아옴.
		-->
		<button class="btn btn-success" type="submit">수정확인</button>
		<button class="btn btn-danger" type="reset">취소</button>
	</form>
</div>
</body>
</html>