<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/test/ajax01.jsp</title>
</head>
<body>
	<h1>ajax 테스트 페이지</h1>
	<p>페이지 전환 없이 javascript 로 웹 서버에 요청을 하는 방법이 있습니다.</p>
	<button id="getBtn">요청하기</button>
	<button id="getBtn2">요청하기2</button>
	<button id="getBtn3">요청하기3</button>
	<div id="result">
	
	</div>
	<script>
		document.querySelector("#getBtn").addEventListener("click",function(){
			//fetch() 함수를 이용해서 get_data.jsp 페이지에 GET 방식 요청을 한다.
			fetch("get_data.jsp").then(function(response){
				//단순 문자열인 경우 .text() 를 호출해서 리턴해주면
				//아래의 then() 안에 있는 함수의 인자로 해당 문자열이 전달된다.
				return response.text();
			})
			.then(function(data){
				//전달된 문자열 (서버가 응답한) 을 여기서 사용하면 된다.
				console.log(data);
			})
		});
		document.querySelector("#getBtn2").addEventListener("click",function(){
			//fetch() 함수를 이용해서 get_data.jsp 페이지에 GET 방식 요청을 한다.
			fetch("get_data2.jsp").then(function(response){
				//단순 문자열인 경우 .text() 를 호출해서 리턴해주면
				//아래의 then() 안에 있는 함수의 인자로 해당 문자열이 전달된다.
				return response.text();
			})
			.then(function(data){
				console.log(data);
				//응답된 문자열을 아이디가 result 인 요소에 HTML로 해석하라고 넣어주기(getBtn2 아래 div)
				document.querySelector("#result").innerHTML=data;
			});
		});
	</script>
</body>
</html>
<!-- 
fetch 최신 웹브라우저에서 가능

 -->