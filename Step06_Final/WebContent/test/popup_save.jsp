<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/test/popup_save.jsp</title>
</head>
<body>
<%
	//"no" 혹은 null 이다 *** 실행순서가 이 안에 들어와야 응답된다. 체크박스 체크해야지만 응답됨. 체크하지 않으면 응답이 안됨.
	String canPopup=request.getParameter("canPopup");
	//만일 팝업을 띄우지 않겠다고 체크박스를 체크를 했다면
	if(canPopup != null){
		//canPopup 이라는 키값으로 no 라는 문자열을 담고 (no라는 문자열을 사용하지는 않는다.)
		Cookie cook=new Cookie("canPopup", canPopup);
		//쿠키 유지 시간을 초단위로 담고 
		cook.setMaxAge(60);
		//쿠키가 응답될수 있도록 HttpServletResponse 객체에 담는다. cookie response 조건부로 응답하는 것. 쿠키박스 체크하면 응답할 것이고, 체크박스 체크 안하면 응답 안할것이다.
		response.addCookie(cook);
	}
%>
<script>
	//웹브라우저의 창이 닫아지도록 한다. 콘솔창에서 확인할 수 있다. 응답되자마자 창이 닫힌다고 한다.
	self.close();
</script>
</body>
</html>
<%--
쿠키가 있으면 팝업이 안뜬다.

popup 창을 주로 쿠키로 구현하고,
로그인은 세션으로 구현한다.
 --%>









