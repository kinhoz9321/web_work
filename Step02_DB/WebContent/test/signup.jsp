<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    //회원가입 폼에 입력한 내용을 하나하나 모두 추출해서 콘솔창에 출력해보세요.
    //한글이 깨지지 않도록 인코딩 설정
    request.setCharacterEncoding("utf-8");
    
    //폼 전송되는 파라미터 추출
    //<input type="text" name="nick"/>에 입력한 문자열 추출
    String nick=request.getParameter("nick");
    
  	//<input type="radio" name="email" value="yes or no"/>에 선택된 값 추출
    String email=request.getParameter("email");
  	
  	//<select name="concern"/>에 선택된 option 값 추출
    String concern=request.getParameter("concern");
  	
  	//<input type="checkbox" name="language" value="Java or Python or C++"/>에 입력한 문자열 추출
  	String[] language=request.getParameterValues("language");
  	/*
  	하나의 파라미터로 여러개의 값이 들어오면 getParameterValues() 메소드를 사용하고
  	이건 String[]이다.
  	*/
  	
  	//<textarea name="comment"/>에 입력한 문자열 추출
    String comment=request.getParameter("comment");
  	
    //콘솔에 결과 출력하기
    System.out.println("nick: "+nick);
    System.out.println("email: "+email);
    System.out.println("concern: "+concern);
    System.out.println("--- language ---");
    
    //만일 체크박스를 하나라도 체크 했다면
    if(language!=null){
	    for(int i=0; i<language.length; i++){//for(String tmp:language)
			System.out.println(language[i]);
	    	//System.out.println(tmp);
	    }
    }
    
    System.out.println("comment: "+comment);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/test/signup.jsp</title>
</head>
<body>
	<h1>폼에 입력한 내용</h1>
	<form action="signup.jsp" method="post">
	
		닉네임 <input type="text" name="nick" value="<%=nick%>"/><br />
		
		<!-- 왜 yes,no 따로 2개를 만들지 않으면 radio 버튼이 하나만 넘어가는 걸까? -->
		이메일 수신 여부
		<%if(email.equals("yes")){ %>
		<label>
			<input type="radio" name="email" value="yes" checked="checked"/> 네
		</label>
		<label>
			<input type="radio" name="email" value="no"/> 아니요
		</label>
		<%}else if(email.equals("no")){ %>
		<label>
			<input type="radio" name="email" value="yes"/> 네
		</label>
		<label>
			<input type="radio" name="email" value="no" checked="checked"/> 아니요
		</label>
		<%} %>
		<br />
		
		관심사 
		<select name="concern">
		<%if(concern.equals("")){ %>
			<option value="" selected="selected">선택</option><!-- 선택을 안하면 빈문자열이 출력된다. -->
		<%}else if(concern.equals("game")){ %>
			<option value="game" selected="selected">게임</option>
		<%}else if(concern.equals("movie")){ %>
			<option value="movie" selected="selected">영화</option>
		<%}else if(concern.equals("etc")){ %>
			<option value="etc" selected="selected">기타</option>
		<%} %>
		</select>
		<br />
		
		배우고 싶은 언어 체크<br /><!-- 체크박스는 아무것도 선택을 안하면 NullPointerException이 발생한다. -->
		<label>
			<input type="checkbox" name="language" id="Java" value="Java" check="checked"/> 자바
		</label>
		<label>
			<input type="checkbox" name="language" id="Python" value="Python" check="checked"/> 파이선
		</label>
		<label>
			<input type="checkbox" name="language" id="C++" value="C++" check="checked"/> C++
		</label>
		<%for(int i=0; i<language.length; i++){
      		String name=language[i];%>
      		<script>
        	document.getElementById("<%=name%>").setAttribute("checked","checked"); 
        	/*setAttribute("checked","checked") 속성이름, 속성값*/
      		</script>      
  		<%} %>
		<br />
		
		남기고 싶은 말<br />
		<textarea name="comment" cols="30" rows="10"><%=comment%></textarea>
		<br />
	</form>
   
	<p><a href="${pageContext.request.contextPath}/index.jsp">가입을 축하합니다!</a></p>
</body>
</html>