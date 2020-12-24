<%@page import="test.member.dao.MemberDao"%>
<%@page import="test.member.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//1. 폼 전송된 파라미터 읽어 낼 때 한글 깨지지 않도록 인코딩 설정
	request.setCharacterEncoding("utf-8");
	//2. 폼 전송된 파라미터 읽어내기 (name, addr)
	String name=request.getParameter("name");
	String addr=request.getParameter("addr");
	//3. MemberDto 객체에 name 과 addr 담기
	MemberDto dto=new MemberDto();
	dto.setName(name);
	dto.setAddr(addr);
	//4. MemberDao 에 insert 메소드 만들고 
	MemberDao dao=MemberDao.getInstance();
	//5. MemberDao 객체를 이용해서 DB 에 저장
	boolean isSuccess=dao.insert(dto);
	
	//6. 클라이언트(웹브라우저)에게 응답하기
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/member/insert.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<div class="container">
	<h1>Alert</h1>
	<%if(isSuccess){ %><!-- 부호 사용법 확실히 숙지하기 헷갈림 -->
		<p class="alert alert-success">
			회원 1명의 정보를 추가했습니다.
			<a class="alert-link" href="list.jsp">확인</a>
		</p>
	<%}else{ %>
		<p class="alert alert-danger">
			회원 정보 추가 실패! 
			<a class="alert-danger" href="insertform.jsp">다시 입력하기</a>
		</p>
	<%} %>
</div>
</body>
</html>
	<!-- 
	이름을 길게 쓰면 실패됨 
	SQLException: ORA-12899: value too large for column "ACORN01"."MEMBER"."NAME" (actual: 165, maximum: 20)
	-->