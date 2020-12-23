<%@page import="test.util.DbcpBean"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.awt.event.ActionListener"%>
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
    String nick=request.getParameter("nick");//HttpServletRequest 객체를 사용
    
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
    
    //checkbox 강사님 풀이
    //체크박스의 values를 저장할 arrayList 객체 생성
    List<String> languageList=new ArrayList<>();
    
    /*
    list.add("Java");
    list.add("Python");
    list.add("C++");
    */
    
    //boolean a=list.contains("Java");
    //list의 contains() - 어떤 아이템이 있는지 없는지 boolean값을 리턴해준다.
    
    //만일 체크박스를 하나라도 체크 했다면
    if(language!=null){
	    for(int i=0; i<language.length; i++){//for(String tmp:language)
			System.out.println(language[i]);
	    	//System.out.println(tmp);
	    	languageList.add(language[i]);//list에 쌓임 (강사님 풀이 추가)
	    }
    }
    
    System.out.println("comment: "+comment);
    
    /*
    String languages="";
    if(language!=null){
       for(String str:language) {
          languages+=str;
          languages+="/";
       }
       languages=languages.substring(0,languages.length()-1);
    } else {
       languages="NULL";
    }
    */
    
    //DB에 저장하기
    //체크박스에 체크된 내용을 DB에 저장하기 위해서 가공하기 (다시 한번 살펴보기 어렵다!)
    String lan=null;
    
    if(language!=null){
    	//일단 빈문자열을 넣어주고
    	lan="";
    	for(int i=0; i<language.length; i++){
    		//만일 i 가 배열의 마지막 인덱스가 아니라면
    		if(i != language.length-1){//2?
    			// lan 에 문자열을 이어 붙이고 뒤에 , 를 붙인다.
	    		lan += language[i]+",";
    		}else{
    			//마지막 인덱스이면 lan에 문자열을 이어 붙이고 뒤에 , 는 붙이지 않는다.
    			lan += language[i];
    		}
    	}
    }
    /*
 	이해해보자
    language 의 length 는 '최대 3개' null일수도 있고, 1개일수도 있고, 2개일 수도 있다.
    java, python, c++
    
    language.length-1 = 2
    
    i!=language.length-1
    i가 2가 아니라면 (2가 아니라면? 1이나 3?)
    lan("") language+"," 붙이기
    
    i=language.length-1
    i가 2라면
    lan("") language만 출력하기
    */
    
    //1. 원래는 전송된 정보를 dto에 넣은 다음
    
    //2. Dao 를 이용해서 DB에 저장
    
	Connection conn = null;
	PreparedStatement pstmt = null;
	int flag=0;
	
	try {
		conn = new DbcpBean().getConn();//DbcpBean()을 설계한다면 여기서 DB를 추출한다. 이거 빼고는 Dao 작성법과 똑같음. 
		
		String sql = "INSERT INTO form_test(nick,email,concern,lan,comm) VALUES (?,?,?,?,?)";

		//? 에 바인딩 할 게 있으면 여기서 바인딩 한다.
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, nick);
		pstmt.setString(2, email);
		pstmt.setString(3, concern);
		pstmt.setString(4, lan);
		pstmt.setString(5, comment);
		
		flag = pstmt.executeUpdate();

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			if(pstmt!=null)pstmt.close();
			if(conn!=null)conn.close();
		} catch (Exception e2) {
			
		}
	}
    
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/test/signup.jsp</title>
</head>
<body>
	<a href="info.jsp?nick=<%=nick%>">DB 에 저장된 내용 불러오기</a>
	<h1>폼에 입력한 내용</h1>
	<form action="signup.jsp" method="post">
	
		닉네임 <input type="text" name="nick" value="<%=nick%>"/><br />
		<%-- 참조되는 내용을 그대로 클라이언트의 웹브라우저에 출력하는 방법 = <%= %> --%>
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
		
		<%--
		강사님 코드!
		
		이메일 수신 여부 -1-
		<%if(email.equals("yes")){ %>
		<label>
			<input type="radio" name="email" value="yes" checked="checked"/> 네
		</label>
		<label>
			<input type="radio" name="email" value="no"/> 아니요
		</label>
		<%}else{ %>
		<label>
			<input type="radio" name="email" value="yes"/> 네
		</label>
		<label>
			<input type="radio" name="email" value="no" checked="checked"/> 아니요
		</label>
		<%} %>
		
		if문이 있다. 조건이 true면 출력을 하고 false면 출력을 안함. (기호를 능숙히 사용하지 못해서 발견하지 못한 결과 같음.)
		<%if(){%>checked<%}%>
		
		이메일 수신 여부 -2- (이런 방법도 있다.) 연습때 적용해보기.
		<label>
			<input type="radio" name="email2" value="yes" <%if(email.equals("yes")){%>checked<%}%>/> 네
		</label>
		<label>
			<input type="radio" name="email2" value="no" <%if(email.equals("no")){%>checked<%}%>/> 아니요
		</label>
		
		이메일 수신 여부 -3- 
		-----------------------------------------------------------
		[생각해보기! 해결!]
		
		참조되는 내용을 그대로 클라이언트의 웹브라우저에 출력하는 방법 = <%= %>
		참조라는 단어에 너무 큰 의미를 부여하지 말 것.
		
		<%= %> 
		자바에서 참조값을 담은 변수의 값을 그대로 출력할 때 사용할 수도 있지만,
		속성값 자체를 참조할 때도 사용이 가능하다.
		선언된변수나 메소드의 리턴값을 외부에서 출력하기 위해 사용?
		참조되기만 하면 다 출력이 가능. 변수명을 써도 되고, 직접 값을 써도 되고!
		
		<%="" %> <%="checked" %>
		
		String a=<%="" %>
		String b=<%="checked" %>
		
		<strong><%=a %></strong> -> <strong></strong>
		<strong><%=b %></strong> -> <strong>checked</strong>
		
		<strong><%=a %></strong> = <strong><%="" %></strong>
		<strong><%=b %></strong> = <strong><%="checked" %></strong>
		-----------------------------------------------------------

		삼항연산자 사용
		<label>
			<input type="radio" name="email3" value="yes" <%=email.equals("yes") ? "checked" : "" %>/> 네
		</label>
		<label>
			<input type="radio" name="email3" value="no" <%=email.equals("no") ? "checked" : "" %>/> 아니요
		</label>
		--%>
		
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
		<%--
		삼항 연산자 사용
		<option value="game" <%=concern.equals("game") ? "selected" : ""%>>게임</option>
		<%=concern.equals("game") ? "selected" : ""%>
		--%>
		 
		배우고 싶은 언어 체크<br /><!-- 체크박스는 아무것도 선택을 안하면 NullPointerException이 발생한다. -->
		
		<%-- <%=languageList.contains("Java") ? "checked" : "" %> 삼항연산자 사용 --%>
		<label>
			<input type="checkbox" name="language" value="Java" <%=languageList.contains("Java") ? "checked" : "" %>/> 자바
		</label>
		<label>
			<input type="checkbox" name="language" value="Python" <%=languageList.contains("Python") ? "checked" : "" %>/> 파이선
		</label>
		<label>
			<input type="checkbox" name="language" value="C++" <%=languageList.contains("C++") ? "checked" : "" %>/> C++
		</label>
		
		<%--
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
		--%>
		<br />
		
		남기고 싶은 말<br />
		<textarea name="comment" cols="30" rows="10"><%=comment%></textarea>
		<br />
	</form>
   
	<p><a href="${pageContext.request.contextPath}/index.jsp">설문 조사 완료! 인덱스 돌아가기</a></p>
</body>
</html>
<!-- 
페이지 소스보기에는 안보이는 내용이 훨씬 많음!

체크 박스가 여러개라면 반복문 돌면서 하나하나 출력할 수 있게끔 하는 고려도 해보아야 한다.
 -->