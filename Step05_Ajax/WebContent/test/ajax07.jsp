<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/test/ajax07.jsp</title>
</head>
<body>
	<h1>ajax POST 전송 예제</h1>
	<input type="text" id="inputName" placeholder="이름 입력"/>
	<input type="text" id="inputAddr" placeholder="주소 입력"/>
	<button id="sendBtn">전송</button>
	<!-- 외부 javascript 로딩 -->
	<script src="${pageContext.request.contextPath}/js/myUtil.js"></script>
	<script>
		document.querySelector("#sendBtn").addEventListener("click", function(){
			//입력한 문자열 읽어오기
			let name=document.querySelector("#inputName").value;
			let addr=document.querySelector("#inputAddr").value;
			
			//입력한 문자열을 object에 담는다.
			let obj={name:name, addr:addr};
			//유틸리티 함수를 이용해서 ajax 요청을 하고 Promise 를 리턴 받는다.
			/*
			ajaxPromise("add.jsp","POST",obj)
			.then()
			.then();
			*/
			ajaxPromise("add.jsp", "POST", obj)
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
경험이 많은 개발자들은 자기만의 유틸리티를 많이 갖고 있을 것이다.

 -->