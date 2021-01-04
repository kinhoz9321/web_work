<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/promise/test04.jsp</title>
</head>
<body>
<h1>비동기 테스트</h1>
<script>
	//p1에 담지 않고 이런 모양으로 쓸 수도 있다.
	//아래와 같은 형식으로 작성할수도 있다.
	new Promise(function(resolve, reject){
		//비동기 작업의 결과 데이터가 있다면
		let data={num:1, name:"김구라"};
		//resolve() 함수를 호출하면서 전달할 수 있다.
		resolve(data);//resolve 호출하면서 data 전달
		console.log("resolve() 호출됨.");
	})
	.then(function(result){
		//resolve() 함수에 전달된 값이 then() 안에 있는 함수의 인자로 전달된다.
		console.log(result)
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
resolve, reject
data
result

변수명 은 내 마음대로
 -->