<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그 아웃은 session scope 에 저장된 id 값을 삭제 하면 된다.
	session.removeAttribute("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/logout.jsp</title>
</head>
<body>
<script>
	alert("로그아웃 되었습니다.");
	location.href="${pageContext.request.contextPath}/";
	/*
	web.xml 의 welcome 파일 리스트 때문에
	"${pageContext.request.contextPath}/" 최상위 경로 까지만 적어줘도 
	자동으로 index.jsp 페이지가 뿌려진다.
	- 대문 페이지로 가게 된다. (http://localhost:8888/Step06_Final/)
	*/
</script>
</body>
</html>