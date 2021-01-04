<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/promise/test08.jsp</title>
</head>
<body>
<h1>Promise 테스트</h1><!-- 언제부터...? -->
<script>
	//Promise() 객체를 리턴해주는 함수
	function getPromise(job){
		let p1=new Promise(function(resolve, reject){
			//작업하는데 5초가 걸린다고 가정
			setTimeout(function(){
				console.log(job+" 수행함")
				resolve();
			},5000);//임의로 시간 제한 두기
		});
		return p1;
	}
	
	getPromise("달리기")
	.then(function(){
		
		return getPromise("쉬기");
	})
	.then(function(){
		return getPromise("물 마시기");
	})
	.then(function(){
		console.log("finish!");
	});
	
</script>
</body>
</html>
<!-- 
콘솔창에 순서대로 
달리기, 쉬기, 물마시기 출력
 -->