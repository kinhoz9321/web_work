<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/test/ajax03.jsp</title>
</head>
<body>
	<input type="text" id="inputName" placeholder="이름 입력"/>
	<input type="text" id="inputAddr" placeholder="주소 입력"/>
	<button id="sendBtn">전송</button>
	<script>
		/*
			진짜 중요한 것 03번 꼭 공부!
			
			1. 전송 버튼을 누르면 입력한 이름과 주소를 읽어와서
			
			2. add.jsp 페이지에 ajax 전송하고
			
			3. add.jsp 페이지에서는 전송된 내용을 콘솔에 출력하고
			
			4. added! 라는 문자열을 add.jsp 페이지에서 응답하는 프로그래밍을 해보세요.
		*/
		document.querySelector("#sendBtn").addEventListener("click", function(){
			//입력한 문자열 읽어오기
			let name=document.querySelector("#inputName").value;
			let addr=document.querySelector("#inputAddr").value;
			//fetch() 함수를 호출하면서 GET 방식 파라미터로 전달하기 (GET 방식은 주소창에 달고 가는 것) *이거 하나만이라도 꼭 잘하기!*
			//주소창에 변화가 없으면서 전달. 요청도 하고, 서버에 간단한 정보도 전송할 수 있다. 주소창에 변화가 없을 뿐 나머지는 다 똑같다. get방식.
			fetch("add.jsp?name="+name+"&addr="+addr)
			//query string 쿼리 문자열 주소창에 쭉 달고 가는 문자열, fetch 함수 사용방법 (오늘의 진도 사항)
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
fetch("add.jsp?name="+name+"add.jsp?addr="+addr) => 틀린 것
fetch("add.jsp?name="+name+"&addr="+addr) => 맞는 것

add.jsp?name=x&addr=x
파라미터명 = 값 & 파라미터명2 = 값2 & …
이런 식으로 이어붙어야 한다.
 -->