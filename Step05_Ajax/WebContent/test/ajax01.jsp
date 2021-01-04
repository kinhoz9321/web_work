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
	<button id="getBtn4">요청하기4</button>
	<div id="result">
	
	</div>
	<script>
		document.querySelector("#getBtn").addEventListener("click",function(){
			//fetch() 함수를 이용해서 get_data.jsp 페이지에 GET 방식 요청을 한다.
			fetch("${pageContext.request.contextPath}/test/get_data.jsp").then(function(response){//응답객체
				//단순 문자열인 경우 .text() 를 호출해서 리턴해주면
				//아래의 then() 안에 있는 함수의 인자로 해당 문자열이 전달된다.
				return response.text();//text() 호출하면 data가 들어옴
			})
			.then(function(data){
				//전달된 문자열 (서버가 응답한) 을 여기서 사용하면 된다.
				console.log(data);
			})
		});
		/*
		"get_data.jsp" 상대경로 /test/get_data.jsp
		${pageContext.request.contextPath}/test/get_data.jsp 절대경로
		왠만하면 안헷갈리게 절대경로로 쓰는 것이 좋다. 
		절대경로의 cpath는 웹브라우저 소스보기에 그대로 출력되지 않는다. 해석된 결과를 출력한다.
		Step05_Ajax/test/get_data.jsp 이렇게.
		*/
		
		document.querySelector("#getBtn2").addEventListener("click",function(){
			//fetch() 함수를 이용해서 get_data.jsp 페이지에 GET 방식 요청을 한다.
			fetch("get_data2.jsp").then(function(response){//fetch는 promise를 리턴한다. 약속?
				//단순 문자열인 경우 .text() 를 호출해서 리턴해주면
				//아래의 then() 안에 있는 함수의 인자로 해당 문자열이 전달된다.
				return response.text();
			})
			.then(function(data){
				console.log(data);
				//응답된 문자열을 아이디가 result 인 요소에 HTML로 해석하라고 넣어주기(getBtn2 아래 div)
				document.querySelector("#result").innerHTML=data;//innerHTML
			});
		});
		/*
		innerText로 해석하라고 하면 웹브라우저에 문자열 그대로 출력해줌
		<p>부분 마크업 입니다. <a href="../index.jsp">인덱스로 가기</a></p>
		<!--
		HTML 형식의 문자열
		get_data.jsp 와의 차이점 문자열의 형식 차이
		-->
		*/
		
		document.querySelector("#getBtn3").addEventListener("click",function(){
			//fetch() 함수를 이용해서 get_data.jsp 페이지에 GET 방식 요청을 한다.
			fetch("get_data3.jsp").then(function(response){
				//JSON 문자열을 서버에서 응답했을 때는 *.json() 함수를 호출해서 리턴한다.*
				return response.json();//.text()
			})
			.then(function(data){
				//data 는 {num: , name: }형식의 object 이다. json()을 호출하면 data가 오브젝트로 바뀌어서 들어온다.
				//let data=JSON.parse(data); - text()를 하면 문자열을 오브젝트로 직접 변환해서 써야 한다.
				console.log(data);
				//p요소를 동적으로 만들어서
				let p1=document.createElement("p");
				//원하는 innerText 를 출력하고
				p1.innerText="번호:"+data.num+" 이름:"+data.name;//오브젝트로 바뀌어서 들어왔기 때문에 .찍어서 바로 호출해서 사용할 수 있다.
				//아이디가 result 인 요소에 추가하기
				document.querySelector("#result").append(p1);
			});
		});
		/*
		text() 호출과 json 호출의 차이 알아두기
		json() 을 호출하면 처음부터 data가 오브젝트로 바뀌어서 들어오고,
		text() 를 호출하면 let data=JSON.parse(data); 를 해서 문자열을 오브젝트로 직접 변환시켜서 써야한다.
		*/
		
		document.querySelector("#getBtn4").addEventListener("click",function(){
			//fetch() 함수를 이용해서 get_data.jsp 페이지에 GET 방식 요청을 한다.
			fetch("get_data4.jsp").then(function(response){
				//JSON 문자열을 서버에서 응답했을 때는 .json() 함수를 호출해서 리턴한다.
				return response.json();
			})
			.then(function(data){//data는 *자동*으로 배열로 바뀌어서 들어간다. .json이 자동으로 처리해줌.
				//제대로된 문자열이 들어가지 않으면 .json()이 자동으로 처리해주지 못해서 오류가 날 수도 있다. 
				//data 는 배열이다.
				console.log(data);
				//ul 요소를 만들어서
				let ul=document.createElement("ul");
				//반복문 돌면서
				for(let i=0; i<data.length; i++){
					//배열에 저장된 문자열을 하나씩 얻어내서
					let tmp=data[i];
					//li 요소를 만들고
					let li=document.createElement("li");
					//li 의 innerText 로 문자열을 추가하고
					li.innerText=tmp;
					//ul 요소에 누적 시키기
					ul.append(li);
				}
				//id 가 result 인 요소에 ul 를 추가하기
				document.querySelector("#result").append(ul);
			});
		});
	</script>
</body>
</html>
<!-- 
fetch 최신 웹브라우저에서 가능
- 요청하고 받는 걸 둘다 할 수 있다.

요청을 하면서도 주소창에 변화는 없다. 그래도 응답은 한다.
*** 페이지 전환 없이 서버에 요청을 날릴 수 있고, 응답되는 문자열을 활용할 여지가 있다. ***

 -->