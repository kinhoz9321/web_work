<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="test.util.DbcpBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    //파라미터로 전달되는 nick 을 이용해서
    String nick=request.getParameter("nick");
    
    //DB 에 저장된 내용 불러오기
    String email=null;
    String concern=null;
    String lan=null;
    String comment=null;
    
    Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try {
		conn = new DbcpBean().getConn();//DbcpBean()을 설계한다면 여기서 DB를 추출한다. 이거 빼고는 Dao 작성법과 똑같음. 
		//select 문 작성
		String sql = "SELECT email, concern, lan, comm"
				+ " FROM form_test"
				+ " WHERE nick=?";
		pstmt = conn.prepareStatement(sql);
		//? 에 바인딩 할 게 있으면 여기서 바인딩 한다.
		pstmt.setString(1, nick);
		//select 문 수행하고 ResultSet 받아오기
		rs = pstmt.executeQuery();
		//while문 혹은 if문에서 ResultSet으로부터 data 추출
		if (rs.next()) {
			email=rs.getString("email");
			concern=rs.getString("concern");
			lan=rs.getString("lan");
			comment=rs.getString("comm");
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		} catch (Exception e) {

		}
	}
	
	//lan은 null이거나 혹은 "Java" or "Java,Python" or "Java,Python,C++" ...형식의 문자열임으로 가공을 해서 사용해야 한다.
	
	String[] language=null;
	if(lan!=null){
		language=lan.split(",");//분리하는 메소드 - 분리를 해서 배열에 담아줌.
	}
	
	List<String> languageList=new ArrayList<>();
	if(language!=null){
		for(String tmp:language){
			languageList.add(tmp);
		}
	}
	
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/test/info.jsp</title>
</head>
<body>
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
</body>
</html>