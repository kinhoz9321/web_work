<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/test/ajax06.jsp</title>
</head>
<body>
	<h1>ajax POST 전송 예제</h1>
	<p>특정 object 안에 있는 정보를 query 문자열로 변환하는 연습</p>
	<script>
		let obj1={num:1, name:"김구라", isMan:true};
		//반복문 돌면서 object 의 방의 이름을 하나씩 추출하기
		for(let key in obj1){
			//방의 이름을 이용해서 값 추출하기
			let value = obj1[key];//대괄호를 이용하면 키값으로 벨류값을 얻어낼 수 있다.
			//방의 이름 = 값 형식으로 출력해보기
			console.log(key+"="+value);
		}
		
		let animals=["cat","dog","elephant"];//배열
		//result1을 콘솔창에서 확인해 보세요.
		let result1=animals.join("&");//문자열
		
		let sample=["num=1","name=김구라","isMan=true"];
		//result2를 콘솔창에서 확인해 보세요.
		let result2=sample.join("&");
		
		//인자로 전달하는 object 를 이용해서 query 문자열을 만들어서 리턴해주는 함수를 만들어 보세요.
		function toQueryString(obj1){
			//빈 배열을 일단 만든다.
			let arr=[];
			//반복문 돌면서 obj 에 있는 정보를 "key=value" 형태로 만들어서 배열에 저장한다.
			for(let key in obj1){
				//value 는 인코딩도 해준다.
				let tmp=key+"="+encodeURIComponent(obj1[key]);
				//배열에 넣기
				arr.push(tmp);
			}
			//query 문자열을 얻어낸다.
			let queryString=arr.join("&");
			//결과를 리턴해준다.
			return queryString;
	      }
		
		//ajax 요청을 하고 Promise 객체를 리턴해주는 함수
		function ajaxPromise(url, method, data){
			//만일 필요한 값이 전달 되지 않으면 기본값을 method 와 data 에 넣어준다.
			if(method == undefined || method == null){
				method="GET";
			}
			if(data == undefined || data == null){
				data={};
			}
			//Promise 객체를 담을 변수 만들기
			let promise;
			if(method=="GET"){//만일 GET 방식 전송이면
				//fetch() 함수를 호출하고 리턴되는 Promise 객체를 변수에 담는다.
				promise=fetch(url+"?"+toQueryString(data));
			}else if(method=="POST"){//만일 POST 방식 전송이면
				//fetch() 함수를 호출하고 리턴되는 Promise 객체를 변수에 담는다.
				promise=fetch(url, {
					method:"POST",
					headers:{"Content-Type":"application/x-www-form-urlencoded; charset=utf-8"},
					body:queryString
				});
			}
			return promise;
		}
		
	</script>
</body>
</html>
<!-- 
순서는 보장할 수 없지만 반복문 돌면서 키값을 하나씩 추출할 수 있다.
키값을 문자열로 얻어내기
 obj1.num = obj1["num"]
오브젝트의 방의 이름이 변수에 담겨있을 때는 []를 사용해서 찾을 수 있다.
[]안에 문자열을 전달해야함 String 타입 ""를 붙이기도 안붙이기도 하는데 그 차이를 알아야 함.

animals.join("&") 배열에 있는 것을 &로 쭉 연결해줌
"cat&dog&elephant"

유틸리티로 바꾼다..? 나 어떻게 만드는지 몰라 알아서 오브젝트로 전달해줘
-->