<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//1. session scope 에서 로그인된 아이디 불러오기
	String id=(String)session.getAttribute("id");
	//2. 로그인된 아이디를 이용해서 DB 에서 가입정보를 불러온다.
	UsersDto dto=UsersDao.getInstance().getData(id);
	//3. 가입정보를 응답한다.
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/info.jsp</title>
</head>
<body>
<div class="container">
	<h1>가입 정보 입니다.</h1>
	<table>
		<tr>
			<th>아이디</th>
			<td><%=dto.getId() %></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><%=dto.getEmail() %></td>
		</tr>
		<tr>
			<th>가입일</th>
			<td><%=dto.getRegdate() %></td>
		</tr>
	</table>
	<!-- 이메일만 수정, 비밀번호는 따로 링크 걸기 -->
	<a href="updateform.jsp">개인 정보 수정</a>
	<!-- javascript 링크 걸기 -->
	<a href="javascript:deleteConfirm()">탈퇴</a>
</div>
<script>
	function deleteConfirm(){
		let isDelete=confirm("<%=id%> 회원님 탈퇴 하시겠습니까?");
		if(isDelete){
			location.href="${pageContext.request.contextPath}/users/private/delete.jsp";
		}
	}
</script>
</body>
</html>
<!-- 
너무 신기하당
웹프로그래밍은 DB와 밀접한 연관이 있다.
이거 분명 홈페이지 만들 때 사용한다. 기억해두기!

users에 가서 하위 폴더로 private 만들기
src test.filter 복사 붙여넣기
login filter 설정 바꾸기
web.xml 설정 추가하기

confirm() true, false 리턴
확인 = t
취소 = f

경로는 항상 절대경로로 써주는 것이 좋다. 수업이니까 상대경로로 씀. 치기 힘들어서.
 -->