<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/test/login.jsp</title>
</head>
<body>
<%
	//폼 전송되는 파라미터를 읽어온다.
	String id=request.getParameter("id");
	String pwd=request.getParameter("pwd");
	//체크박스를 체크 하지 않았으면 null 이다. 
	String isSave=request.getParameter("isSave");
	
	if(isSave == null){//체크 박스를 체크 안했다면
		//저장된 쿠키 삭제 
		Cookie idCook=new Cookie("savedId", id);
		idCook.setMaxAge(0);//삭제하기 위해 0 으로 설정  (삭제하는 방법)
		response.addCookie(idCook);
		
		Cookie pwdCook=new Cookie("savedPwd", pwd);
		pwdCook.setMaxAge(0);
		response.addCookie(pwdCook);
	}else{//체크 박스를 체크 했다면 
		//아이디와 비밀번호를 쿠키에 저장
		Cookie idCook=new Cookie("savedId", id); //(key, value)
		idCook.setMaxAge(60*60*24);//하루동안 유지
		response.addCookie(idCook);
		
		Cookie pwdCook=new Cookie("savedPwd", pwd);
		pwdCook.setMaxAge(60*60*24);//시간 : 초단위 ex) 60*60(1시간) 60*60*24(하루)
		response.addCookie(pwdCook);
	}
	
%>
<p> <%=id %> 님 로그인 되었습니다.</p>
<a href="cookie_form3.jsp">확인</a>
</body>
</html>
<%--
쿠키는 url당 하나의 고유한 공간이 있다.
네이버는 네이버
다음은 다음 이런 식으로.

세션에 담으면 웹브라우저 닫으면 사라짐
쿠키에 담으면 웹브라우저를 닫거나, 서버를 켰다 꺼도 살아있음.
 --%>


























