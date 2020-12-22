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
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css"/>
<%
	//TodoDao dao=TodoDao.getInstance();
	//List<TodoDto> list=dao.getList();
	List<TodoDto> list=TodoDao.getInstance().getList();
%>
</head>
<body>
	<div class="container">
	<a href="insertform.jsp">할일 추가하기</a><!-- 상대경로 -->
	<a href="../index.jsp">인덱스 페이지로 돌아가기</a>
	<!-- "${pageContext.request.contextPath}/todo/insertform.jsp" 절대경로로 쓰면 이렇게 -->
	<h1>할일 목록 입니다.</h1>
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