<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/pwd_updateform.jsp</title>
</head>
<body>
<div class="container">
	<h1>비밀번호 수정 폼</h1>
	<form action="pwd_update.jsp" method="post" id="myForm">
		<div>
			<label for="pwd">기존 비밀번호</label>
			<input type="password" name="pwd" id="pwd"/>
		</div>
		<div>
			<label for="newPwd">새 비밀번호</label>
			<input type="password" name="newPwd" id="newPwd" />
		</div>
		<div>
			<label for="newPwd2">새 비밀번호 확인</label>
			<input type="password" id="newPwd2"/>
		</div>
		<button type="submit">수정하기</button>
		<button type="reset">취소</button>
	</form>
</div>
<script>
	document.querySelector("#myForm")
	.addEventListener("submit", function(event){
		//새 비밀번호와 새 비밀번호 확인 값 읽어오기
		let pwd1=document.querySelector("#newPwd").value;
		let pwd2=document.querySelector("#newPwd2").value;
		
		//새 비밀번호와 새 비밀번호 확인이 일치하지 않으면 폼 전송을 막는다.
		if(pwd1!=pwd2){
			alert("비밀번호를 확인 하세요!");
			event.preventDefault();//폼 전송 막기
		}
		
	});
</script>
</body>
</html>
<!-- 
새로운 비밀번호가 맞는지 자바스크립트로 확인하기
기존 비밀번호는 업데이트 시점에 확인해서 맞지 않으면 수정 실패 띄우기

버튼을 누르면
폼에는 submit 이벤트가 일어남.
버튼에는 click 이벤트가 일어남.

[정리]
폼 안에 있는 submit 버튼을 누르면 submit 이벤트가 일어난다.
submit이벤트가 일어났을 때 폼 전송을 막아버리겠다.
폼 전송을 막는 방법은 preventDefault() 사용
 -->