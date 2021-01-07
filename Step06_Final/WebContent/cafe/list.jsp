<%@page import="test.cafe.dto.CafeDto"%>
<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
CafeDto dto=new CafeDto();
List<CafeDto> list=CafeDao.getInstance().getList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/list.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="cafe" name="thisPage"/>
</jsp:include>
<div class="container">
	<nav>
		<ul class="breadcrumb">
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath}">Home</a>
			</li>
			<li class="breadcrumb-item">글 목록 보기</li>
		</ul>
	</nav>
</div>
<div class="container">
	<button class="btn btn-success">
		<a href="private/insertform.jsp" style="color:white">새글 작성</a>
	</button>
	<table class="table">
		<thead class="table-warning">
			<tr class="text-center">
				<th>글번호</th>
				<th>작성자</th>
				<th>제목</th>
				<th>조회수</th>
				<th>등록일</th>
			</tr>
		</thead>
		<tbody>
		<%for(CafeDto tmp:list){ %>
			<tr>
				<td class="text-center"><%=tmp.getNum() %></td>
				<td class="text-center"><%=tmp.getWriter() %></td>
				<td class="text-center"><a href="detail.jsp?num=<%=tmp.getNum()%>" style="color:black"><%=tmp.getTitle() %></a></td>
				<td class="text-center"><%=tmp.getViewCount() %></td>
				<td class="text-center"><%=tmp.getRegdate() %></td>
			</tr>
		<%} %>
		</tbody>
	</table>
	<button class="btn btn-warning">
		<a href="${pageContext.request.contextPath}/index.jsp" style="color:white">인덱스로 돌아가기</a>
	</button>
</div>
</body>
</html>
<%--
<td><a href="detail.jsp?num=<%=tmp.getNum()%>"></a><%=tmp.getTitle() %></td>
detail.jsp?num=1
1번 글 자세히 보기 요청을 하면 이런 요청이 될 수 있다.
--%>