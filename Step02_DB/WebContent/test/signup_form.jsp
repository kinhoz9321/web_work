<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/test/signup_form.jsp</title>
</head>
<body>
	<h1>회원가입 폼 입니다.</h1>
	<form action="signup.jsp" method="post">
		닉네임 <input type="text" name="nick"/><br />
		이메일 수신 여부
		<label>
			<input type="radio" name="email" value="yes" checked="checked"/> 네
		</label>
		<label>
			<input type="radio" name="email" value="no"/> 아니요
		</label>
		<br />
		관심사 
		<select name="concern">
			<option value="">선택</option><!-- 선택을 안하면 빈문자열이 출력된다. -->
			<option value="game">게임</option>
			<option value="movie">영화</option>
			<option value="etc">기타</option>
		</select>
		<br />
		배우고 싶은 언어 체크<br /><!-- 체크박스는 아무것도 선택을 안하면 NullPointerException이 발생한다. -->
		<label>
			<input id="Java" type="checkbox" name="language" value="Java"/> 자바
		</label>
		<label>
			<input id="Python" type="checkbox" name="language" value="Python"/> 파이선
		</label>
		<label>
			<input id="C++" type="checkbox" name="language" value="C++"/> C++
		</label>
		<br />
		
		남기고 싶은 말<br />
		<textarea name="comment" cols="30" rows="10"></textarea>
		<br />
		<button type="submit">가입</button>
		<button type="reset">취소</button>
	</form> 
</body>
</html>