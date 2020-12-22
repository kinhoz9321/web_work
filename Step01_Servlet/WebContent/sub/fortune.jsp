<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/sub/fortune.jsp</title>
</head>
<body>
<%--필드 --%>
	<%! 
	//클래스 안에 만들어진다. 필드 혹은 메소드를 선언 가능.
	String[] list= {
			"동쪽으로 가면 2 동렬을 만나요",
			"서쪽으로 가면 3 동렬을 만나요",
			"남쪽으로 가면 4 동렬을 만나요",
			"북쪽으로 가면 5 동렬을 만나요",
			"로또를 사면 2등이 당첨되요"
		};
	
	%>
	<% 
	//ctrl+space 하면 지역목록 이 나온다.
	//jsp를 배운다는 것은 8개의 기본객체의 사용법을 배운다는 것
	/*
	8개의 객체들은 jsp.java에 지역변수로 쓰여있다. 
	servletContext - application. 이렇게 해서 쓰는 것
	ServletConfig 
	JspWriter 
	Object 
	PageContext 
	HttpServletRequest 
	HttpServletResponse 
	HttpSession - 로그인 처리
	*/
		
		//여기는 java coding 영역 입니다. 서블릿의 service() 메소드 안쪽이라고 생각하면 됩니다.
		//자바코드로 인식 import의 형태 보기 <%@ 모양
		Random ran=new Random();
		int index=ran.nextInt(5);
		String fortuneToday=list[index];
	%>
	<p>오늘의 운세 : <%=fortuneToday %></p> 
	<%-- <%=fortuneToday %> 그대로 출력. 
	그러니까 fortuneToday;, 라던지 메소드를 호출할 때 (); 등 ;를 붙이면 안된다. 
	페이지 소스보기에 다이나믹한 결과 북쪽으로 가면 ~ 만나요 --%>
	
</body>
</html>
<%-- 
주석 처리 잘 기억하기!

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
    
    이걸 제외하고는 html 페이지 같다.
    
    emmet 추가하기
    window - preferences - emmet - jsp 추가
    
    <%= 꺽퍼는 은 뭔가 참조되는 내용을 그대로 출력하고 싶을 때 사용한다.
    
    웹브라우저는 자바코드는 인식하지 못하고 html 코드만 인식한다. 

톰캣웹서버가 .jsp 요청이 들어오면 문자열을 그대로 출력하지 않는다.
문자열을 해석한 결과를 출력. (자바는 빼고)

spring frame work 를 배우면!
한달뒤에는 jsp 페이지에 자바 코딩이 사라진다. 

<%@ %>//자동완성 import, 설정
<%! %> 클래스 안에 만들어진다. 필드 혹은 메소드 선언 가능.
<%= %>//자주사용. 클라이언트 웹브라우저에 출력하고 싶을 때
<% %>//자주사용. 자바 소스코드로 해석

그냥 html로 작성한 것은 그대로 출력을 하고
%기호를 쓴 것은 해석의 결과를 출력함.

fortune.jsp(우리가 만듦) -> fortune_jsp.java(톰캣이 만듦) -> fortune_jsp.class
자바 소스코드로 바꾸고
컴파일해서 class를 만듦

C:\acorn2021\web_work\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\work\Catalina\localhost\Step01_Servlet\org\apache\jsp\sub

jsp.java 찾기
--%>
