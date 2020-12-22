<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/test/send2.jsp</title>
</head>
<body>
<%
	//한글 깨지지 않게
	request.setCharacterEncoding("utf-8");
	String a=request.getParameter("msg");
	System.out.println("msg:"+a);
%>
	<p>메세지 잘 받았다 클라이언트야 send.jsp</p>
</body>
</html>
<!-- 
특별한 일이 없다면 form 전송은 post로 하는게 일반적이다
get방식은 주소창에 내가 친 목록을 줄줄 달고 간다.
ex) http://localhost:8888/Step01_Servlet/send?msg=hello

post 방식
ex) http://localhost:8888/Step01_Servlet/test/send2

Servlet은 어노테이션을 이용하고
jsp는 물리적으로 위치를 지정한다. 폴더를 만들고 안에 jsp 파일을 넣는다는 말.

jsp를 주로 쓰고
Servlet은 자주 안쓰지만
나중에는 혼용해서 써야한다.

필터를 통해서 utf-8로 한번에 바꿀 수 있다. 
 -->