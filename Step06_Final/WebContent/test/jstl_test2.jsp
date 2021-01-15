<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>        
<%
	//테스트를 위해 sample 데이터를 request  영역에 담아 놓는다.
	List<String> names=new ArrayList<String>();
	names.add("김구라");
	names.add("해골");
	names.add("원숭이");
	request.setAttribute("list", names);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/test/jstl_test2.jsp</title>
</head>
<body>
<%
	//request 영역에 "list" 라는 키값으로 담긴 값 얻어오기
	List<String> list=(List<String>)request.getAttribute("list");
%>
<h1>친구 목록 입니다.</h1>
<ul>
	<%for(String tmp:list){ %>
		<li><%=tmp %></li>
	<%} %>
</ul>

<h1>친구 목록 입니다. (EL+JSTL 활용)</h1>
<ul>
	<c:forEach var="tmp" items="${requestScope.list }">
		<li>${tmp }</li>
	</c:forEach>
</ul>

<h1>친구 목록 입니다. 인덱스 표시</h1>
<ul>
	<c:forEach var="tmp" items="${list }" varStatus="status">
		<li data-index="${status.index }">${tmp } <strong>${status.index }</strong></li>
	</c:forEach>
</ul>

<h1>친구 목록 입니다. 순서표시</h1>
<ul>
	<c:forEach var="tmp" items="${list }" varStatus="status">
		<li data-index="${status.count }">${tmp } <strong>${status.count }</strong></li>
	</c:forEach>
</ul>

<h1>친구 목록 입니다. 첫번째 인지 여부</h1>
<ul>
	<c:forEach var="tmp" items="${list }" varStatus="status">
		<li>${tmp } <strong>첫번째 : ${status.first}</strong></li>
	</c:forEach>
</ul>

<h1>친구 목록 입니다. 마지막 인지 여부</h1>
<ul>
	<c:forEach var="tmp" items="${list }" varStatus="status">
		<li>${tmp } <strong>마지막 : ${status.last}</strong></li>
	</c:forEach>
</ul>

<a href="jstl_test3.jsp">다음예제</a>
</body>
</html>






