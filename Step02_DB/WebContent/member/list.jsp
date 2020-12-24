<%@page import="test.member.dto.MemberDto"%>
<%@page import="test.member.dao.MemberDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//MemberDao 객체를 이용해서 회원 목록을 얻어온다.
	List<MemberDto> list=MemberDao.getInstance().getList();
	//여기 있는 내용을 반복문 돌면서 table row를 얻어내면 된다.
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/member/list.jsp</title>
<link rel="stylesheet" href="../css/bootstrap.css" />
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
</head>
<body>
<%-- 
<!-- container 밖으로 navbar 빼기 -->
<nav class="navbar navbar-dark bg-primary navbar-expand-sm">
<!-- navbar-expand-sm 목록을 예쁘게 나열해줌 -->
	<!-- 
	navbar 안에 새로운 div class="container" 생성 
	navbar 는 화면 전체를 차지하고 안에 내용은 container 만큼 차지해서 정렬됨.
	-->
	<div class="container">
		<nav class="navbar navbar-dark bg-primary navbar-expand-sm">
			<a class="navbar-brand" href="${pageContext.request.contextPath}/">Acorn</a>
			<!-- 
			http://localhost:8888/Step02_DB/ 최상위 경로만 써도 아파치 서버가 index.jsp를 찾아준다. 
			index.jsp가 없으면 404가 뜸.
			-->
			<ul class="navbar-nav">
				<li class="nav-item">
					<!-- 가급적이면 절대경로를 쓸 것. context 경로 걸기. cpath+tab -->
					<a class="nav-link" href="${pageContext.request.contextPath}/member/list.jsp">회원목록</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="${pageContext.request.contextPath}/todo/list.jsp">할일목록</a>
				</li>
			</ul>
		</nav>
	</div>
</nav>
--%>
<jsp:include page="../include/navbar.jsp"></jsp:include>
<div class="container">
	<a href="insertform.jsp">회원 추가 하러가기</a>
	<a href="../index.jsp">인덱스 페이지로 돌아가기</a>
	<h1>회원 목록입니다.</h1>
	<table class="table">
		<thead class="table-dark">
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>주소</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
			<%for(MemberDto tmp:list){ %>
				<tr>
					<td><%=tmp.getNum() %></td>
					<td><%=tmp.getName() %></td>
					<td><%=tmp.getAddr() %></td>
					<td><a href="updateform.jsp?num=<%=tmp.getNum()%>">수정</a></td>
					<td><a href="delete.jsp?num=<%=tmp.getNum()%>">삭제</a></td>
					<!-- get방식 parameter를 들고가야 하는 수정, 삭제 -->
				</tr>
			<%} %>
		</tbody>
	</table>
		<!-- 반복문 돌면서 list의 방의 사이즈 만큼 내용을 찍어낸다. for문 코드 이해하기 
		여기서 주의할 것 for문의 {}
		참조되는 내용 그대로 출력할 때는 <//%= 을 사용하기
		-->
</div>
</body>
</html>