<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//쿠키에 저장된 아이디와 비밀번호를 담을 변수
	String savedId="";
	String savedPwd="";
	//쿠키에 저장된 값을 위의 변수에 저장하는 코드를 작성해 보세요.
	Cookie[] cooks=request.getCookies();
	if(cooks!=null){
		//반복문 돌면서 쿠키객체를 하나씩 참조해서 
		for(Cookie tmp: cooks){
			//저장된 키값을 읽어온다.
			String key=tmp.getName();
			//만일 키값이 savedId 라면 
			if(key.equals("savedId")){
				//쿠키 value 값을 savedId 라는 지역변수에 저장
				savedId=tmp.getValue();
			}
			if(key.equals("savedPwd")){
				savedPwd=tmp.getValue();
			}
			
		}
	}
	/*
		체크한 상태에서 로그인 하면 로그인 정보가 남아있고,
		체크를 안하면 로그인 정보가 사라짐.
	*/
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/test/cookie_form3.jsp</title>
</head>
<body>
<form action="login.jsp" method="post">
	<table>
		<tr>
			<th><label for="id">아이디</label></th>
			<%-- 쿠키로 찾아서 input요소의 value로 강제로 넣어줌. --%>
			<td><input type="text" name="id" id="id" value="<%=savedId %>"/></td>
		</tr>
		<tr>
			<th><label for="pwd">비밀번호</label></th>
			<td><input type="password" name="pwd" id="pwd" value="<%=savedPwd %>"/></td>
		</tr>
		<tr>
			<td></td>
			<td>
				<label>
					<input type="checkbox" name="isSave" value="yes"/>
					로그인 정보 저장
				</label>
			</td>
		</tr>
		<tr>
			<td></td>
			<td><button type="submit">로그인</button></td>
		</tr>
	</table>
</form>
</body>
</html>