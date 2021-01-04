<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/signup_form.jsp</title>
</head>
<body>
	<h1>회원가입 폼 입니다.</h1>
	<form action="signup.jsp" method="post">
		<label for="id">아이디</label>
		<input type="text" name="id" id="id"/>
		<button id="checkBtn">중복 확인</button>
		<span id="result"></span>
		<br />
		<label for="pwd">비밀번호</label>
		<input type="text" name="pwd" id="pwd"/>
		<br />
		<button type="submit">가입</button>
	</form>
	<script>
		document.querySelector("#checkBtn")
		.addEventListener("click", function(event){
			event.preventDefault();//버튼을 눌렀을 때 폼 전송이 되지 않도록 막는다.
			//입력한 아이디를 서버에 *페이지 전환 없이(ajax)* 보내서 사용가능 여부를 응답 받아서 처리
			let inputId=document.querySelector("#id").value;
			//fetch 이용
			fetch("checkid.jsp?inputId="+inputId)
			.then(function(response){
				return response.json();
			})
			.then(function(data){
				//data는 {"isExist":true} or {"isExist":false} 인 object 이다.
				if(data.isExist){//이미 존재하는 아이디인 경우 (사용불가)
					document.querySelector("#result").innerText="사용불가";
				}else{//존재하지 않는 아이디인 경우 (사용가능)
					document.querySelector("#result").innerText="사용가능";
				}
			})
			.catch(function(err){
				console.log(err);
				alert("에러 발생!");
			});
		});
	</script>
</body>
</html>