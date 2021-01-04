<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/promise/test01.jsp</title>
</head>
<body>
<h1>비동기 테스트</h1>
<script>
	//주어진 작업을 처리 하는 함수 (주어진 작업을 처리하는데 5초가 걸린다고 가정하자)
	function work(job, callback){//callback 함수
		//5초 지연시켜서 함수 호출하기 (테스트하려고 시간을 지연시켜 봄)
		setTimeout(function(){
			console.log(job+" 을(를) 수행 완료 했습니다.");
			callback();
		}, 5000);//(function(){}, n) n초 이후에 함수 호출
	}
	/*
	work("달리기");
	work("쉬기");
	work("물마시기");
	*/
	
	//비동기지만 동기처럼 처리하기
	//1.콜백 지옥 (코드가 보기 불편함)
	/*
	work("달리기", function(){
		work("쉬기", function(){
			work("물마시기", function(){
				
			});
		});
	});
	*/
	
	//2.프로미스를 사용하면 훨씬 코드가 깔끔해진다.
	/*
	xxx
	.then(function("달리기"){});
	.then(function("쉬기"){});
	.then(function("물마시기"){});
	*/
	
	//1.Promise 객체를 생성해서 참조값을 p1
	let p1=new Promise(function(resolve){
		/*
			함수 인자로 전달되는 resolve 와 reject는 함수이다.
			resolve 는 작업을 완료 했을 때 호출하는 함수이다.
			reject 는 작업이 실패했을 때 호출 해야하는 함수
			resolve 함수가 호출되면 .then() 안에 있는 함수가 자동 호출된다.
		*/
		resolve();//then에 있는 함수가 호출되게 하기 위해서 호출. 
		//*resolve() 호출되면 then 안에 있는 함수가 호출이 된다.*
		//resolve()와 then()은 서로 관련이 되어있다.
		console.log("resolve 함수를 호출 했습니다.");
	});
	//2. p1 Promise 가 resolve 되었을 때 호출되는 함수 등록
	p1.then(function(){
		console.log("then 안에 있는 함수가 호출되었습니다.");
	});
	
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