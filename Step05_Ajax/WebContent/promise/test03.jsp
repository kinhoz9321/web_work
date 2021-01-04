<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/promise/test03.jsp</title>
</head>
<body>
<h1>비동기 테스트</h1>
<script>
	//p1에 담지 않고 이런 모양으로 쓸 수도 있다.
	//아래와 같은 형식으로 작성할수도 있다.
	new Promise(function(resolve, reject){
		resolve();
		console.log("resolve() 호출됨.");
	})
	.then(function(){
		console.log("then() 안에 있는 함수 호출됨.");
	})
	.catch(function(){
		console.log("catch() 안에 있는 함수 호출됨.");
	});
	/*
	test02처럼 p1에 .찍어서 then,catch 따로 하나 이렇게 연속으로 하나 똑같다.
	*/
	
	console.log("bye!");
</script>
</body>
</html>
<!-- 
콘솔창에 
bye! 가 먼저 뜨고
5초 이후에 "달리기 를 수행 완료 했습니다." 가 출력됨.

구조 먼저 익히기
 -->