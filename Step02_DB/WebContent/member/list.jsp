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
</head>
<body>
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