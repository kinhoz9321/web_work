		/*
			구라쌤이 만들어준 유틸리티
		*/
		
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
					body:toQueryString(data)
				});
			}
			return promise;
		}