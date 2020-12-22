<%@page import="test.member.dao.MemberDao"%>
<%@page import="test.member.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/member/update.jsp</title>
<%
	//1. 폼 전송된 파라미터 읽어 낼 때 한글 깨지지 않도록 인코딩 설정
	request.setCharacterEncoding("utf-8");
	//2. 수정할 회원의 번호, 이름, 주소 읽어오기
	int num=Integer.parseInt(request.getParameter("num"));
	String name=request.getParameter("name");
	String addr=request.getParameter("addr");
	//3. MemberDto 객체에 수정할 회원의 정보를 담기
	//4. MemberDao 에 update 메소드 만들고 
	MemberDto dto=new MemberDto();
	dto.setNum(num);
	dto.setName(name);
	dto.setAddr(addr);
	//MemberDto dto=new MemberDto(num, name, addr); 가능
	//5. MemberDao 객체를 이용해서 DB 에 수정 반영하기
	MemberDao dao=new MemberDao();
	boolean isSuccess=dao.update(dto);
	
	//6. 클라이언트(웹브라우저)에게 응답하기
%>
</head>
<body>
	<%if(isSuccess){ %><!-- 부호 사용법 확실히 숙지하기 헷갈림 -->
		<script>
			alert("<%=num%> 번 회원의 정보를 수정했습니다.");
			location.href="list.jsp";
		</script>
		<!-- script 를 쓰지 않으면  alert("수정했다!"); 라는 문자열이 출력된다. -->
	<%}else{ %>
		<script>
			alert("회원 정보 수정 실패!");
			location.href="list.jsp";
		</script>
	<%} %>
</body>
</html>