<%@page import="test.member.dao.MemberDao"%>
<%@page import="test.member.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/member/updateform.jsp</title>
<%
	//1. 수정할 회원의 번호를 읽어온다
	int num=Integer.parseInt(request.getParameter("num"));
	//2. DB에서 해당회원의 정보를 얻어온다.
	MemberDto dto=new MemberDao().getData(num);
	//3. 수정 form 에 기본 값으로 넣어주면서 응답한다.
%>
</head>
<body>
	<h1>회원 정보 수정 폼 입니다.</h1>
	<form action="update.jsp" method="post">
		<!-- 아래 2줄 중요하니까 자세히 살피기! -->
		<!-- 회원정보를 수정 반영할 때 번호도 필요하기 때문에 폼 제출될 때 같이 제출되도록 한다. -->
		<input type="hidden" name="num" value="<%=dto.getNum()%>"/>
		<!-- 아래 번호는 단순 display 용도이다. -->
		번호<input type="text" value="<%=dto.getNum()%>"disabled/><br />
		
		<!-- disabled : 수정, 전송 불가. name을 넣어도 제출이 안되므로 넣을 필요도 없다. -->
		이름<input type="text" name="name" value="<%=dto.getName()%>"/><br />
		주소<input type="text" name="addr" value="<%=dto.getAddr()%>"/><br />
		<!-- 
		수정 form에 기본값은 value 속성으로 넣어준다. 
		수정하다 취소 누르면 기본값으로 돌아옴.
		-->
		
		<button type="submit">수정확인</button>
		<button type="reset">취소</button>
	</form>
</body>
</html>