<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/error/404.jsp</title>
</head>
<body>
	<p>해당 요청 페이지는 존재 하지 않습니다.</p>
	<p>${pageContext.errorData.requestURI}</p> <%-- 현재 (잘못된) 경로 출력 --%>
	<p>${pageContext.errorData.statusCode}</p> <%-- 404 에러 코드 출력 --%>
	<p>에러 메세지 : ${requestScope['javax.servlet.error.message'] }</p>
	<p>상태 코드 : ${requestScope['javax.servlet.error.status_code'] }</p>
	<p>요청한 위치 : ${requestScope['javax.servlet.error.request_uri'] }</p>
	<p>${requestScope['javax.servlet.error.exception'] }</p> <%-- 출력 메세지 없음 --%>
	<p>${requestScope['javax.servlet.error.exception_type'] }</p> <%-- 출력 메세지 없음 --%>
</body>
</html>
<%--
index.jsp 에서 아무거나 입력을 하면 404가 떠야하는데 이 페이지로 자동 forward 됨.
http://localhost:8888/Step06_Final/xxxx 주소창에 쳐보기
web.xml에서 설정해두었기 때문
--%>
