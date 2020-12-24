<%@page import="java.util.List"%>
<%@page import="test.todo.dto.TodoDto"%>
<%@page import="test.todo.dao.TodoDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/todo/list.jsp</title>
<!-- /Step02_DB -> ${pageContext.request.contextPath} * cpath tab! * / *bootcss tab! * 전체 작성-->
<jsp:include page="../include/resource.jsp"></jsp:include>
<%
	//TodoDao dao=TodoDao.getInstance();
	//List<TodoDto> list=dao.getList();
	List<TodoDto> list=TodoDao.getInstance().getList();
%>
</head>
<body>
<%-- 
<!-- container 밖으로 navbar 빼기 -->
<nav class="navbar navbar-dark bg-primary navbar-expand-sm">
<!-- navbar-expand-sm 목록을 예쁘게 나열해줌 -->
<!-- 
	nav 요소는 div 요소에 의미를 더한 요소이다. (의미가 있는 div)
	- navigation 요소를 포함하고 있다고 알려준다.
-->
	<!-- 
	navbar 안에 새로운 div class="container" 생성 
	navbar 는 화면 전체를 차지하고 안에 내용은 container 만큼 차지해서 정렬됨.
	-->
	<div class="container">
		<!-- 
		배경색이 어두운색 계열이면 navbar-dark (밝은 색 글씨가 어울리고,)
		배경색이 밝은색 계열이면 navbar-light 클래스를 추가 해야한다. (어두운 색 글씨가 어울림)
		글자색을 결정해줌.
		 -->
		<nav class="navbar navbar-dark bg-primary navbar-expand-sm">
	<!-- navbar-expand-sm 목록을 예쁘게 나열해줌 -->
	
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
	<nav>
		<ul class="breadcrumb">
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath}">Home</a>
			</li>
			<li class="breadcrumb-item">할일목록</li>
		</ul>
	</nav>
</div>
	<div class="container">
		<button type="button" class="btn btn-outline-success"><a href="insertform.jsp">할일 추가하기</a><!-- 상대경로 --></button>
		<button type="button" class="btn btn-outline-warning"><a href="../index.jsp">인덱스 페이지로 돌아가기</a></button><br />
	<!-- "${pageContext.request.contextPath}/todo/insertform.jsp" 절대경로로 쓰면 이렇게 -->
	<table class="table">
		<thead class="table-dark">
			<tr>
				<th>번호</th>
				<th>할일</th>
				<th>날짜</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
		<!-- 이해 안되는 건 없지만 꺽퍼 쓰는 게 어렵다 연습연습! 익숙해지자! 개념을 먼저 이해하기 꺽퍼가 무엇인가 -->
			<%for(TodoDto tmp:list){%>
				<tr>
					<td><%=tmp.getNum() %></td>
					<td><%=tmp.getContent() %></td>
					<td><%=tmp.getRegdate() %></td>
					<td><a href="updateform.jsp?num=<%=tmp.getNum()%>">수정</a></td>
					<td><a href="delete.jsp?num=<%=tmp.getNum()%>">삭제</a></td>
				</tr>
			<%} %>
		</tbody>
	</table>
	</div>
</body>
</html>
<%--
[jsp 주석 <%-- 사용 <!--는 안먹음]
/Step02_DB/css/bootstrap.css
/Step02_DB/ = context path (경로)
나중에 다른 걸로 바꾸거나 없애거나 한다.
혹시 나중에 바꿔야할 수도 있기 때문에
절대경로로 /Step02_DB/ 이걸 직접 쓰지 않는다. hard coding x

jsp페이지에서는 이렇게 쓴다.
$/{pageContext.request.contextPath}/
그러면 만약 200개의 page가 이동을 하거나 해서 경로를 수정해야한다고 해도 문제가 없다.
자동으로 경로 세팅됨.

jsp페이지는 ${}를 특별하게 해석한다.

\${pageContext.request.contextPath}
$가 특별한 의미를 갖지 못하도록 \를 붙여줌

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css"/>
불러오는 문자열에 $가 있으면 앞에 \를 붙여줘야 한다.
--%>