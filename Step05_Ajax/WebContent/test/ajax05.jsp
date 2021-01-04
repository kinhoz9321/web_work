<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/test/ajax05.jsp</title>
</head>
<body>
	<h1>ajax POST 전송 예제</h1>
	<input type="text" id="inputName" placeholder="이름 입력"/>
	<input type="text" id="inputAddr" placeholder="주소 입력"/>
	<button id="sendBtn">전송</button>
	<script>
		document.querySelector("#sendBtn").addEventListener("click", function(){
			//입력한 문자열 읽어오기
			let name=document.querySelector("#inputName").value;
			let addr=document.querySelector("#inputAddr").value;
			//query 문자열 구성하기 value 는 인코딩을 해서 보내야 한다. encodeURIComponent(name) 약속한 기호로 보내야 함.
			let queryString="name="+encodeURIComponent(name)+"&addr="+encodeURIComponent(addr);//정석 구성
			// fetch() 함수를 이용해서 ajax POST 전송하기 (이 모양 자체를 ctrl c+v 할 것)
			/*
				[ POST ] 방식으로 전송하기 위해서는
				1. method 를 "POST"
				2. 정확한 요청 헤더 정보 제공
				3. 전송할 데이터를 query 문자열로 구성해서 요청의 몸통 (body) 에 전달한다.
				
				get방식은 add.jsp?해서 전달 이런 차이가 있다.
			*/
			//자바스크립트는 직접 이렇게 만들어줘야한다. 이걸 편하게 하기 위해서 util을 만듦.
			fetch("add.jsp", {
				method:"POST",
				headers:{"Content-Type":"application/x-www-form-urlencoded; charset=utf-8"},
				body:queryString //요청 파라미터는 바디에 달고 간다.
			})//{}안에 옵션 전달
			.then(function(response){
				return response.text();
			})
			.then(function(data){
				console.log(data);
			});
		});
	</script>
</body>
</html>
<!-- 
encodeURIComponent 
encodeURIComponent("abcd1234가")
"abcd1234%EA%B0%80"
이렇게 변환됨.
특수 기호를 인코딩해서 보내줌. 저렇게 안하면 & 특수기호가 안보내졌음.
 -->