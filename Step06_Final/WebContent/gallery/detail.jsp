<%@page import="test.gallery.dto.GalleryDto"%>
<%@page import="test.gallery.dao.GalleryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	GalleryDto dto=GalleryDao.getInstance().getData(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/gallery/detail.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="gallery" name="thisPage"/>
</jsp:include>
<div class="container">
	<nav>
		<ul class="breadcrumb">
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath}">Home</a>
			</li>
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath}/gallery/list.jsp">갤러리 목록</a>
			</li>
			<li class="breadcrumb-item">갤러리 상세보기</li>
		</ul>
	</nav>
</div>
<div class="container form-group">
	<table class="table table-bordered">
		<tr>
			<th>날짜</th>
			<td><%=dto.getRegdate() %></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><%=dto.getWriter() %></td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<div><%=dto.getCaption() %></div>
			</td>
		</tr>
		<tr>
			<th>올린 이미지</th>
			<td>
				<img src="${pageContext.request.contextPath}<%=dto.getImagePath() %>" />
			</td>
		</tr>
	</table>
	<%
		//session scope 에서 로그인된 아이디를 읽어와 본다. (null 일 수도 있음.)
		String id=(String)session.getAttribute("id");
	%>
	<button type="button" class="btn btn-warning" >
		<a href="list.jsp" style="color:white">목록보기</a>
	</button>
	<%if(dto.getWriter().equals(id)){ %>
	<button type="button" class="btn btn-success">
		<a href="private/updateform.jsp?num=<%=dto.getNum()%>" style="color:white">수정</a>
	</button>
	<button type="button" class="btn btn-danger">
		<a href="javascript:deleteConfirm()" style="color:white">삭제</a>
	</button>
	<%} %>
	<div class="text-center">
		<button class="btn btn-outline-primary ">
			<a style="color:blue" href="detail.jsp?num=<%=dto.getPrevNum()%>"><svg color="orange" width="13px" aria-hidden="true" focusable="false" data-prefix="fab" data-icon="octopus-deploy" class="svg-inline--fa fa-octopus-deploy fa-w-16" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="currentColor" d="M455.6,349.2c-45.891-39.09-36.67-77.877-16.095-128.11C475.16,134.04,415.967,34.14,329.93,8.3,237.04-19.6,134.252,24.341,99.677,117.147a180.862,180.862,0,0,0-10.988,73.544c1.733,29.543,14.717,52.97,24.09,80.3,17.2,50.161-28.1,92.743-66.662,117.582-46.806,30.2-36.319,39.857-8.428,41.858,23.378,1.68,44.478-4.548,65.265-15.045,9.2-4.647,40.687-18.931,45.13-28.588C135.9,413.388,111.122,459.5,126.621,488.9c19.1,36.229,67.112-31.77,76.709-45.812,8.591-12.572,42.963-81.279,63.627-46.926,18.865,31.361,8.6,76.391,35.738,104.622,32.854,34.2,51.155-18.312,51.412-44.221.163-16.411-6.1-95.852,29.9-59.944C405.428,418,436.912,467.8,472.568,463.642c38.736-4.516-22.123-67.967-28.262-78.695,5.393,4.279,53.665,34.128,53.818,9.52C498.234,375.678,468.039,359.8,455.6,349.2Z"></path></svg><svg color="blue" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-left" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8z"/>
</svg> Prev</a>
		</button>
		<button class="btn btn-outline-warning">
			<a style="color:orange" href="detail.jsp?num=<%=dto.getNextNum()%>">Next <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-right" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M1 8a.5.5 0 0 1 .5-.5h11.793l-3.147-3.146a.5.5 0 0 1 .708-.708l4 4a.5.5 0 0 1 0 .708l-4 4a.5.5 0 0 1-.708-.708L13.293 8.5H1.5A.5.5 0 0 1 1 8z"/>
</svg></a>
		</button>
	</div>
	<%--
	rs.getnextnum
	rs.getnextprevnum
	rs.getnum
	rs.getwriter
	rs.getcaprion
	이용하기
	 --%>
</div>
<script>
	function deleteConfirm(){
		let isDelete=confirm("글을 삭제 하시겠습니까?");
		if(isDelete){
			location.href="private/delete.jsp?num=<%=dto.getNum()%>";
		}
	}
</script>
</body>
</html>