<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/test/regular_ex2.jsp</title>
</head>
<body>
<input type="text" id="inputMsg" placeholder="하고 싶은말 입력..." 
	style="width:500px;"/>
<button id="sendBtn">전송</button>
<ul id="wordList">

</ul>
<a href="regular_ex3.jsp">다음예제</a>
<script src="${pageContext.request.contextPath }/js/jquery-3.5.1.js"></script>
<script>
	// 공백이 아닌 한글자가 1번이상 반복되는 문자열(단어)을 모두 추출할수 있는 정규표현식 객체
	/*
		g = global(전체) 의 약자 (혹은 all)
		reg1.exec(str) exec() 실행함수
		reg1.exec(str)="@" 이런 모양의 문자열이라고 생각하기 결과가 @문자열을 반환한다. 언제나?
				
		let reg1=/@/; => reg1.exec(str) 
		["@", index: 3, input: "aaa@aaa@@aaa@@@", groups: undefined] (반복)
		let reg2=/@/g; => reg2.exec(str)
		["@", index: 7, input: "aaa@aaa@@aaa@@@", groups: undefined]
		["@", index: 8, input: "aaa@aaa@@aaa@@@", groups: undefined]
		["@", index: 12, input: "aaa@aaa@@aaa@@@", groups: undefined]
		
		let str="aaa@aaa@@aaa@@@";
		
		let reg3=/!/g;
		let str2="a!aaa!!!"; => reg3.exec(str2)
		["!", index: 1, input: "a!aaa!!!", groups: undefined]
		["!", index: 5, input: "a!aaa!!!", groups: undefined]
		["!", index: 6, input: "a!aaa!!!", groups: undefined]
		["!", index: 7, input: "a!aaa!!!", groups: undefined]
		null
		
		/g는 null 이 나올때 까지 index를 알려준다.
	*/
	var reg=/[^ ]+/g;
	// 전송 버튼을 눌렀을때 호출되는 함수 등록
	$("#sendBtn").on("click", function(){
		//입력한 문자열을 읽어온다.
		var msg=$("#inputMsg").val();
		//반복문 돌면서 정규표현식에 부합되는 문자열을 모두 추출한다. *** null 이 나올때까지
		while(true){
			var result=reg.exec(msg);
			if(result==null){//더이상 없으면
				break;//반복문 탈출
			}
			//alert(result);
			//li 요소를 만들어서 단어를 출력하고 #wordList 에 추가 하기 
			$("<li/>").text(result).appendTo("#wordList");
		}
	});
</script>
</body>
</html>


